`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:38:21 01/09/2018 
// Design Name: 
// Module Name:    led32 
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
module led32(
	input we,
	input clk,
	input rst,
	input [31:0] din,
	output [31:0] dout,
	output [31:0] led_light
    );
	 reg[31:0] ctr;
	 wire [31:0] ctrwi;
	 assign ctrwi = (we)?din:ctr;
	 assign dout = ctr;
	 assign led_light = ctr;
	 always@(posedge clk)begin
		if(!rst)
			ctr<=32'hffffffff;
		else 
			ctr<= ctrwi;
	 end
	 


endmodule
