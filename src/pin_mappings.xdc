## Clock signal #7Mhz freq (142.847ns period, 50% duty cycle)
set_property PACKAGE_PIN W5 [get_ports osc_clk]							
    set_property IOSTANDARD LVCMOS33 [get_ports osc_clk]
    create_clock -add -name sys_clk_pin -period 142.857143 -waveform {0 71.4285714} [get_ports osc_clk]

# writing to flash settings for fast load time
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

# Switches (only need 3 switches for now)
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
# set_property PACKAGE_PIN W17 [get_ports {sw[3]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
# set_property PACKAGE_PIN W15 [get_ports {sw[4]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
# set_property PACKAGE_PIN V15 [get_ports {sw[5]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
# set_property PACKAGE_PIN W14 [get_ports {sw[6]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
# set_property PACKAGE_PIN W13 [get_ports {sw[7]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
# set_property PACKAGE_PIN V2 [get_ports {sw[8]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
# set_property PACKAGE_PIN T3 [get_ports {sw[9]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
# set_property PACKAGE_PIN T2 [get_ports {sw[10]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
# set_property PACKAGE_PIN R3 [get_ports {sw[11]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
# set_property PACKAGE_PIN W2 [get_ports {sw[12]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
# set_property PACKAGE_PIN U1 [get_ports {sw[13]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
# set_property PACKAGE_PIN T1 [get_ports {sw[14]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
# set_property PACKAGE_PIN R2 [get_ports {sw[15]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
 

# LEDs (only need 3 LED's for switches, 1 for output signal)
set_property PACKAGE_PIN U16 [get_ports {led[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
# set_property PACKAGE_PIN V19 [get_ports {led[3]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
# set_property PACKAGE_PIN W18 [get_ports {led[4]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
# set_property PACKAGE_PIN U15 [get_ports {led[5]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
# set_property PACKAGE_PIN U14 [get_ports {led[6]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
# set_property PACKAGE_PIN V14 [get_ports {led[7]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
# set_property PACKAGE_PIN V13 [get_ports {led[8]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
# set_property PACKAGE_PIN V3 [get_ports {led[9]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
# set_property PACKAGE_PIN W3 [get_ports {led[10]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
# set_property PACKAGE_PIN U3 [get_ports {led[11]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
# set_property PACKAGE_PIN P3 [get_ports {led[12]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
# set_property PACKAGE_PIN N3 [get_ports {led[13]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
# set_property PACKAGE_PIN P1 [get_ports {led[14]}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
## for when center button is pressed? or could be when done (though can't see)
set_property PACKAGE_PIN L1 [get_ports {led15}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led15}]


##Buttons (use center button only for now)
set_property PACKAGE_PIN U18 [get_ports btnC]						
	set_property IOSTANDARD LVCMOS33 [get_ports btnC]
# set_property PACKAGE_PIN T18 [get_ports btnU]						
# 	set_property IOSTANDARD LVCMOS33 [get_ports btnU]
set_property PACKAGE_PIN W19 [get_ports btnL]						
	set_property IOSTANDARD LVCMOS33 [get_ports btnL]
# set_property PACKAGE_PIN T17 [get_ports btnR]						
# 	set_property IOSTANDARD LVCMOS33 [get_ports btnR]
# set_property PACKAGE_PIN U17 [get_ports btnD]						
# 	set_property IOSTANDARD LVCMOS33 [get_ports btnD]


##Pmod Header JA
#Sch name = JA1 (upper right pin)
set_property PACKAGE_PIN J1 [get_ports {JA_pin1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JA_pin1}]
##Sch name = JA2
#set_property PACKAGE_PIN L2 [get_ports {JA[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[1]}]
##Sch name = JA3
#set_property PACKAGE_PIN J2 [get_ports {JA[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[2]}]
##Sch name = JA4
#set_property PACKAGE_PIN G2 [get_ports {JA[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[3]}]
##Sch name = JA7
#set_property PACKAGE_PIN H1 [get_ports {JA[4]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[4]}]
##Sch name = JA8
#set_property PACKAGE_PIN K2 [get_ports {JA[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[5]}]
##Sch name = JA9
#set_property PACKAGE_PIN H2 [get_ports {JA[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[6]}]
##Sch name = JA10
#set_property PACKAGE_PIN G3 [get_ports {JA[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[7]}]




