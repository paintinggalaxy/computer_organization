`timescale 1ns / 1ps



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
`include "head.v"
`define AlessB ((A[31]==1&&B[31]==0)||(A[31]==B[31]&&A<B))

module alu(
    input [31:0] A,
    input [31:0] B,
	 input [4:0] shamt,
    input [4:0] aluctr,
    output [31:0] aluout
    );
	 
	 
	assign aluout = (aluctr==`alu_addu)?A + B:
						 (aluctr==`alu_subu)?A - B:
						 (aluctr==`alu_ori)? (A|B):
						 (aluctr==`alu_lui)?{B[15:0],B[31:16]}:
						 (aluctr==`alu_slt)?((`AlessB)?1:0):
						 (aluctr==`alu_movz)?A:
						 (aluctr==`alu_rotrv)?((B<<(5'b11111-A[4:0]))+B>>A[4:0]):
						 (aluctr==`alu_sll)?(B<<shamt):
						 (aluctr==`alu_srl)?(B>>shamt):
						 (aluctr==`alu_sra)?($signed($signed(B)>>>shamt)):// there is a lot of questions
						 (aluctr==`alu_sllv)?(B<<A[4:0]):
						 (aluctr==`alu_srlv)?(B>>A[4:0]):
						 (aluctr==`alu_srav)?($signed($signed(B)>>>A[4:0])):
						 (aluctr==`alu_and)?(A&B):
						 (aluctr==`alu_xor)?(A^B):
						 (aluctr==`alu_nor)?~(A|B):
						 (aluctr==`alu_sltu)?(({1'b0,A}<{1'b0,B})?1:0):
						 32'b0;

endmodule
