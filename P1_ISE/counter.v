`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:30:26 10/26/2017 
// Design Name: 
// Module Name:    counter 
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
module counter(
    input sel,
    input clk,
    input en,
	 input reset,
    output [63:0] output0,
    output [63:0] output1
    );
	 reg[63:0] out0=0,out1=0;
	 assign output0 = out0;
	 assign output1 = out1;
	 integer i = 0;
	 always@(posedge clk)begin
		if(reset)begin
			out0<=0;
			out1<=0;
			i<=0;
		end
		else if(en&&!sel)
			out0<=out0+1;
		else if(en&&sel)begin
			out0<=0;
			if(i==3)begin
				out1<=out1+1;
				i<=1;
			end
			else
				i<=i+1;
		end
		else
			;
	 end


endmodule
