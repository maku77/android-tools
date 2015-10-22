@echo off
set script="%~dp0%android-list-apks.rb"
ruby %script% %*

