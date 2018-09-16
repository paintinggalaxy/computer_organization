`timescale 1ns / 1ps
`define b3  mem[memaddr[11:2]][31:24]
`define b2  mem[memaddr[11:2]][23:16]
`define b1  mem[memaddr[11:2]][15:8]
`define b0  mem[memaddr[11:2]][7:0]
`define h1  mem[memaddr[11:2]][31:16]
`define h0  mem[memaddr[11:2]][15:0]
`define signb3 mem[memaddr[11:2]][31]
`define signb2 mem[memaddr[11:2]][23]
`define signb1 mem[memaddr[11:2]][15]
`define signb0 mem[memaddr[11:2]][7]

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
	 input [1:0]dmoctr,
	 input [1:0]dmictr,
    output [31:0] dm
    );
	 integer i;
	 localparam dm_sw = 2'b00;
	 localparam	dm_sh = 2'b01;
	 localparam dm_sb = 2'b11;
	 //store units
	 reg[31:0] mem[1023:0]; 
	 assign dm = (dmoctr==2'b00)?mem[memaddr[11:2]]:  //lw
					 (dmoctr==2'b01)?memaddr[1]?{{16{`signb3}},`h1}:{{16{`signb1}},`h0}: //lh
					 (dmoctr==2'b11)?(memaddr[1]?(memaddr[0]?{{24{`signb3}},`b3}:{{24{`signb2}},`b2}):(memaddr[0]?{{24{`signb1}},`b1}:{{24{`signb0}},`b0})):32'b0;  //lb
	 initial begin
		for(i=0;i<1024;i=i+1)
			mem[i]<=0;
	 end
	 
	 //execution
	 always@(posedge clk)begin
		if(rst == 1)begin
			for(i=0;i<1024;i = i+1)
				mem[i] <= 0;
		end
		else if(memwrite==1)begin
			if(dmictr==dm_sw)begin
				mem[memaddr[11:2]] <= dmi;
				$display("%d@%h: *%h <= %h",$time,mips.datapath.M.pc8-8, memaddr,dmi);
			end
			else if(dmictr==dm_sh)begin
					if(memaddr[1])
						`h1<=dmi[15:0];
					else
						`h0<=dmi[15:0];
					$display("%d@%h: *%h <= %h",$time,mips.datapath.M.pc8-8, memaddr,dmi[15:0]);
			end
			else begin
				if(memaddr[1:0]==2'b11)
					`b3<= dmi[7:0];
				else if(memaddr[1:0]==2'b10)
					`b2<= dmi[7:0];
				else if(memaddr[1:0]==2'b01)
					`b1<= dmi[7:0];
				else 
					`b0<= dmi[7:0];
				$display("%d@%h: *%h <= %h",$time,mips.datapath.M.pc8-8, memaddr,dmi[7:0]);
			end
		end
		else 
			;
	 end


endmodule