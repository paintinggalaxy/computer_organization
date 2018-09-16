`timescale 1ns / 1ps
`define staten 5'b00001
`define state0 5'b00010
`define state1 5'b00100
`define state2 5'b01000
`define state3 5'b10000
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:16:45 11/04/2017 
// Design Name: 
// Module Name:    string 
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
module string(
    input clk,
    input clr,
    input [7:0] in,
    output reg out = 0
    );
	 reg[4:0]state=`state0;
	 always@(posedge clk, posedge clr)begin
		if(clr)begin
			state<=`state0;
			out <=0;
		end
		else begin
			case(state)
			`staten: begin state <=`staten;out<=0;end
			`state0: begin
				if(in>="0"&&in<="9") begin state<=`state1;out<=1;end
				else begin state<=`state0;out<=0;end
			end
			`state1:begin
				if(in=="*"||in=="+") state<=`state2;
				else  state<=`staten;
				out<=0;
			end
			`state2:begin
				if(in>="0"&&in<="9") begin state<=`state3;end
				else state<=`staten;
				out<=(in>="0"&&in<="9");
			end
			`state3:begin
				if(in=="*"||in=="+") state<=`state2;
				else state<=`staten;
				out<=0;
			end
			default: state<=`staten;
			endcase
		end
	 end
endmodule
