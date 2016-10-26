@echo off
::netsh wlan set hostednetwork mode=allow ssid="cxxxx{}::::::::::::::::::::::::>" key=23456789
::"( . )Y( . )"
::"( . )( . )"
netsh wlan start hostednetwork
cls
netsh wlan show hostednetwork
timeout 3