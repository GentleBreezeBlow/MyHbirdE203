//-----------------------------------------------------------------------------
// Author       : 
// Filename     : debug for printf
// Date         : 2022/03/23 19:01:39
// 
// Revision     : 1.0
// Purpose      : 
// Reference    : 
//-----------------------------------------------------------------------------
`timescale 1ns/1ns
module debug (/*AUTOARG*/);
    
    `define CORE_TOP tb.dut.u_e203.u_e203_subsys_top.u_e203_subsys_main.u_e203_cpu_top.u_e203_cpu.u_e203_core

    wire clk = tb.CLK50MHZ;
    wire rst_n = tb.RESETN;

    wire icb_cmd_valid;
    wire icb_cmd_ready;
    wire [31:0] icb_cmd_addr; 
    wire icb_cmd_read; 
    wire [31:0] icb_cmd_wdata;
    wire [3:0] icb_cmd_wmask;
    wire icb_cmd_lock;
    wire icb_cmd_excl;
    wire [1:0] icb_cmd_size;

    wire icb_rsp_valid;
    wire icb_rsp_ready;
    wire icb_rsp_err  ;
    wire icb_rsp_excl_ok  ;
    wire [31:0] icb_rsp_rdata;

    /*AUTOWIRE*/

    assign icb_cmd_valid   = `CORE_TOP.ppi_icb_cmd_valid  ; 
    assign icb_cmd_ready   = `CORE_TOP.ppi_icb_cmd_ready  ; 
    assign icb_cmd_addr    = `CORE_TOP.ppi_icb_cmd_addr   ; 
    assign icb_cmd_read    = `CORE_TOP.ppi_icb_cmd_read   ;  
    assign icb_cmd_wdata   = `CORE_TOP.ppi_icb_cmd_wdata  ; 
    assign icb_cmd_wmask   = `CORE_TOP.ppi_icb_cmd_wmask  ; 
    assign icb_cmd_lock    = `CORE_TOP.ppi_icb_cmd_lock   ; 
    assign icb_cmd_excl    = `CORE_TOP.ppi_icb_cmd_excl   ;
    assign icb_cmd_size    = `CORE_TOP.ppi_icb_cmd_size   ; 
    assign icb_rsp_valid   = `CORE_TOP.ppi_icb_rsp_valid  ; 
    assign icb_rsp_ready   = `CORE_TOP.ppi_icb_rsp_ready  ; 
    assign icb_rsp_err     = `CORE_TOP.ppi_icb_rsp_err    ; 
    assign icb_rsp_excl_ok = `CORE_TOP.ppi_icb_rsp_excl_ok; 
    assign icb_rsp_rdata   = `CORE_TOP.ppi_icb_rsp_rdata  ; 

    //------------------------------------------
    // READ
    //------------------------------------------
    string data;
    always @(posedge clk) begin
        if ((icb_cmd_addr == 32'h10040000) && (icb_cmd_valid == 1'b1) && (icb_cmd_read == 1'b0) && (icb_cmd_ready == 1'b1)) begin
            if( string'(icb_cmd_wdata[7:0]) == "\n") begin
                $display("[My HummingBird Print (time:%d)]: \t %s", $time, data);
                data = "";
            end else
                data = {data, string'(icb_cmd_wdata[7:0])};
        end
    end
    
    //------------------------------------------
    // start printf
    //------------------------------------------
    initial begin
        #1000;
        $display("\n\n");
        $display("**************************");
        $display("****** SIM START!!! ******");
        $display("**************************");
    end

    //------------------------------------------
    // sim pass&fail
    //------------------------------------------
    always @(posedge clk) begin
        if ((icb_cmd_addr == 32'h10041000) && (icb_cmd_valid == 1'b1) && (icb_cmd_read == 1'b0)) begin
            if(icb_cmd_wdata[7:0] == 6) begin
                $display("**************************");
                $display("******* SIM PASS!!! ******");
                $display("**************************");
                $display("\n\n");
                $finish;
            end
            else if(icb_cmd_wdata[7:0] == 4) begin
                $display("**************************");
                $display("******* SIM FAIL!!! ******");
                $display("**************************");
                $display("\n\n");
                $finish;
            end
        end
    end    

endmodule