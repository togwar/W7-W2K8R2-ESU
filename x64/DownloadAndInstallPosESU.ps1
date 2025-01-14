# Lista de URLs e objetivos
$downloads = @(
    @{URL = "https://download.microsoft.com/download/F/A/A/FAABD5C2-4600-45F8-96F1-B25B137E3C87/Windows6.1-KB3102810-x64.msu"; Objetivo = "11 - (Optional) KB3108210 (x64)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/04/windows6.1-kb5013637-x64_9adc2154ff84511c2dd3aeebab9594999b5c7297.msu"; Objetivo = "12 - (Optional) KB5013637"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/11/windows6.1-kb5020861-x64_9df527e79d8854a4ed1b8fe26c2a66bca7d6b8da.msu"; Objetivo = "12 - (Optional) KB5020861"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/09/windows6.1-kb5017397-x64_2a9999bd20cb964869c59bb16841a76e14030a29.msu"; Objetivo = "13 - (Optional) KB5017397"}
    @{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/10/windows6.1-kb4578952-x64_30ac0df8554c2647017f3b36cc02e833a3187364.msu"; Objetivo = "14 - (Optional) KB4578952"}
    @{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/01/windows6.1-kb5022338-x64_75d100c03bcaee4b62d08004cc382337ed09d327.msu"; Objetivo = "15 - (Optional) KB5022338"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2022/01/windows6.1-kb5010798-x64_6f690ddb42ab85d3dcac7e6b34e16eb70df6e477.msu"; Objetivo = "15 - (Optional) KB5010798"}
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
