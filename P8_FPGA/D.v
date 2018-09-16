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
	 input [31:0] causeF,
	 input clk,
	 input rst,
	 input Den,
	 input Dclr,
	 input DEMWclr,
    output [15:0] immD,
    output [31:0] pc8D,
	 output [31:0] instrD,
	 output [31:0] causeD
    );
	reg [31:0] instr = 0;
	reg [31:0] pc8 = 0;
	reg [15:0] imm = 16'b0;
	reg [31:0] cause = 0;
	
	assign immD = imm;
	assign pc8D = pc8;
	assign instrD = instr;
	assign causeD = cause;
	
	wire[31:0] instrwi, pc8wi, causewi;
	wire[15:0] immwi;
	
	assign instrwi = (DEMWclr)?0:
						  (!Den)?instr:
						  (Dclr)?0:instri;
		
	assign pc8wi = (DEMWclr)?pc8i:
						(!Den)?pc8:pc8i;
						
	assign immwi = (DEMWclr)?16'b0:
						(!Den)?imm:
						(Dclr)?16'b0:instri[15:0];
	
	assign causewi = (DEMWclr)?0:
						  (!Den)?cause:
						  (Dclr)?0:causeF;
						  
						
	always @(posedge clk)begin
		if(!rst)begin
			instr <=0;
			pc8<=0;
			imm<=0;
			cause<=0;
		end
		else begin
			instr <= instrwi;
			pc8 <= pc8wi;
			imm <= immwi;
			cause<= causewi;
		end
	end
endmodule
