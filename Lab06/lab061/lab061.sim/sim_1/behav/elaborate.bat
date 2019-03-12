@echo off
set xv_path=D:\\Tools\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto c349452c960a42ddb6cc6b9a32ba63e5 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot watch2_t_behav xil_defaultlib.watch2_t xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
