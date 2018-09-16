`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:13:03 12/26/2017 
// Design Name: 
// Module Name:    excctrF 
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
module excctrF(
    input [31:0] pcaddr,
	 input br,
    output [31:0] causeF
    );
	 
	 assign causeF = ((pcaddr-8)>=32'h3000&&(pcaddr-8)<32'h4fff&&pcaddr[1:0]==2'b00)?{br, 31'b0}:{br,24'b0,5'b00100,2'b0};


endmodule
