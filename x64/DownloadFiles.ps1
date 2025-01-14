# Lista de URLs e objetivos
$downloads = @(
    @{URL = "https://catalog.s.download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x64_c3516bc5c9e69fee6d9ac4f981f5b95977a8a2fa.exe"; Objetivo = "01 - Windows 7 Service Pack 1 (x64)"},
    @{URL = "https://download.microsoft.com/download/0/4/7/0473DB9B-16DE-41C6-A02A-4CBEEB04E777/Windows6.1-KB3004394-v2-x64.msu"; Objetivo = "02 - Root Certificate Update (x64)"},
    @{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/03/windows6.1-kb4490628-x64_3cdb3df55b9cd7ef7fcb24fc4e237ea287ad0992.msu"; Objetivo = "03 - Servicing Stack Update - March 2019 (x64)"}
	@{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2019/09/windows6.1-kb4474419-v3-x64_0f687d50402790f340087c576886501b3223bec6.msu"; Objetivo = "04 - SHA-2 Code Signing Support Update - September 2019 (x64)"}
	@{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/01/windows6.1-kb4536952-x64_f3b49481187651f64f13a0369c86ad7caa83b190.msu"; Objetivo = "05 - Servicing Stack Update (x64)"}
	@{URL = "http://download.windowsupdate.com/windowsupdate/redist/standalone/7.6.7600.320/WindowsUpdateAgent-7.6-x64.exe"; Objetivo = "06 - Windows Update Agent (x64)"}
	@{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2016/07/windows6.1-kb3179573-x64_e972000ff6074d1b0530d1912d5f3c7d1b057c4a.msu"; Objetivo = "07 - Speedup Patches - Update Rollup (x64)"}
	@{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2020/04/windows6.1-kb4555449-x64_36683b4af68408ed268246ee3e89772665572471.msu"; Objetivo = "08 - Latest Extended Servicing Stack Update - May 2020 (x64)"}
	@{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/07/windows6.1-kb4575903-x64_5905c774f806205b5d25b04523bb716e1966306d.msu"; Objetivo = "09 - ESU Licensing Preparation Package (x64)"}
	@{URL = "https://download.microsoft.com/download/A/0/9/A09BC0FD-747C-4B97-8371-1A7F5AC417E9/Windows6.1-KB3102810-x64.msu"; Objetivo = "11 - (Optional) KB3108210 (x64)"}
	@{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/04/windows6.1-kb5013637-x64_38e65611a167a7acb7c692e351b95d374ee75579.msu"; Objetivo = "12 - (Optional) KB5013637"}
	@{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/11/windows6.1-kb5020861-x64_475b218e81e20dedb69884e7c00d0a8bf36cebf9.msu"; Objetivo = "12 - (Optional) KB5020861"}
	@{URL = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/09/windows6.1-kb5017397-x64_96b91eb53575a201d59b1a2b540aa15df0d23b3a.msu"; Objetivo = "13 - (Optional) KB5017397"}
	@{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2020/10/windows6.1-kb4578952-x64_7246565d7fec14ad0381deac93faef3024068eb6.msu"; Objetivo = "14 - (Optional) KB4578952"}
	@{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/01/windows6.1-kb5022338-x64_490dce532d299588e11abf3790ff1600482525cd.msu"; Objetivo = "15 - (Optional) KB5022338"}
	@{URL = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows6.1-kb5010798-x64_3c5d6092c9c3f20f3ae0333fa8f5ed12298c4e6a.msu"; Objetivo = "15 - (Optional) KB5010798"}
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
