`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:05:28 12/06/2017 
// Design Name: 
// Module Name:    mcE 
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
module mcE(
    input [31:0] instrD,
	 input changeD,
    input clk,
	 input rst,
	 input Eclr,
    output [31:0] instrE,
	 output changeE
    );
	 
	 reg[31:0] instr = 0;
	 reg change = 0;
	 
	 assign instrE = instr;
	 assign changeE = change;
	 
	 always@(posedge clk)begin
		if(rst==1||Eclr==1)begin
			instr<=0;
			change<=0;
		end
		else begin
			instr<=instrD;
			change<= changeD;
		end
	 end

endmodule
