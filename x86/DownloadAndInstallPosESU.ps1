# Lista de URLs e objetivos
$downloads = @(
    @{URL = "https://download.microsoft.com/download/A/0/9/A09BC0FD-747C-4B97-8371-1A7F5AC417E9/Windows6.1-KB3102810-x86.msu"; Objetivo = "11 - (Optional) KB3108210 (x86)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/04/windows6.1-kb5013637-x86_38e65611a167a7acb7c692e351b95d374ee75579.msu"; Objetivo = "12 - (Optional) KB5013637"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/11/windows6.1-kb5020861-x86_475b218e81e20dedb69884e7c00d0a8bf36cebf9.msu"; Objetivo = "12 - (Optional) KB5020861"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/09/windows6.1-kb5017397-x86_96b91eb53575a201d59b1a2b540aa15df0d23b3a.msu"; Objetivo = "13 - (Optional) KB5017397"}
    @{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/10/windows6.1-kb4578952-x86_7246565d7fec14ad0381deac93faef3024068eb6.msu"; Objetivo = "14 - (Optional) KB4578952"}
    @{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/01/windows6.1-kb5022338-x86_490dce532d299588e11abf3790ff1600482525cd.msu"; Objetivo = "15 - (Optional) KB5022338"}
    @{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows6.1-kb5010798-x86_3c5d6092c9c3f20f3ae0333fa8f5ed12298c4e6a.msu"; Objetivo = "15 - (Optional) KB5010798"}
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
