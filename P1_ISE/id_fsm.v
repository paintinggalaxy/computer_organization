`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:47:23 10/08/2017 
// Design Name: 
// Module Name:    id_fsm 
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
module id_fsm(
    input [7:0] char,
    input clk,
    output reg out
    );
	 integer state = 0;
	initial out = 0;
	always @(posedge clk)begin
		case(state)
		0:
			begin
				if(char>=65&&char<=90||char>=97&&char<=122)begin
					state<=1;
					out<=0;
					end
				else begin
					state <= 0;
					out <= 0;
					end
			end
		1:
			begin
				if(char>=48&&char<=57)begin
					state<=2;
					out<=1;
					end
				else if(char>=65&&char<=90||char>=97&&char<=122)begin
					state<=1;
					out<=0;
					end
				else begin
					state<=0;
					out<=0;
					end
			end
		2:
			begin
				if(char>=48&&char<=57)begin
					state<=2;
					out<=1;
				end
				else if(char>=65&&char<=90||char>=97&&char<=122)begin
					state<=1;
					out<=0;
				end
				else begin
					state<=0;
					out<=0;
				end
			end
		default:begin
			state<=0;
			out<=0;
			end
		endcase
	end
endmodule
