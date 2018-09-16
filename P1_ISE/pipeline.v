`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:57 10/08/2017 
// Design Name: 
// Module Name:    pipeline 
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
module pipeline(
    input [31:0] A1,
    input [31:0] A2,
    input [31:0] B1,
    input [31:0] B2,
    input clk,
    output reg[31:0] C
    );
	 
	 reg[31:0] a,b;
	 initial begin
		a = 0;
		b = 0;
		C = 0;
	 end
	 always@(posedge clk)begin
		a <= A1*B1;
		b <= A2*B2;
		C <= a + b;
	 end


endmodule
