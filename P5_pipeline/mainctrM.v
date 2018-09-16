`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:34:39 12/10/2017 
// Design Name: 
// Module Name:    mainctrM 
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
`include "head.v"
module mainctrM(
    input [31:0] instrM,
	 output memwrite,
	 output [1:0] dmictr,
	 output [1:0] dmoctr
    );
	 wire[5:0] op, f;
	 assign op = instrM[31:26];
	 assign f = instrM[5:0];
	 assign memwrite = `sw||`sb||`sh;
	 assign dmictr = (`sw)?2'b00:
						  (`sh)?2'b01:
						  (`sb)?2'b11:
						  2'b00;
	assign dmoctr = (`lw)?2'b00:
						 (`lh)?2'b01:
						 (`lb)?2'b11:2'b00;
endmodule
