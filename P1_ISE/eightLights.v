`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:44:25 10/26/2017 
// Design Name: 
// Module Name:    eightLights 
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
module eightLights(
	 input clk,
    input control,
    input reset,
    output [7:0] dout
    );
	 reg[7:0] a;
	 assign dout = a;
	 always@(posedge clk, reset)
	 if(reset)
		a = 8'b11111111;
	 else begin
		if(control)begin
			if(a==8'b11111111)
				a<=8'b00000001;
			
		end
		else begin
		
		
		end
	 end


endmodule
