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
	 output change,
	 output Dclr
    );
	 wire[5:0] op, f;
	 wire[4:0] t;
	 assign op = instr[31:26];
	 assign f = instr[5:0];
	 assign t = instr[20:16];
	 
	 assign br = `jal||`jr||`j||`jalr||
					 `beq||`bgez||`bgtz||`blez||`bltz||`bne||`bgezal||`bgezall;
					 
	 assign extctr = `lw||`lb||`lbu||`lh||`lhu||
						  `sh||`sw||`sb||
						  `addiu||`addi||`slti||`sltiu;
						  
	 assign change = ((`bgezal||`bgezall)&&(greater0||equal0)||`movz&&(rd20))?1'b0:1'b1;
	 
	 assign Dclr = (`bgezall&&less0)?1'b1:1'b0;

endmodule
