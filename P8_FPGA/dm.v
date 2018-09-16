`timescale 1ns / 1ps

`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:06:12 11/25/2017 
// Design Name: 
// Module Name:    dm 
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

module dm(
    input [31:0] memaddr,
    input [31:0] dmi,
    input clk,
    input rst,
    input memwrite,
	 input [1:0]dmictr,
	 output [3:0] prbe,
    output [31:0] dm
    );
	 //integer i;
	 //store units
	 //reg[31:0] mem[2047:0]; 
	 //assign dm = mem[memaddr[12:2]];
	 assign prbe = (dmictr==`dm_sw)?4'b1111:
						(dmictr==`dm_sh)?((memaddr[1]==1)?4'b1100:
												4'b0011):
						(dmictr==`dm_sb)?((memaddr[1:0]==2'b00)?4'b0001:
												(memaddr[1:0]==2'b01)?4'b0010:
												(memaddr[1:0]==2'b10)?4'b0100:
												4'b1000):4'b0;
	 wire [3:0] be;
	 assign be = {4{memwrite}}&prbe;
	 
	 wire [31:0] writein;
	 
	 assign writein =	(be==4'b1111)?dmi:
							(be==4'b1100)?{dmi[15:0],16'b0}:
							(be==4'b0011)?{16'b0, dmi[15:0]}:
							(be==4'b1000)?{dmi[7:0],24'b0}:
							(be==4'b0100)?{8'b0,dmi[7:0],16'b0}:
							(be==4'b0010)?{16'b0,dmi[7:0], 8'b0}:
							(be==4'b0001)?{24'b0,dmi[7:0]}:32'b0;
																	
	 

	dmpro mem (
	  .clka(clk), // input clka
	  .wea(be), // input [3 : 0] wea
	  .addra(memaddr[12:2]), // input [10 : 0] addra
	  .dina(writein), // input [31 : 0] dina
	  .douta(dm) // output [31 : 0] douta
	);
	/*
	 //execution
	 always@(posedge clk)begin
		if(rst)begin
			for(i=0;i<2048;i = i+1)
				mem[i] <= 0;
		end
		else 
			mem[memaddr[12:2]]<= writein;
	end
	*/


endmodule
