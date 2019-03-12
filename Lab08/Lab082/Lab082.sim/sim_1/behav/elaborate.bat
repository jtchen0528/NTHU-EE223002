@echo off
set xv_path=D:\\Tools\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 679d8ae810f7402ab080d65104f63562 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot speaker_t_behav xil_defaultlib.speaker_t xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
