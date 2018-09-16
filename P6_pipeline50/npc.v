`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:23:59 12/05/2017 
// Design Name: 
// Module Name:    npc 
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
`define pcj 6'b000010
`define pcjal 6'b000011
`define pcbeq 6'b000100
`define pcrtype 6'b000000
`define pcjrfunc 6'b001000
`define pcbgez1 6'b000001
`define pcbgez2 5'b00001
`define pcbgtz 6'b000111
`define pcblez 6'b000110
`define pcbltz1 6'b00001
`define pcbltz2 5'b00000
`define pcbne 6'b000101
module npc(
	 input [31:0] instr,
    input [31:0] pc8,
    input [31:0] ra,
	 input greater0,
	 input less0,
	 input equal0,
	 input bne,
	 input greater,
	 input less,
    input beq,
    output [31:0] npc
    );
	 wire [5:0] op, f;
	 wire [4:0] t;
	 wire [31:0] pc4;
	 assign op = instr[31:26];
	 assign f = instr[5:0];
	 assign t = instr[20:16];
	 assign pc4 = pc8-4;
	 assign npc = (`j||`jal)?{pc4[31:28],instr[25:0],2'b00}:
					  (`beq)?(beq?pc4+{{14{instr[15]}},instr[15:0],2'b00}:pc8):
					  (`bgez||`bgezal||`bgezall)?(greater0||equal0?pc4+{{14{instr[15]}},instr[15:0],2'b00}:pc8):
					  (`bgtz)?(greater0?pc4+{{14{instr[15]}},instr[15:0],2'b00}:pc8):
					  (`blez)?(less0||equal0?pc4+{{14{instr[15]}},instr[15:0],2'b00}:pc8):
					  (`bltz)?(less0?pc4+{{14{instr[15]}},instr[15:0],2'b00}:pc8):
					  (`bne)?(bne?pc4+{{14{instr[15]}},instr[15:0],2'b00}:pc8):
					  (`jr||`jalr)?ra:0;


endmodule
