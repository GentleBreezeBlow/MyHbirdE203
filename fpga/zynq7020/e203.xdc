# -------------------------------------------------------------------
# Clock
# -------------------------------------------------------------------
create_clock -period 20.000 [get_ports CLK50MHZ]
set_property PACKAGE_PIN U18 [get_ports CLK50MHZ]
set_property IOSTANDARD LVCMOS33 [get_ports CLK50MHZ]

# -------------------------------------------------------------------
# RST_n
# -------------------------------------------------------------------
set_property IOSTANDARD LVCMOS33 [get_ports RESETN]
set_property PACKAGE_PIN T10 [get_ports RESETN]
set_property PULLUP true [get_ports RESETN]

# -------------------------------------------------------------------
# Debug/JTAG J12 TCK-3 TDI-5 TDO-7 TMS-9
# -------------------------------------------------------------------
set_property IOSTANDARD LVCMOS33 [get_ports  JTAG_TCK]
set_property IOSTANDARD LVCMOS33 [get_ports  JTAG_TDI]
set_property IOSTANDARD LVCMOS33 [get_ports  JTAG_TDO]
set_property IOSTANDARD LVCMOS33 [get_ports  JTAG_TMS]
set_property PACKAGE_PIN D18 [get_ports JTAG_TCK]
set_property PACKAGE_PIN F16 [get_ports JTAG_TDI]
set_property PACKAGE_PIN G19 [get_ports JTAG_TDO]
set_property PACKAGE_PIN J18 [get_ports JTAG_TMS]
set_property PULLUP true [get_ports JTAG_TDI]
set_property PULLUP true [get_ports JTAG_TDO]
set_property KEEPER true [get_ports JTAG_TMS]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets JTAG_TCK]

# -------------------------------------------------------------------
# GPIOA
# -------------------------------------------------------------------
set_property IOSTANDARD LVCMOS33 [get_ports GPIOA[*]]

set_property PACKAGE_PIN W20 [get_ports GPIOA[ 0]]
set_property PACKAGE_PIN U14 [get_ports GPIOA[ 1]]
set_property PACKAGE_PIN U17 [get_ports GPIOA[ 2]]
set_property PACKAGE_PIN P20 [get_ports GPIOA[ 3]]
set_property PACKAGE_PIN V13 [get_ports GPIOA[ 4]]
set_property PACKAGE_PIN V12 [get_ports GPIOA[ 5]]
set_property PACKAGE_PIN H18 [get_ports GPIOA[ 6]]
set_property PACKAGE_PIN V18 [get_ports GPIOA[ 7]]
set_property PACKAGE_PIN K18 [get_ports GPIOA[ 8]]
set_property PACKAGE_PIN K17 [get_ports GPIOA[ 9]]
set_property PACKAGE_PIN H20 [get_ports GPIOA[10]]
set_property PACKAGE_PIN J20 [get_ports GPIOA[11]]
set_property PACKAGE_PIN T14 [get_ports GPIOA[12]]
set_property PACKAGE_PIN T15 [get_ports GPIOA[13]]
set_property PACKAGE_PIN F19 [get_ports GPIOA[14]]
set_property PACKAGE_PIN F20 [get_ports GPIOA[15]]
set_property PACKAGE_PIN U15 [get_ports GPIOA[16]]
set_property PACKAGE_PIN Y14 [get_ports GPIOA[17]]
set_property PACKAGE_PIN N18 [get_ports GPIOA[18]]
set_property PACKAGE_PIN Y16 [get_ports GPIOA[19]]
set_property PACKAGE_PIN W15 [get_ports GPIOA[20]]
set_property PACKAGE_PIN N20 [get_ports GPIOA[21]]
set_property PACKAGE_PIN T16 [get_ports GPIOA[22]]
set_property PACKAGE_PIN P19 [get_ports GPIOA[23]]
set_property PACKAGE_PIN Y17 [get_ports GPIOA[24]]
set_property PACKAGE_PIN V15 [get_ports GPIOA[25]]
set_property PACKAGE_PIN U12 [get_ports GPIOA[26]]
set_property PACKAGE_PIN T11 [get_ports GPIOA[27]]
set_property PACKAGE_PIN W13 [get_ports GPIOA[28]]
set_property PACKAGE_PIN T12 [get_ports GPIOA[29]]
set_property PACKAGE_PIN L15 [get_ports GPIOA[30]]
set_property PACKAGE_PIN R14 [get_ports GPIOA[31]]

# -------------------------------------------------------------------
# GPIOB
# -------------------------------------------------------------------
set_property IOSTANDARD LVCMOS33 [get_ports GPIOB[*]]

set_property PACKAGE_PIN R19 [get_ports GPIOB[ 0]]
set_property PACKAGE_PIN V20 [get_ports GPIOB[ 1]]
set_property PACKAGE_PIN W19 [get_ports GPIOB[ 2]]
set_property PACKAGE_PIN W18 [get_ports GPIOB[ 3]]
set_property PACKAGE_PIN H15 [get_ports GPIOB[ 4]]
set_property PACKAGE_PIN K14 [get_ports GPIOB[ 5]]
set_property PACKAGE_PIN M17 [get_ports GPIOB[ 6]]
set_property PACKAGE_PIN B19 [get_ports GPIOB[ 7]]
set_property PACKAGE_PIN C20 [get_ports GPIOB[ 8]]
set_property PACKAGE_PIN D19 [get_ports GPIOB[ 9]]
set_property PACKAGE_PIN E18 [get_ports GPIOB[10]]
set_property PACKAGE_PIN J14 [get_ports GPIOB[11]]
set_property PACKAGE_PIN M18 [get_ports GPIOB[12]]
set_property PACKAGE_PIN A20 [get_ports GPIOB[13]]
set_property PACKAGE_PIN B20 [get_ports GPIOB[14]]
set_property PACKAGE_PIN D20 [get_ports GPIOB[15]]
set_property PACKAGE_PIN T17 [get_ports GPIOB[16]]
set_property PACKAGE_PIN N17 [get_ports GPIOB[17]]
set_property PACKAGE_PIN P18 [get_ports GPIOB[18]]
set_property PACKAGE_PIN P15 [get_ports GPIOB[19]]
set_property PACKAGE_PIN P16 [get_ports GPIOB[20]]
set_property PACKAGE_PIN L20 [get_ports GPIOB[21]]
set_property PACKAGE_PIN L19 [get_ports GPIOB[22]]
set_property PACKAGE_PIN M20 [get_ports GPIOB[23]]
set_property PACKAGE_PIN M19 [get_ports GPIOB[24]]
set_property PACKAGE_PIN R18 [get_ports GPIOB[25]]
set_property PACKAGE_PIN U20 [get_ports GPIOB[26]]
set_property PACKAGE_PIN T20 [get_ports GPIOB[27]]
set_property PACKAGE_PIN K16 [get_ports GPIOB[28]]
set_property PACKAGE_PIN J16 [get_ports GPIOB[29]]
set_property PACKAGE_PIN L16 [get_ports GPIOB[30]]
set_property PACKAGE_PIN L17 [get_ports GPIOB[31]]

# -------------------------------------------------------------------
# PMU
# -------------------------------------------------------------------
set_property IOSTANDARD LVCMOS33 [get_ports PMU_PADRST]
set_property IOSTANDARD LVCMOS33 [get_ports PMU_PADEN]
set_property PACKAGE_PIN R16 [get_ports PMU_PADRST]
set_property PACKAGE_PIN W14 [get_ports PMU_PADEN]
