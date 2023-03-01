RTL_DIR := ../../rtl/e203
FILES  := $(addprefix \`include \",$(addsuffix \"\n,$(wildcard ${RTL_DIR}/*/*.v ${RTL_DIR}/*/*/*.v ../*.v)))

all:	file fpga

file:
	-rm *.v -rf
	echo -e "$(FILES)" > filelist.v

fpga:
	vivado -mode batch -source e203.tcl

clean:
	-rm -rf work vivado* *rpt *log *os *ml .Xil *.txt
