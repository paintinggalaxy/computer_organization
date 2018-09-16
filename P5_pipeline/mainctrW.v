`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:37:18 12/10/2017 
// Design Name: 
// Module Name:    mainctrW 
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
`include "head.v"
module mainctrW(
    input [31:0] instrW,
	 input changeW,
	 output regwrite,
	 output [1:0] wdctr
    );
	 wire[5:0] op, f;
	 wire[4:0] t,bits106;
	 assign t = instrW[20:16];
	 assign op = instrW[31:26];
	 assign f = instrW[5:0];
	 assign bits106 = instrW[10:6];
	 assign wdctr = (`lw||`lh||`lb)?2'b01:
						 (`jal||`bgezal)?2'b10:
						 2'b00;
	 assign regwrite = `addu || `subu || `ori || `lw ||`lh||`lb|| `lui || `jal ||`or||`slt||`addiu||(`bgezal&&!changeW)||(`movz&&!changeW)||`rotrv;
	 

endmodule
