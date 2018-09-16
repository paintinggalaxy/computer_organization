`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:04:53 12/06/2017 
// Design Name: 
// Module Name:    atcW 
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
module atcW(
    input [4:0] waM,
    input [2:0] resM,
    input clk,
	 input rst,
	 input DEMWclr,
    output [4:0] waW,
    output [2:0] resW
    );
	 
	 reg[4:0] wa = 0;
	 reg[2:0] res = 0;
	 
	 assign waW = wa;
	 assign resW = res;
	 
	 always @(posedge clk)begin
		if(!rst||DEMWclr)begin
			wa<= 0;
			res<= 0;
		
		end
		else begin
			wa<= waM;
			res<= resM;
		end
	 end


endmodule
