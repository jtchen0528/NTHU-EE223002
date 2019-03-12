set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

set_property PACKAGE_PIN V17 [get_ports {rst_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]

set_property PACKAGE_PIN W19 [get_ports {in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[0]}]
set_property PACKAGE_PIN U18 [get_ports {in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[1]}]
set_property PACKAGE_PIN T17 [get_ports {in[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[2]}]

set_property PACKAGE_PIN T18 [get_ports {invol[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {invol[1]}]
set_property PACKAGE_PIN U17 [get_ports {invol[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {invol[0]}]

set_property PACKAGE_PIN A14 [get_ports {audio_mclk}]

set_property PACKAGE_PIN A16 [get_ports {audio_lrck}]

set_property PACKAGE_PIN B15 [get_ports {audio_sck}]

set_property PACKAGE_PIN B16 [get_ports {audio_sdin}]

set_property PACKAGE_PIN W7 [get_ports {display[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {display[0]}]
set_property PACKAGE_PIN W6 [get_ports {display[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {display[1]}]
set_property PACKAGE_PIN U8 [get_ports {display[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {display[2]}]
set_property PACKAGE_PIN V8 [get_ports {display[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {display[3]}]
set_property PACKAGE_PIN U5 [get_ports {display[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {display[4]}]
set_property PACKAGE_PIN V5 [get_ports {display[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {display[5]}]
set_property PACKAGE_PIN U7 [get_ports {display[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {display[6]}]
set_property PACKAGE_PIN V7 [get_ports {display[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {display[7]}]

set_property PACKAGE_PIN W4 [get_ports {ssd_ctl[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[3]}]
set_property PACKAGE_PIN V4 [get_ports {ssd_ctl[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[2]}]
set_property PACKAGE_PIN U4 [get_ports {ssd_ctl[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[1]}]
set_property PACKAGE_PIN U2 [get_ports {ssd_ctl[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[0]}]


set_property SEVERITY {Warning} [get_drc_checks NSTD-1]

set_property SEVERITY {Warning} [get_drc_checks UCIO-1]