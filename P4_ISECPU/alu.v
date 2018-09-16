`timescale 1ns / 1ps

`define alu_addu 3'b000
`define alu_subu 3'b001
`define alu_or 3'b010
`define alu_lui 3'b011
`define alu_sll 3'b100
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:50:43 11/25/2017 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] aluctr,
	 input [31:0] instr,
    output equal,
    output less,
    output greater,
    output [31:0] aluout
    );
	assign aluout = (aluctr==`alu_addu)?A + B:
						 (aluctr==`alu_subu)?A - B:
						 (aluctr==`alu_or)? (A|B):
						 (aluctr==`alu_lui)?{B[15:0],B[31:16]}:
						 (aluctr==`alu_sll)?B<<instr[10:6]:32'b0;
						 
						 
	assign equal = (A == B);
	assign less = (A < B);
	assign greater = (A > B);

endmodule
