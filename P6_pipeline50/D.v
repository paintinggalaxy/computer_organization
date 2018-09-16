`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:42:18 12/05/2017 
// Design Name: 
// Module Name:    D 
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
module D(
    input [31:0] instri,
    input [31:0] pc8i,
	 input clk,
	 input rst,
	 input Den,
	 input Dclr,
    output [15:0] immD,
    output [31:0] pc8D,
	 output [31:0] instrD
    );
	reg [31:0] instr = 0;
	reg [31:0] pc8 = 0;
	reg [15:0] imm = 16'b0;
	assign immD = imm;
	assign pc8D = pc8;
	assign instrD = instr;
	always @(posedge clk)begin
		if(rst==1||Dclr==1)begin
			instr <=0;
			pc8<=0;
			imm<=0;
		end
		else if(Den==1)begin
			instr <= instri;
			pc8 <= pc8i;
			imm <= instri[15:0];
		end
		else
			;
	end
endmodule
