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


module multdiv(
	input [31:0] A,
	input [31:0] B,
	input [2:0] mdctr,
	input rst,
	input clk,
	input clr,
	input start,
	input lowrite,
	input hiwrite,
	output busy,
	output [31:0] hio,
	output [31:0] loo
    );
	 
	 reg[31:0] hi = 0, lo = 0;
	 integer i = 0;
	 reg [31:0] mediahi = 0, medialo = 0;
	 reg state = 0;
	 
	 assign hio = (busy)?0:hi;
	 assign loo = (busy)?0:lo;
	 assign busy = (i==0)?1'b0:1'b1;
	 
	 always@(posedge clk)begin
		if(rst)begin
			i<=0;
			mediahi = 0;
			medialo = 0;
			hi<=0;
			lo<=0;
			state<=0;
		end
		
		else if(clr&&(i==1||i==0))begin
			mediahi<=0;
			medialo<=0;
			i<=0;
		end
		else if(start==1)begin
			if(mdctr==`md_mult) begin
				i <= 1;
				
				{mediahi,medialo}<=$signed(A)*$signed(B);
				state<=0;
			end
			else if(mdctr==`md_multu) begin
				i<= 1;
				{mediahi, medialo}<= {1'b0,A}*{1'b0,B};
				state<=0;
			end
			else if(mdctr==`md_div)begin
				i <= i + 1;
				medialo <= $signed(A)/$signed(B);
				mediahi<= $signed(A)%$signed(B);
				state<=1;
			end
			else begin
				i<= i+1;
				medialo<={1'b0,A}/{1'b0,B};
				mediahi<= {1'b0,A}%{1'b0,B};
				state<=1;
			end
		end
		else if(lowrite||hiwrite)begin
			lo<= (lowrite)?A:lo;
			hi<= (hiwrite)?A:hi;
		end
		else begin
			if(state==0&&i==5)begin
				i<= 0;
				hi<= mediahi;
				lo<= medialo;
			end
			else if(state==1&&i==10)begin
				i<=0;
				hi<= mediahi;
				lo<= medialo;
			end
			else if(i!=0)
				i<=i+1;
			else 
				;
		end
	 
	 end


endmodule
