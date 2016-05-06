
:: Bruce Emehiser
:: 2016 03 31
:: Simple compile and run batch file
:: used when working with Verilog

:: Set the file name without the ".v" file extension
set fileName=onebit

:: compile the verilog file
iverilog -o %fileName% %fileName%.v

:: run the compiled file
vvp %fileName%