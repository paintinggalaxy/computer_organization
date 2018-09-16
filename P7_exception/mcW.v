`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:49 12/06/2017 
// Design Name: 
// Module Name:    mcW 
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
module mcW(
    input [31:0] instrM,
	 //input changeM,
    input clk,
	 input rst,
	 input DEMWclr,
	 //output changeW,
    output [31:0] instrW
    );
	 
	 reg[31:0] instr = 0;
	 //reg change = 0;
	 
	 assign instrW = instr;
	 //assign changeW = change;
	 always@(posedge clk)begin
		if(rst||DEMWclr) begin
			instr<=0;
			//change <= 0;
		end
		else begin
			//change<=changeM;
			instr<=instrM;
		end
	 end

endmodule
