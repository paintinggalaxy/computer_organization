`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:51:34 12/05/2017 
// Design Name: 
// Module Name:    stallctr 
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
module stallctr(
    input stall,
    output pcen,
    output Den,
    output Eclr
    );
	 assign pcen = (stall==1)?1'b0:1'b1;
	 assign Den = (stall==1)?1'b0:1'b1;
	 assign Eclr = (stall==1)?1'b1:1'b0;


endmodule
