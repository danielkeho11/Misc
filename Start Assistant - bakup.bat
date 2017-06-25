@echo off
start /b cmd /c "python -m googlesamples.assistant"
timeout 2
start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "http://localhost:6006/wakeup"