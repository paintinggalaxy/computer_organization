`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:05:28 12/26/2017 
// Design Name: 
// Module Name:    excctrM 
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
module excctrM(
    input [31:0] memaddr,
    input [31:0] causeM,
    input [31:0] instrM,
    input [5:0] hwint,
    output [31:0] causeM2
    );
	 wire[5:0] op, f;
	 assign op = instrM[31:26];
	 
	 assign causeM2 = (hwint!=6'b0)?{causeM[31],15'b0,hwint,10'b0}:
							(`sw&&memaddr[1:0]!=2'b0||
							 `sh&&memaddr[0]!=1'b0||
							 (`sw||`sh||`sb)&&(memaddr[31]!=1'b0||(memaddr>=32'h3000)&&!(memaddr>=32'h7f00&&memaddr<=32'h7f0b)&&!(memaddr>=32'h7f10&&memaddr<=32'h7f43))||
							 (`sh||`sb)&&(memaddr>=32'h7f00)||
							 `sw&&(memaddr==32'h7f08||memaddr==32'h7f18))
							 &&(causeM[30:0]==31'b0)?{causeM[31],24'b0,5'b00101,2'b0}:
							(`lw&&memaddr[1:0]!=2'b0||
							 (`lh||`lhu)&&(memaddr[0]!=1'b0)||
							 (`lw||`lh||`lb||`lhu||`lbu)&&(memaddr[31]!=1'b0||(memaddr>=32'h3000)&&!(memaddr>=32'h7f00&&memaddr<=32'h7f0b)&&!(memaddr>=32'h7f10&&memaddr<=32'h7f43))||
							 (`lh||`lhu||`lb||`lbu)&&(memaddr>=32'h7f00))
							&&(causeM[30:0]==31'b0)?{causeM[31],24'b0,5'b00100,2'b0}:
							causeM;
	
							

endmodule
