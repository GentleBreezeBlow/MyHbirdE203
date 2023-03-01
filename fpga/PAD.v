//-----------------------------------------------------------------------------
// Author       : 
// Filename     : iopad for fpga
// Date         : 2022/03/21 13:57:05
// 
// Revision     : 1.0
// Purpose      : 
// Reference    : 
//-----------------------------------------------------------------------------

module PAD (
    input I,
    inout IO,
    output O,
    input en
);
    
    assign IO = (en == 1'b1) ? I : 1'bz;
    assign O = IO;

endmodule