@echo off
netsh wlan set hostednetwork mode=allow ssid="Connectify-sky" key=23456789
netsh wlan start hostednetwork
cls
netsh wlan show hostednetwork
timeout 3