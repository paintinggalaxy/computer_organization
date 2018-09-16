`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:55 12/05/2017 
// Design Name: 
// Module Name:    M 
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
module M(
    input [31:0] rd2E,
    input [31:0] aluout,
    input [31:0] memaddr,
    input [31:0] pc8E,
	 input [31:0] instrE,
    input [4:0] waE,
    input clk,
    input rst,
    output [31:0] rd2M,
    output [31:0] aluoutM,
    output [31:0] memaddrM,
    output [31:0] pc8M,
	 output [31:0] instrM,
    output [4:0] waM
    );
	 reg [31:0] rd2 = 0;
	 reg [31:0] aluoutreg = 0;
	 reg [31:0] memaddrreg = 0;
	 reg [31:0] pc8 = 0;
	 reg [31:0] instr = 0;
	 reg [4:0] wa = 0;
	 
	 assign rd2M = rd2;
	 assign aluoutM = aluoutreg;
	 assign memaddrM = memaddrreg;
	 assign pc8M = pc8;
	 assign waM =wa;
	 assign instrM = instr;
	 
	 always@(posedge clk)begin
		if(rst)begin
			rd2 <= 0;
			aluoutreg <= 0;
			memaddrreg <= 0;
			pc8 <= 0;
			wa <= 0;
			instr<=0;
		end
		else begin
			rd2 <= rd2E;
			aluoutreg <= aluout;
			memaddrreg <= memaddr;
			pc8 <= pc8E;
			wa <= waE;
			instr<=instrE;
		end
	 end

endmodule
