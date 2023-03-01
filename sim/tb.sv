//-----------------------------------------------------------------------------
// Author       : 
// Filename     : tb for sim
// Date         : 2022/03/22 17:20:54
// 
// Revision     : 1.0
// Purpose      : 
// Reference    : 
//-----------------------------------------------------------------------------
`include "e203_defines.v"
module tb (/*AUTOARG*/);

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire [31:0]		GPIOA;			// To/From dut of fpga_top.v
    wire [31:0]		GPIOB;			// To/From dut of fpga_top.v
    wire		JTAG_TDO;		// To/From dut of fpga_top.v
    wire		PMU_PADEN;		// From dut of fpga_top.v
    wire		PMU_PADRST;		// From dut of fpga_top.v
    // End of automatics

    initial begin
        if ($test$plusargs("FSDB_DUMP")) begin
            $fsdbDumpfile("sim.fsdb");
            $fsdbDumpvars();
        end
    end

    //-----------------------------------------
    // Clocks and reset
    //-----------------------------------------
    reg RESETN;
    reg CLK50MHZ;
    localparam PERIOD_50MHZ = 20;

    always #(PERIOD_50MHZ/2)  CLK50MHZ  = ~CLK50MHZ;

    initial begin
        RESETN = 1'b0;
        CLK50MHZ = 1'b0;
        #1000
        RESETN = 1'b1;
    end


    //-----------------------------------------
    // timeout
    //-----------------------------------------
    initial begin
        #40000000
        $display("******Time Out******");
        $finish;
    end

    assign JTAG_TCK = 1'b0;
    assign JTAG_TDI = 1'b0;
    assign JTAG_TMS = 1'b0;

    //-----------------------------------------
    // DUT
    //-----------------------------------------
    fpga_top dut(/*AUTOINST*/
		 // Outputs
		 .PMU_PADRST	(PMU_PADRST),
		 .PMU_PADEN		(PMU_PADEN),
		 // Inouts
		 .GPIOA			(GPIOA[31:0]),
		 .GPIOB			(GPIOB[31:0]),
		 .JTAG_TDO		(JTAG_TDO),
		 // Inputs
		 .CLK50MHZ		(CLK50MHZ),
		 .RESETN		(RESETN),
		 .JTAG_TCK		(JTAG_TCK),
		 .JTAG_TDI		(JTAG_TDI),
		 .JTAG_TMS		(JTAG_TMS));

    pulldown(JTAG_TDO);
    genvar num;
    generate
        for (num = 0; num < 32 ; num++) begin
            pullup(GPIOA[num]);
            pullup(GPIOB[num]);
        end
    endgenerate

    //-----------------------------------------
    // ITCM hex
    //-----------------------------------------
    `define CPU_TOP dut.u_e203.u_e203_subsys_top.u_e203_subsys_main.u_e203_cpu_top
    `define ITCM `CPU_TOP.u_e203_srams.u_e203_itcm_ram.u_e203_itcm_gnrl_ram.u_sirv_sim_ram

    integer i;
    reg [7:0] itcm_mem [0:(`E203_ITCM_RAM_DP*8)-1];
    initial begin
        $readmemh("main.verilog", itcm_mem);
        for (i=0;i<(`E203_ITCM_RAM_DP);i=i+1) begin
            `ITCM.mem_r[i] = {itcm_mem[i*8+7],itcm_mem[i*8+6],itcm_mem[i*8+5],itcm_mem[i*8+4],itcm_mem[i*8+3],itcm_mem[i*8+2],itcm_mem[i*8+1],itcm_mem[i*8+0]};
        end
    end

    //------------------------------------------
    // debug print
    //------------------------------------------
    debug u_debug();

endmodule
// Local Variables:
// verilog-library-directories: ("." "../fpga/")
// End:
