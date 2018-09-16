`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:43:12 10/06/2017 
// Design Name: 
// Module Name:    adder 
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
module adder(
    input Clk,
    input En,
    input [3:0] A,
    input [3:0] B,
    output [3:0] Sum,
    output Overflow
    );
	reg[3:0] a;
	reg b;
	assign Sum = a;
	assign Overflow = b;
	initial begin
		a <= 4'b0;
		b <= 0;
	end
	always@(posedge Clk)begin
		if(En)begin
		{b,a} <= A + B;	
		end
	end

endmodule
