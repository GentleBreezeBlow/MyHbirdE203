default:file com sim

#for sdk
TARGET = hello
HBIRD_SDK_ROOT = ../../hbird-sdk
SRCDIRS = . src
INCDIRS = . inc
COMMON_FLAGS := -O2
include ${HBIRD_SDK_ROOT}/Build/Makefile.base

HBIRD_DIR = ../..
SIM_DIR = $(HBIRD_DIR)/sim
E203_DIR = $(HBIRD_DIR)/rtl/e203
FILES  := $(addsuffix \n,$(wildcard $(SIM_DIR)/*.sv $(SIM_DIR)/*.v $(HBIRD_DIR)/fpga/*.v ${E203_DIR}/*/*.v ${E203_DIR}/*/*/*.v))

file:
	-rm *.f -rf
	echo -e "$(FILES)" >> filelist.f
	echo -e "+incdir+$(HBIRD_DIR)/rtl/e203/core/" >> filelist.f
	echo -e "+incdir+$(HBIRD_DIR)/rtl/e203/perips/apb_i2c/" >> filelist.f
com:
	make dasm SOC=hbirdv2 BOARD=ddr200t CORE=e203 DOWNLOAD=ilm
	mv ${TARGET}.verilog main.verilog
sim:
	vcs +v2k \
	-sverilog -debug_access+all -debug_acc+dmptf -debug_region+cell+encrypt \
	-V \
	-debug_access+all \
	-f filelist.f +define+DISABLE_SV_ASSERTION +define+FPGA_SOURCE +define+SIM \
	-l vcs.log \
	-full64 \
	-cpp g++-4.8 -cc gcc-4.8 \
	-LDFLAGS -Wl,--no-as-needed \
	+sdfverbose \
	+neg_tchk \
	-negdelay \
	+no_notifier \
	-R +FSDB_DUMP|tee sim.log
deb:
	verdi -f filelist.f -autoalias  -nologo -workMode hardwareDebug -sv -top tb -ssf *.fsdb &
clean_all:
	make clean
	rm -rf ./csrc *.log *.key ucli* *.fsdb *.conf *.rc ./verdiLog *.err *.vdb ./both ./DVEfiles ./simv.daidir simv *.ini *.bin *.hex *.lst *.o *.map sim*
