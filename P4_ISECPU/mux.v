`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:05:54 11/25/2017 
// Design Name: 
// Module Name:    mux 
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
module wamux(
	input[1:0] wactr,
	input [4:0] rd,
	input [4:0] rt,
	output [4:0] regaddr
    );
	assign regaddr = (wactr==2'b00)?rd:
						  (wactr==2'b01)?rt:
						  (wactr==2'b10)?5'h1f:5'b0;

endmodule

module wdmux(
	input [1:0] wdctr,
	input [31:0] fromalu,
	input [31:0] fromdm,
	input [31:0] fromifu,
	output [31:0] regdata
	);
	assign regdata = (wdctr==2'b00)?fromalu:
						  (wdctr==2'b01)?fromdm:
						  (wdctr==2'b10)?fromifu:0;


endmodule

module alubmux(
	input bctr,
	input [31:0] fromrf,
	input [31:0] fromext,
	output [31:0] b
	);
	assign b = (bctr==0)?fromrf:fromext;
	
endmodule

