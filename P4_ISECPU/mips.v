`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:35:33 11/25/2017 
// Design Name: 
// Module Name:    mips 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mips(
    input clk,
    input reset

    );
	 wire [5:0] func, op;
	 wire [2:0] aluctr;
	 wire [1:0] wactr, wdctr, brctr;
	 wire regwrite, memwrite, bctr, extctr;
	 
	 datapath u0(.clk(clk),
	 .rst(reset),
	 .wactr(wactr),
	 .wdctr(wdctr),
	 .aluctr(aluctr),
	 .brctr(brctr),
	 .regwrite(regwrite),
	 .memwrite(memwrite),
	 .bctr(bctr),
	 .extctr(extctr),
	 .op(op),
	 .func(func)
	 );
	 controller u1(.wactr(wactr),
	 .wdctr(wdctr),
	 .aluctr(aluctr),
	 .brctr(brctr),
	 .regwrite(regwrite),
	 .memwrite(memwrite),
	 .bctr(bctr),
	 .extctr(extctr),
	 .op(op),
	 .f(func)
	 );
	 
	 
	 
	 
	 
	 
	 

endmodule
