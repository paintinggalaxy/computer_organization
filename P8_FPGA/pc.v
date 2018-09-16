`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:33:29 12/05/2017 
// Design Name: 
// Module Name:    pc 
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
//java -jar F:\Mars4_5.jar a db mc CompactDataAtZero dump 0x00004180-0x00004ffc HexText G:\CO\P7\microsys\exch.txt G:\CO\P7\exch.asm
module pc(
    input [31:0] npc,
    input rst,
    input clk,
	 input clk2,
	 input pcen,
	 input j2intpro,
    input br,
    output [31:0] instr,
	 output[31:0] pc8
    );
	 
	reg[31:0] pc = 32'h3000;
	//reg [31:0] im[2047:0];
	wire [31:0] loc;
	wire [31:0] douta;
	assign loc = pc - 32'h3000;
	assign instr = (loc[1:0]==2'b00)?douta:0;
	assign pc8 = pc + 8;
	
		impro impro (
	  .clka(clk2), // input clka
	  .wea(4'b0), // input [3 : 0] wea
	  .addra(loc[12:2]), // input [10 : 0] addra
	  .dina(32'b0), // input [31 : 0] dina
	  .douta(douta) // output [31 : 0] douta
	);
	
	//executive
	wire [31:0] pcwritein;
	assign pcwritein = (j2intpro)?32'h4180:
							 (!pcen)?pc:
							 (br)?npc:pc+4;
	
	always@(posedge clk)begin
		if(!rst)begin
			pc<=32'h3000;
		end
		
		else 
			pc<= pcwritein;
	end
			
endmodule
