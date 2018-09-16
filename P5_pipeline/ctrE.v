`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:58:36 12/06/2017 
// Design Name: 
// Module Name:    atcE 
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
module atcE(
    input [4:0] ra1i,
    input [4:0] ra2i,
    input [4:0] wai,
    input [1:0] resi,
    input clk,
	 input rst,
	 input Eclr,
    output [4:0] ra1E,
    output [4:0] ra2E,
    output [4:0] waE,
    output [1:0] resE
    );
	 
	 reg[4:0] ra1= 0,ra2 = 0,wa = 0;
	 reg[1:0] res = 0;
	 
	 assign ra1E = ra1;
	 assign ra2E = ra2;
	 assign waE = wa;
	 assign resE = res;
	 
	 always @(posedge clk)begin
		if(rst==1||Eclr)begin
			ra1<= 0;
			ra2 <= 0;
			wa<= 0;
			res<= 0;
		end
		else begin
			ra1<= ra1i;
			ra2 <= ra2i;
			wa<= wai;
			res<= resi;
		end
	 end


endmodule
