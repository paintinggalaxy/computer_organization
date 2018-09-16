`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:08:49 11/04/2017 
// Design Name: 
// Module Name:    gray 
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
module gray(
    input Clk,
    input Reset,
    input En,
    output [2:0] Output,
    output Overflow
    );
	 reg [7:0] memor[1023:0];
	 reg [2:0] media = 0;
	 reg over = 0;
	 assign Overflow = over;
	 assign Output[2]=media[2];
	 assign Output[1]=media[2]^media[1];
	 assign Output[0]=media[1]^media[0];
	 always@(posedge Clk)begin
		if(Reset)begin
			media<=0;
			over<=0;
		end
		else if(En&&!over)
			{over,media}<=media+1;
		else if(En&&over)begin
			media<=media+1;
		end
	 end
endmodule
