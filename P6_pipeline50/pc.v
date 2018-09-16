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
module pc(
    input [31:0] npc,
    input rst,
    input clk,
	 input pcen,
    input br,
    output [31:0] instr,
	 output[31:0] pc8
    );
	 
	reg[31:0] pc = 32'h3000;
	reg [31:0] im[4095:0];
	
	assign instr = im[pc[13:2]-12'h0c00];
	assign pc8 = pc + 8;
	integer i;
	initial begin
		for(i=0;i<4096;i=i+1)
			im[i] = 0;
		$readmemh ("code.txt",im);
	end
	//executive
	always@(posedge clk)begin
		if(rst==1)begin
			pc<=32'h3000;
			$readmemh ("code.txt",im);	
		end
		else if(pcen==0)
			pc<=pc;
		else if(br==0)
			pc<= pc+4;
		else 
			pc<= npc;
	end
			
endmodule
