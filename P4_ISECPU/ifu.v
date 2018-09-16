`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:58:37 11/25/2017 
// Design Name: 
// Module Name:    ifu 
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

`define normalbr 2'b00 
`define beqbr 2'b01
`define jbr 2'b10
`define jrrabr 2'b11
module ifu(
    input [1:0] br,
    input equal,
    input less,
    input greater,
    input [31:0] ra,
    input clk,
    input rst,
    output [31:0] instr,
    output [31:0] pcadd4
    );
	
	//store units
	reg[31:0] pc = 32'h3000;
	reg [31:0] im[1023:0];
	assign instr = im[pc[11:2]];
	assign pcadd4 = pc + 4;
	integer i;
	initial begin
		for(i=0;i<1024;i=i+1)
			im[i] = 0;
		$readmemh ("code.txt",im);
	end
	//executive
	always@(posedge clk)begin
		if(rst==1)begin
			pc<=32'h3000;
			$readmemh ("code.txt",im);	
		end
		else if(br==`normalbr)begin
			pc<= pc+4;
		end
		else if(br==`beqbr)begin
			if(equal==1) pc<= pc + 4 + {{14{instr[15]}},instr[15:0],2'b00};
			else pc<=pc+4;
		end
		else if(br==`jbr)begin
			pc<= {pc[31:28],im[pc[11:2]][25:0],2'b00};
		end
		else
			pc<= ra;
	end
endmodule
