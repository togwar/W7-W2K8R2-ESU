# Diretório base onde os arquivos foram baixados
$baseDir = $PSScriptRoot

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
