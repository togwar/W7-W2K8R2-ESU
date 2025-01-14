# Lista de URLs e objetivos
$downloads = @(
    @{URL = "https://catalog.s.download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x86_c3516bc5c9e69fee6d9ac4f981f5b95977a8a2fa.exe"; Objetivo = "01 - Windows 7 Service Pack 1 (x86)"},
    @{URL = "https://download.microsoft.com/download/0/4/7/0473DB9B-16DE-41C6-A02A-4CBEEB04E777/Windows6.1-KB3004394-v2-x86.msu"; Objetivo = "02 - Root Certificate Update (x86)"},
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/03/windows6.1-kb4490628-x86_3cdb3df55b9cd7ef7fcb24fc4e237ea287ad0992.msu"; Objetivo = "03 - Servicing Stack Update - March 2019 (x86)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4474419-v3-x86_0f687d50402790f340087c576886501b3223bec6.msu"; Objetivo = "04 - SHA-2 Code Signing Support Update - September 2019 (x86)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/01/windows6.1-kb4536952-x86_f3b49481187651f64f13a0369c86ad7caa83b190.msu"; Objetivo = "05 - Servicing Stack Update (x86)"}
    @{URL = "https://download.windowsupdate.com/windowsupdate/redist/standalone/7.6.7600.320/WindowsUpdateAgent-7.6-x86.exe"; Objetivo = "06 - Windows Update Agent (x86)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2016/07/windows6.1-kb3179573-x86_e972000ff6074d1b0530d1912d5f3c7d1b057c4a.msu"; Objetivo = "07 - Speedup Patches - Update Rollup (x86)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/04/windows6.1-kb4555449-x86_36683b4af68408ed268246ee3e89772665572471.msu"; Objetivo = "08 - Latest Extended Servicing Stack Update - May 2020 (x86)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/07/windows6.1-kb4575903-x86_5905c774f806205b5d25b04523bb716e1966306d.msu"; Objetivo = "09 - ESU Licensing Preparation Package (x86)"}
)

# Diretório base para salvar os arquivos
#$baseDir = "C:\DownloadsAtividades"
$baseDir = $PSScriptRoot

# Verifica e cria o diretório base, se necessário
if (-not (Test-Path -Path $baseDir)) {
    New-Item -ItemType Directory -Path $baseDir
}

# Lista para armazenar tarefas
$jobs = @()

foreach ($item in $downloads) {
    $url = $item.URL
    $objetivo = $item.Objetivo

    # Cria a pasta para o objetivo
    $objetivoPath = Join-Path -Path $baseDir -ChildPath $objetivo
    if (-not (Test-Path -Path $objetivoPath)) {
        New-Item -ItemType Directory -Path $objetivoPath | Out-Null
    }

    # Nome do arquivo a partir da URL
    $fileName = Split-Path -Path $url -Leaf
    $filePath = Join-Path -Path $objetivoPath -ChildPath $fileName

    # Inicia um trabalho paralelo para download
    $job = Start-Job -ScriptBlock {
        param($url, $filePath)
        try {
            Invoke-WebRequest -Uri $url -OutFile $filePath -ErrorAction Stop
        } catch {
            Write-Host "Erro ao baixar: $url"
        }
    } -ArgumentList $url, $filePath

    # Adiciona o trabalho à lista
    $jobs += $job
}



# Monitora os trabalhos
Write-Host "Aguardando a conclusão dos downloads..."
$progress = 0
$totalJobs = $jobs.Count
while ($jobs.State -contains 'Running') {
    Start-Sleep -Seconds 1
    $completed = $jobs | Where-Object { $_.State -eq 'Completed' } | Measure-Object
    $progress = ($completed.Count / $totalJobs) * 100
    Write-Progress -Activity "Baixando arquivos" `
                   -Status "$progress% concluído" `
                   -PercentComplete $progress
}

# Finaliza os trabalhos e limpa
Receive-Job -Job $jobs | Out-Null
Remove-Job -Job $jobs

Write-Host "Todos os downloads foram concluídos!"

Write-Host "Iniciando a instalação silenciosa"

# Obtém todas as pastas de objetivos
$folders = Get-ChildItem -Path $baseDir -Directory

# Variável para monitorar erros
$errors = @()

# Função para instalar arquivos
function Install-Update {
    param (
        [string]$FilePath
    )

    Write-Host "Instalando: $FilePath" -ForegroundColor Cyan
    try {
        # Instala pacotes .msu
        if ($FilePath -like "*.msu") {
            Start-Process "wusa.exe" -ArgumentList "/quiet /norestart `"$FilePath`"" -Wait -NoNewWindow
        }
        # Instala executáveis (.exe)
        elseif ($FilePath -like "*.exe") {
            Start-Process $FilePath -ArgumentList "/quiet /norestart" -Wait -NoNewWindow
        } else {
            Write-Warning "Tipo de arquivo não suportado: $FilePath"
        }
    } catch {
        Write-Warning "Erro ao instalar: $FilePath"
        $errors += $FilePath
    }
}

# Itera por todas as pastas e instala os arquivos
foreach ($folder in $folders) {
    Write-Host "Processando pasta: $($folder.FullName)" -ForegroundColor Yellow

    # Busca arquivos .msu ou .exe na pasta
    $files = Get-ChildItem -Path $folder.FullName -File -Include *.msu, *.exe

    foreach ($file in $files) {
        Install-Update -FilePath $file.FullName
    }
}

# Verifica se houve erros
if ($errors.Count -gt 0) {
    Write-Host "Alguns arquivos falharam na instalação:" -ForegroundColor Red
    foreach ($error in $errors) {
        Write-Host $error -ForegroundColor Red
    }
} else {
    Write-Host "Todas as atualizações foram instaladas com sucesso!" -ForegroundColor Green
}

# Reinicialização opcional
if ((Read-Host "Deseja reiniciar o sistema agora? (S/N)").ToUpper() -eq "S") {
    Restart-Computer -Force
} else {
    Write-Host "O sistema não será reiniciado. Reinicie manualmente após aplicar todas as atualizações." -ForegroundColor Yellow
}
