@echo OFF
echo.
echo.
echo|set /p=Starting
.\bin\icecast.exe -v
echo Using config "icecast.xml" from installation directory ...
echo.
echo Please open http://localhost:8000 or http://127.0.0.1:8000 in your web browser to see the web interface.
.\bin\icecast.exe -c .\icecast.xml

