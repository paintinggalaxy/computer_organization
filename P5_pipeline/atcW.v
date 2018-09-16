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
    input [4:0] ra1M,
    input [4:0] ra2M,
    input [4:0] waM,
    input [1:0] resM,
    input clk,
	 input rst,
    output [4:0] ra1W,
    output [4:0] ra2W,
    output [4:0] waW,
    output [1:0] resW
    );
	 
	 reg[4:0] ra1 = 0,ra2 = 0,wa = 0;
	 reg[1:0] res = 0;
	 
	 assign ra1W = ra1;
	 assign ra2W = ra2;
	 assign waW = wa;
	 assign resW = res;
	 
	 always @(posedge clk)begin
		if(rst==1)begin
			ra1<= 0;
			ra2 <= 0;
			wa<= 0;
			res<= 0;
		
		end
		else begin
			ra1<= ra1M;
			ra2 <= ra2M;
			wa<= waM;
			res<= resM;
		end
	 end


endmodule
