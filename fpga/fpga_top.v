//-----------------------------------------------------------------------------
// Author       : 
// Filename     : fpga top
// Date         : 2022/03/21 13:56:53
// 
// Revision     : 1.0
// Purpose      : 
// Reference    : 
//-----------------------------------------------------------------------------
module fpga_top (
    /*AUTOARG*/
   // Outputs
   PMU_PADRST, PMU_PADEN,
   // Inouts
   GPIOA, GPIOB, JTAG_TDO,
   // Inputs
   CLK50MHZ, RESETN, JTAG_TCK, JTAG_TDI, JTAG_TMS
   );

    input CLK50MHZ;
    input RESETN;

    inout [31:0] GPIOA;
    inout [31:0] GPIOB;

    input JTAG_TCK;
    input JTAG_TDI;
    input JTAG_TMS;
    inout JTAG_TDO;

    output PMU_PADRST;
    output PMU_PADEN;

    wire [31:0] io_pads_gpioA_i_ival;
    wire [31:0] io_pads_gpioB_i_ival;
    wire io_pads_jtag_TCK_i_ival;
    wire io_pads_jtag_TMS_i_ival;
    wire io_pads_jtag_TDI_i_ival;
    wire rst_n;
    wire hfextclk;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		hfxoscen;		// From u_e203 of e203_soc_top.v
    wire		io_pads_aon_pmu_padrst_o_oval;// From u_e203 of e203_soc_top.v
    wire		io_pads_aon_pmu_vddpaden_o_oval;// From u_e203 of e203_soc_top.v
    wire [31:0]		io_pads_gpioA_o_oe;	// From u_e203 of e203_soc_top.v
    wire [31:0]		io_pads_gpioA_o_oval;	// From u_e203 of e203_soc_top.v
    wire [31:0]		io_pads_gpioB_o_oe;	// From u_e203 of e203_soc_top.v
    wire [31:0]		io_pads_gpioB_o_oval;	// From u_e203 of e203_soc_top.v
    wire		io_pads_jtag_TDO_o_oe;	// From u_e203 of e203_soc_top.v
    wire		io_pads_jtag_TDO_o_oval;// From u_e203 of e203_soc_top.v
    wire		io_pads_qspi0_cs_0_o_oval;// From u_e203 of e203_soc_top.v
    wire		io_pads_qspi0_dq_0_o_oe;// From u_e203 of e203_soc_top.v
    wire		io_pads_qspi0_dq_0_o_oval;// From u_e203 of e203_soc_top.v
    wire		io_pads_qspi0_dq_1_o_oe;// From u_e203 of e203_soc_top.v
    wire		io_pads_qspi0_dq_1_o_oval;// From u_e203 of e203_soc_top.v
    wire		io_pads_qspi0_dq_2_o_oe;// From u_e203 of e203_soc_top.v
    wire		io_pads_qspi0_dq_2_o_oval;// From u_e203 of e203_soc_top.v
    wire		io_pads_qspi0_dq_3_o_oe;// From u_e203 of e203_soc_top.v
    wire		io_pads_qspi0_dq_3_o_oval;// From u_e203 of e203_soc_top.v
    wire		io_pads_qspi0_sck_o_oval;// From u_e203 of e203_soc_top.v
    wire		lfxoscen;		// From u_e203 of e203_soc_top.v
    // End of automatics


    //----------------------------
    // PAD
    //----------------------------
    assign rst_n = RESETN;
    
    PAD PAD_GPIOA[31:0](
        .I        ( io_pads_gpioA_o_oval ),
        .IO       ( GPIOA  ),
        .O        ( io_pads_gpioA_i_ival ),
        .en       ( io_pads_gpioA_o_oe   )
    );
    PAD PAD_GPIOB[31:0](
        .I        ( io_pads_gpioB_o_oval ),
        .IO       ( GPIOB  ),
        .O        ( io_pads_gpioB_i_ival ),
        .en       ( io_pads_gpioB_o_oe   )
    );
    
    assign io_pads_jtag_TCK_i_ival = JTAG_TCK;
    assign io_pads_jtag_TDI_i_ival = JTAG_TDI;
    assign io_pads_jtag_TMS_i_ival = JTAG_TMS;
    
    PAD PAD_JTAG_TDO(
        .I        ( io_pads_jtag_TDO_o_oval ),
        .IO       ( JTAG_TDO ),
        .O        (   ),
        .en       ( io_pads_jtag_TDO_o_oe   )
    );

    assign PMU_PADRST = io_pads_aon_pmu_padrst_o_oval;
    assign PMU_PADEN = io_pads_aon_pmu_vddpaden_o_oval;

    //----------------------------
    // div
    //----------------------------
    reg CLK32KHZ;
    reg [10:0] div_cnt_32K;

    always @(posedge CLK50MHZ or negedge rst_n) begin
        if (!rst_n)
            div_cnt_32K <= 'b0;
        else if (div_cnt_32K == 'd1525)
            div_cnt_32K <= 'b0;
        else
            div_cnt_32K <= div_cnt_32K + 1;
    end

    always @(posedge CLK50MHZ or negedge rst_n) begin
        if (!rst_n)
            CLK32KHZ <= 'b0;
        else if ((div_cnt_32K == 'd0) || (div_cnt_32K == 'd762))
            CLK32KHZ <= ~CLK32KHZ;
    end

    wire lfextclk;
    assign lfextclk = CLK32KHZ;

    reg CLK12MHZ;
    reg [2:0] div_cnt_12M;

    always @(posedge CLK50MHZ or negedge rst_n) begin
        if (!rst_n)
            div_cnt_12M <= 'b0;
        else if (div_cnt_12M == 'd3)
            div_cnt_12M <= 'b0;
        else
            div_cnt_12M <= div_cnt_12M + 1;
    end

    always @(posedge CLK50MHZ or negedge rst_n) begin
        if (!rst_n)
            CLK12MHZ <= 'b0;
        else if ((div_cnt_12M == 'd0) || (div_cnt_12M == 'd1))
            CLK12MHZ <= ~CLK12MHZ;
    end

    assign hfextclk = CLK12MHZ;
    //----------------------------
    // e203
    //----------------------------
    /* e203_soc_top auto_template(
        .io_pads_dbgmode0_n_i_ival(1'b1),
        .io_pads_dbgmode1_n_i_ival(1'b1),
        .io_pads_dbgmode2_n_i_ival(1'b1),
        .io_pads_aon_pmu_dwakeup_n_i_ival(1'b1),
        .io_pads_aon_erst_n_i_ival(rst_n),
        .io_pads_bootrom_n_i_ival(1'b0),           //0-rom,1-qspi
        .io_pads_qspi0_dq_0_i_ival(1'b1),
        .io_pads_qspi0_dq_1_i_ival(1'b1),
        .io_pads_qspi0_dq_2_i_ival(1'b1),
        .io_pads_qspi0_dq_3_i_ival(1'b1),
    ) */
    
    e203_soc_top u_e203(/*AUTOINST*/
			// Outputs
			.hfxoscen	(hfxoscen),
			.lfxoscen	(lfxoscen),
			.io_pads_jtag_TDO_o_oval(io_pads_jtag_TDO_o_oval),
			.io_pads_jtag_TDO_o_oe(io_pads_jtag_TDO_o_oe),
			.io_pads_gpioA_o_oval(io_pads_gpioA_o_oval[32-1:0]),
			.io_pads_gpioA_o_oe(io_pads_gpioA_o_oe[32-1:0]),
			.io_pads_gpioB_o_oval(io_pads_gpioB_o_oval[32-1:0]),
			.io_pads_gpioB_o_oe(io_pads_gpioB_o_oe[32-1:0]),
			.io_pads_qspi0_sck_o_oval(io_pads_qspi0_sck_o_oval),
			.io_pads_qspi0_cs_0_o_oval(io_pads_qspi0_cs_0_o_oval),
			.io_pads_qspi0_dq_0_o_oval(io_pads_qspi0_dq_0_o_oval),
			.io_pads_qspi0_dq_0_o_oe(io_pads_qspi0_dq_0_o_oe),
			.io_pads_qspi0_dq_1_o_oval(io_pads_qspi0_dq_1_o_oval),
			.io_pads_qspi0_dq_1_o_oe(io_pads_qspi0_dq_1_o_oe),
			.io_pads_qspi0_dq_2_o_oval(io_pads_qspi0_dq_2_o_oval),
			.io_pads_qspi0_dq_2_o_oe(io_pads_qspi0_dq_2_o_oe),
			.io_pads_qspi0_dq_3_o_oval(io_pads_qspi0_dq_3_o_oval),
			.io_pads_qspi0_dq_3_o_oe(io_pads_qspi0_dq_3_o_oe),
			.io_pads_aon_pmu_padrst_o_oval(io_pads_aon_pmu_padrst_o_oval),
			.io_pads_aon_pmu_vddpaden_o_oval(io_pads_aon_pmu_vddpaden_o_oval),
			// Inputs
			.hfextclk	(hfextclk),
			.lfextclk	(lfextclk),
			.io_pads_jtag_TCK_i_ival(io_pads_jtag_TCK_i_ival),
			.io_pads_jtag_TMS_i_ival(io_pads_jtag_TMS_i_ival),
			.io_pads_jtag_TDI_i_ival(io_pads_jtag_TDI_i_ival),
			.io_pads_gpioA_i_ival(io_pads_gpioA_i_ival[32-1:0]),
			.io_pads_gpioB_i_ival(io_pads_gpioB_i_ival[32-1:0]),
			.io_pads_qspi0_dq_0_i_ival(1'b1),	 // Templated
			.io_pads_qspi0_dq_1_i_ival(1'b1),	 // Templated
			.io_pads_qspi0_dq_2_i_ival(1'b1),	 // Templated
			.io_pads_qspi0_dq_3_i_ival(1'b1),	 // Templated
			.io_pads_aon_erst_n_i_ival(rst_n),	 // Templated
			.io_pads_dbgmode0_n_i_ival(1'b1),	 // Templated
			.io_pads_dbgmode1_n_i_ival(1'b1),	 // Templated
			.io_pads_dbgmode2_n_i_ival(1'b1),	 // Templated
			.io_pads_bootrom_n_i_ival(1'b0),	 // Templated
			.io_pads_aon_pmu_dwakeup_n_i_ival(1'b1)); // Templated


endmodule
// Local Variables:
// verilog-library-directories: ("." "../rtl/e203/soc/")
// End:
