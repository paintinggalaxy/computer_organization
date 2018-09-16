`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:50:24 12/26/2017 
// Design Name: 
// Module Name:    excctrE 
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
module excctrE(
    input [31:0] causeE,
    input overflow,
    input [31:0] instrE,
    output [31:0] causeE2
    );
	 wire[5:0] op, f;
	 assign op = instrE[31:26];
	 assign f = instrE[5:0];
	 
	 assign causeE2 = (`add||`sub||`addi)&&(overflow)&&(causeE[30:0]==31'b0)?{causeE[31],24'b0,5'b01100,2'b0}:causeE;

endmodule
