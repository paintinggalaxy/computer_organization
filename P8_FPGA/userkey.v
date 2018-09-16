`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:35:58 01/09/2018 
// Design Name: 
// Module Name:    userkey 
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
module userkey(
	input [7:0] user_key,
	input clk,
	input rst,
	output [31:0] dout,
	output irq
    );
	reg[7:0] keys;
	wire[7:0] keyswi;
	/*
	reg[6:0] cnt7, cnt6, cnt5, cnt4, cnt3, cnt2, cnt1, cnt0;
	wire [3:0] cnt7wi, cnt6wi, cnt5wi, cnt4wi, cnt3wi, cnt2wi, cnt1wi, cnt0wi;
	assign cnt7wi = (user_key[7]&&!keys[7])?cnt7+1:0;
	assign cnt6wi = (user_key[6]&&!keys[6])?cnt6+1:0;
	assign cnt5wi = (user_key[5]&&!keys[5])?cnt5+1:0;
	assign cnt4wi = (user_key[4]&&!keys[4])?cnt4+1:0;
	assign cnt3wi = (user_key[3]&&!keys[3])?cnt3+1:0;
	assign cnt2wi = (user_key[2]&&!keys[2])?cnt2+1:0;
	assign cnt1wi = (user_key[1]&&!keys[1])?cnt1+1:0;
	assign cnt0wi = (user_key[0]&&!keys[0])?cnt0+1:0;
	assign keyswi = {(cnt7==7'd100)?1'b1:keys[7],(cnt6==7'd100)?1'b1:keys[6],
						  (cnt5==7'd100)?1'b1:keys[5],(cnt4==7'd100)?1'b1:keys[4],
						  (cnt3==7'd100)?1'b1:keys[3],(cnt2==7'd100)?1'b1:keys[2],
						  (cnt1==7'd100)?1'b1:keys[1],(cnt0==7'd100)?1'b1:keys[0]};
	*/
	assign keyswi = (!user_key[7])?8'b01111111:
						 (!user_key[6])?8'b10111111:
						 (!user_key[5])?8'b11011111:
						 (!user_key[4])?8'b11101111:
						 (!user_key[3])?8'b11110111:
						 (!user_key[2])?8'b11111011:
						 (!user_key[1])?8'b11111101:
						 (!user_key[0])?8'b11111110:8'hff;
	assign irq = (keys!=8'hff);
	assign dout = {24'b0, keys};
	always@(posedge clk)begin
		if(!rst)begin
			keys<=8'hff;
			/*
			cnt7<=0;
			cnt6<=0;
			cnt5<=0;
			cnt4<=0;
			cnt3<=0;
			cnt2<=0;
			cnt1<=0;
			cnt0<=0;
			*/
		end
		else begin
			keys<=keyswi;
			/*
			cnt7<=cnt7wi;
			cnt6<=cnt6wi;
			cnt5<=cnt5wi;
			cnt4<=cnt4wi;
			cnt3<=cnt3wi;
			cnt2<=cnt2wi;
			cnt1<=cnt1wi;
			cnt0<=cnt0wi;
			*/
		end
	
	
	end
	

endmodule
