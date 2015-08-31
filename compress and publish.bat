@echo off
echo Removing work.gma
del /Q work.gma
echo Creating work.gma
gmad.exe create -folder work -out work.gma
echo Check errors
pause
echo Publishing to workshop
gmpublish update -id 489006102 -addon work.gma
pause