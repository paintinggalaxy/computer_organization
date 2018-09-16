`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:11:42 12/06/2017 
// Design Name: 
// Module Name:    mcM 
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
module mcM(
    input [31:0] instrE,
	 input changeE,
    input clk,
	 input rst,
    output [31:0] instrM,
	 output changeM
    );
	 
	 reg[31:0] instr = 0;
	 reg change = 0;
	 
	 assign instrM = instr;
	 assign changeM = change;
	 
	 always@(posedge clk)begin
		if(rst==1)begin
			instr<=0;
			change <= 0;
		end
		else begin
			instr<=instrE;
			change<= changeE;
		end
	 end

endmodule
