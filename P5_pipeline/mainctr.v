`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:03 12/05/2017 
// Design Name: 
// Module Name:    mainctr 
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
module mainctr(
    input [31:0] instr,
	 input beq,
	 input bne,
	 input greater,
	 input less,
	 input greater0,
	 input less0,
	 input equal0,
	 input rd20,
	 output br,
	 output extctr,
	 output change
    );
	 wire[5:0] op, f;
	 wire[4:0] t;
	 assign op = instr[31:26];
	 assign f = instr[5:0];
	 assign t = instr[20:16];
	 assign br = `jal || `jr || `j||`beq||`bgez||`bgtz||`blez||`bltz||`bne||`bgezal;
	 assign extctr = `lw || `sw ||`sb||`lb||`lh||`sh||`addiu;
	 assign change = (`bgezal&&(greater0||equal0)||`movz&&(rd20))?0:1;

endmodule
