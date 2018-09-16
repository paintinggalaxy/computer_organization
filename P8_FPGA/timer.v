`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:34:01 12/28/2017 
// Design Name: 
// Module Name:    timer 
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
`define im ctrl[3]
`define mode ctrl[2:1]
`define enable ctrl[0]

`define idle 2'b00
`define cnting 2'b10


module timer(
    input clk,
    input rst,
    input [2:0] addr,
    input we,
    input [31:0] din,
    output [31:0] dout,
    output irq
    );
	 
	 reg [31:0] ctrl = 0;
	 reg [31:0] preset = 0;
	 reg [31:0] count = 0;
	 reg [1:0] state = 0;
	 reg [26:0] sec = 0;
	 reg inter = 0;


	 assign irq = inter&&`im;
	 
	 assign dout = (addr==3'b000)?ctrl:
						(addr==2'b001)?preset:
						(addr==2'b010)?count:
						0;
	 
	
	
	always@(posedge clk)begin
		 if(!rst)begin
			ctrl <= 0;
			preset<= 0;
			count<= 0;
			state<= 0;
			inter<= 0;
			sec <=0;
		 end
		 //begin
			case(state)
				`idle:begin
					state<=(`enable)?`cnting:`idle;
					count<=(`enable)?preset:0;
					inter<=(`enable)?1'b1:inter;
					sec<= 0;
				end
			
				`cnting:begin
					if(count!=-1)  begin
						count<=(`enable&&sec[25]==1)?count-1:count;
						sec <= (sec[25]==1)?0:sec+1;
						inter<=(`enable&&sec[25]==1)?1:0;
						state<= (`enable)?state:`idle;
					end
					else begin 
						state<=`idle;
						count <= count-1;
						inter<= 0;
						`enable<=(`mode==2'b00)?1'b0:1'b1;
					end
				end
				default:state<=`idle;
			endcase
		//end
		 if(we==1'b1)begin
			if(addr==2'b00) ctrl<={28'b0, din[3:0]};
			else if(addr==2'b10) count<= din;
			else if(addr==2'b01) preset<=din;
		 end
		 
	end
endmodule
	