`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:13:15 01/09/2018 
// Design Name: 
// Module Name:    switch64 
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
module switch64(
	input clk,
	input[7:0] dip_switch0,
	input[7:0] dip_switch1,
	input[7:0] dip_switch2,
	input[7:0] dip_switch3,
	input[7:0] dip_switch4,
	input[7:0] dip_switch5,
	input[7:0] dip_switch6,	
	input[7:0] dip_switch7,
	input[2:0] addr,
	output irq,
	output[31:0] dout
    );
	 reg [63:0] sit;
	 reg inter;
	 wire [63:0] sitwi;
	 assign dout = (addr==3'b011)?sit[31:0]:sit[63:32];
	assign sitwi = {~dip_switch7,~dip_switch6,~dip_switch5,~dip_switch4,~dip_switch3,~dip_switch2,~dip_switch1,~dip_switch0};
	assign irq = inter;
	always@(posedge clk)begin
	/*
		if(!rst)begin
			sit<=64'hffff_ffff_ffff_ffff;
			inter<=1'b0;
		end
		*/
		//else begin
			sit<= sitwi;
			inter<=(sit!=sitwi);
		//end
	end

endmodule
