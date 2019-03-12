set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

set_property PACKAGE_PIN T17 [get_ports {rst_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]

set_property PACKAGE_PIN A14 [get_ports {audio_mclk}]

set_property PACKAGE_PIN A16 [get_ports {audio_lrck}]

set_property PACKAGE_PIN B15 [get_ports {audio_sck}]

set_property PACKAGE_PIN B16 [get_ports {audio_sdin}]


set_property SEVERITY {Warning} [get_drc_checks NSTD-1]

set_property SEVERITY {Warning} [get_drc_checks UCIO-1]