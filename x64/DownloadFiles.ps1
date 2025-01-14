# Lista de URLs e objetivos
$downloads = @(
    @{URL = "https://catalog.s.download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x64_74865ef2562006e51d7f9333b4a8d45b7a749dab.exe"; Objetivo = "01 - Windows 7 Service Pack 1 (x64)"},
    @{URL = "https://download.microsoft.com/download/7/5/0/750698D5-74F3-48B5-A2BE-8564F68890CC/Windows6.1-KB3004394-v2-x64.msu"; Objetivo = "02 - Root Certificate Update (x64)"},
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/03/windows6.1-kb4490628-x64_d3de52d6987f7c8bdc2c015dca69eac96047c76e.msu"; Objetivo = "03 - Servicing Stack Update - March 2019 (x64)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4474419-v3-x64_b5614c6cea5cb4e198717789633dca16308ef79c.msu"; Objetivo = "04 - SHA-2 Code Signing Support Update - September 2019 (x64)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/01/windows6.1-kb4536952-x64_87f81056110003107fa0e0ec35a3b600ef300a14.msu"; Objetivo = "05 - Servicing Stack Update (x64)"}
    @{URL = "https://download.windowsupdate.com/windowsupdate/redist/standalone/7.6.7600.320/WindowsUpdateAgent-7.6-x64.exe"; Objetivo = "06 - Windows Update Agent (x64)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2016/07/windows6.1-kb3179573-x64_0ec541490b3f7b02e41f26cb2c444cbd9e13df4d.msu"; Objetivo = "07 - Speedup Patches - Update Rollup (x64)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/04/windows6.1-kb4555449-x64_92202202c3dee2f713f67adf6622851b998c6780.msu"; Objetivo = "08 - Latest Extended Servicing Stack Update - May 2020 (x64)"}
    @{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/07/windows6.1-kb4575903-x64_b4d5cf045a03034201ff108c2802fa6ac79459a1.msu"; Objetivo = "09 - ESU Licensing Preparation Package (x64)"}
    @{URL = "https://download.microsoft.com/download/F/A/A/FAABD5C2-4600-45F8-96F1-B25B137E3C87/Windows6.1-KB3102810-x64.msu"; Objetivo = "11 - (Optional) KB3108210 (x64)"}
    @{URL = "https"; Objetivo = "12 - (Optional) KB5013637"}
    @{URL = "https"; Objetivo = "12 - (Optional) KB5020861"}
    @{URL = "https"; Objetivo = "13 - (Optional) KB5017397"}
    @{URL = "https"; Objetivo = "14 - (Optional) KB4578952"}
    @{URL = "https"; Objetivo = "15 - (Optional) KB5022338"}
    @{URL = "https"; Objetivo = "15 - (Optional) KB5010798"}
)

# Diretório base para salvar os arquivos
#$baseDir = "C:\DownloadsAtividades"
$baseDir = $PSScriptRoot

# Verifica e cria o diretório base, se necessário
if (-not (Test-Path -Path $baseDir)) {
    New-Item -ItemType Directory -Path $baseDir
}

foreach ($item in $downloads) {
    $url = $item.URL
    $objetivo = $item.Objetivo

    # Cria a pasta para o objetivo
    $objetivoPath = Join-Path -Path $baseDir -ChildPath $objetivo
    if (-not (Test-Path -Path $objetivoPath)) {
        New-Item -ItemType Directory -Path $objetivoPath
    }

    # Nome do arquivo a partir da URL
    $fileName = Split-Path -Path $url -Leaf

    # Caminho completo para salvar o arquivo
    $filePath = Join-Path -Path $objetivoPath -ChildPath $fileName

    # Faz o download do arquivo
    try {
        Invoke-WebRequest -Uri $url -OutFile $filePath
        Write-Host "Arquivo baixado com sucesso: $filePath"
    } catch {
        Write-Host "Erro ao baixar o arquivo: $url"
    }
}
