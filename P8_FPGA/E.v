`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:59:10 12/05/2017 
// Design Name: 
// Module Name:    E 
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
module E(
    input [31:0] rd1D,
    input [31:0] rd2D,
    input [4:0] waD,
    input [31:0] immD,
    input [31:0] pc8D,
	 input [31:0] instrD,
	 input [31:0] causeD,
    input clk,
	 input rst,
	 input Eclr,
	 input DEMWclr,
    output [31:0] rd1E,
    output [31:0] rd2E,
    output [4:0] waE,
    output [31:0] immE,
    output [31:0] pc8E,
	 output [31:0] instrE,
	 output [31:0] causeE,
	 output [4:0] shamt
    );
	 reg [31:0] rd1=0,rd2=0, imm=0, pc8=0,instr = 0, cause = 0;
	 reg [4:0] wa=0;
	 
	 assign rd1E = rd1;
	 assign rd2E = rd2;
	 assign waE = wa;
	 assign pc8E = pc8;
	 assign immE = imm;
	 assign instrE = instr;
	 assign shamt = instr[10:6];
	 assign causeE = cause;
	 wire[31:0] pcwi;
	 assign pcwi = (!rst)?0:pc8D;
	 always @(posedge clk)begin
		if(!rst||Eclr||DEMWclr)begin
			rd1<=0;
			rd2<=0;
			imm<=0;
			pc8<=pcwi;
			wa<=0;
			instr<=0;
			cause<=0;
		end

		else begin
			rd1<= rd1D;
			rd2<= rd2D;
			imm<= immD;
			pc8<= pcwi;
			wa<= waD;
			instr<= instrD;
			cause<= causeD;
		end
	 end

endmodule
