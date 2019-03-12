@echo off
set xv_path=D:\\Tools\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim lab034_t_behav -key {Behavioral:sim_1:Functional:lab034_t} -tclbatch lab034_t.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0