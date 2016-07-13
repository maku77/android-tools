@echo off
set script="%~dp0%logcat-elapsed-time.rb"
ruby %script% %*
