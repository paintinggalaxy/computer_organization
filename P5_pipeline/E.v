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
	 inout [31:0] instrD,
    input clk,
	 input rst,
	 input Eclr,
    output [31:0] rd1E,
    output [31:0] rd2E,
    output [4:0] waE,
    output [31:0] immE,
    output [31:0] pc8E,
	 output [31:0] instrE
    );
	 reg [31:0] rd1=0,rd2=0, imm=0, pc8=0,instr = 0;
	 reg [4:0] wa=0;
	 
	 assign rd1E = rd1;
	 assign rd2E = rd2;
	 assign waE = wa;
	 assign pc8E = pc8;
	 assign immE = imm;
	 assign instrE = instr;
	 always @(posedge clk)begin
		if(Eclr==1||rst==1)begin
			rd1<=0;
			rd2<=0;
			imm<=0;
			pc8<=0;
			wa<=0;
			instr<=0;
		end
		else begin
			rd1<= rd1D;
			rd2<= rd2D;
			imm<= immD;
			pc8<= pc8D;
			wa<= waD;
			instr<= instrD;
		end
	 end

endmodule
