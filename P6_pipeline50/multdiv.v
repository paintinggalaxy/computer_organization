`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:57:54 12/17/2017 
// Design Name: 
// Module Name:    multdiv 
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
`define md_mult 3'b000
`define md_multu 3'b001
`define md_div 3'b010
`define md_divu 3'b011

module multdiv(
	input [31:0] A,
	input [31:0] B,
	input [2:0] mdctr,
	input rst,
	input clk,
	input start,
	input lowrite,
	input hiwrite,
	output busy,
	output [31:0] hio,
	output [31:0] loo
    );
	 
	 reg[31:0] hi = 0, lo = 0;
	 integer i = 0;
	 //integer a,b;
	 
	 reg state = 0;
	 
	 assign hio = (busy)?0:hi;
	 assign loo = (busy)?0:lo;
	 assign busy = (i==0)?1'b0:1'b1;
	 
	 always@(posedge clk)begin
		if(start==1)begin
			if(mdctr==`md_mult) begin
				i <= 1;
				//a = A;
				//b = B;
				{hi,lo}<=$signed(A)*$signed(B);
				state<=0;
			end
			else if(mdctr==`md_multu) begin
				i<= 1;
				{hi, lo}<= {1'b0,A}*{1'b0,B};
				state<=0;
			end
			else if(mdctr==`md_div)begin
				i <= i + 1;
				//a = A;
				//b = B;
				lo <= $signed(A)/$signed(B);
				hi<= $signed(A)%$signed(B);
				state<=1;
			end
			else begin
				i<= i+1;
				lo<={1'b0,A}/{1'b0,B};
				hi<= {1'b0,A}%{1'b0,B};
				state<=1;
			end
		end
		else if(lowrite||hiwrite)begin
			lo<= (lowrite)?A:lo;
			hi<= (hiwrite)?A:hi;
		end
		else begin
			if(state==0&&i==5)
				i<= 0;
			else if(state==1&&i==10)
				i<=0;
			else if(i!=0)
				i<=i+1;
			else 
				;
		end
	 
	 end


endmodule
