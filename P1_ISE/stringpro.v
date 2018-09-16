`timescale 1ns / 1ps
`define state0 5'b00001
`define state1 5'b00010
`define state2 5'b00100
`define state3 5'b01000
`define state4 5'b10000
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:06:32 11/09/2017 
// Design Name: 
// Module Name:    stringpro 
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
module stringpro(
    input [7:0] in,
    input clk,
	 input rst,
    output out
    );
	 reg out2 = 0;
	 assign out = out2; 
	 reg[4:0] state = `state0;
	 always@(posedge clk,posedge rst)begin
		if(rst)begin
			state<=`state0;
			out2<=0;
		end
		else begin
		case(state)
		`state4:begin
			
			out2<=0;
		end
		`state0:begin
			if(in>="0"&&in<="9") 
				state<=`state1;
			out2<=1;
		end
		`state1:begin
			if(in=="+"||in=="*") 
				state<=`state2;
			else
				state<=`state4;
			out2<=0;
		end
		`state2:begin
			if(in>="0"&&in<="9")
				state<= `state3;
			else 
				state <=`state4;
			out2<=(in>="0"&&in<="9");
		end
		`state3:begin
			if(in=="*"||in=="+")
				state<=`state2;
			else 
				state<=`state4;
			out2<=0;
		end
		default: begin
			out2<=0;
			state <= `state4;
		end
		endcase
		end
	end
endmodule
