`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:01:28 12/06/2017 
// Design Name: 
// Module Name:    atcM 
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
module atcM(
    input [4:0] ra1E,
    input [4:0] ra2E,
    input [4:0] waE,
    input [1:0] resE,
    input clk,
	 input rst,
    output [4:0] ra1M,
    output [4:0] ra2M,
    output [4:0] waM,
    output [1:0] resM
    );
	 
	 reg[4:0] ra1 = 0,ra2 = 0,wa = 0;
	 reg[1:0] res = 0;
	 
	 assign ra1M = ra1;
	 assign ra2M = ra2;
	 assign waM = wa;
	 assign resM = res;
	 
	 always @(posedge clk)begin
		if(rst==1)begin
	 		ra1<= 0;
			ra2 <= 0;
			wa<= 0;
			res<= 0;

		end
		else begin
			ra1<= ra1E;
			ra2 <= ra2E;
			wa<= waE;
			res<= resE;
		end
	 
	 end


endmodule
