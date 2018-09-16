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
	 input [2:0]dmictr,
	 output [3:0] prbe,
    output [31:0] dm
    );
	 integer i;
	 //store units
	 reg[31:0] mem[4095:0]; 
	 assign dm = mem[memaddr[13:2]];
	 assign prbe = (dmictr==`dm_sw)?4'b1111:
						(dmictr==`dm_sh)?((memaddr[1]==1)?4'b1100:
												4'b0011):
						(dmictr==`dm_sb)?((memaddr[1:0]==2'b00)?4'b0001:
												(memaddr[1:0]==2'b01)?4'b0010:
												(memaddr[1:0]==2'b10)?4'b0100:
												4'b1000):4'b0;
	 initial begin
		for(i=0;i<4096;i=i+1)
			mem[i]<=0;
	 end
	 
	 //execution
	 always@(posedge clk)begin
		if(rst == 1)begin
			for(i=0;i<4096;i = i+1)
				mem[i] <= 0;
		end
		else if(memwrite==1)begin
			//sw
			if(dmictr==`dm_sw)begin
				mem[memaddr[13:2]] <= dmi;
				$display("%d@%h: *%h <= %h",$time,cpu.datapath.M.pc8-8, memaddr,dmi);
			end
			//sh
			else if(dmictr==`dm_sh)begin
					if(memaddr[1])begin
						`h1<=dmi[15:0];
						$display("%d@%h: *%h <= %h",$time,cpu.datapath.M.pc8-8,{18'b0,memaddr[13:2],2'b0},{dmi[15:0],`h0});
					end
					else begin
						`h0<=dmi[15:0];
						$display("%d@%h: *%h <= %h",$time,cpu.datapath.M.pc8-8,{18'b0,memaddr[13:2],2'b0},{`h1,dmi[15:0]});
					end
			end
			//sb
			else begin
				if(memaddr[1:0]==2'b11) begin
					`b3<= dmi[7:0];
					$display("%d@%h: *%h <= %h",$time,cpu.datapath.M.pc8-8,{18'b0,memaddr[13:2],2'b0},{dmi[7:0],`b2,`h0});
				end
				else if(memaddr[1:0]==2'b10)begin
					`b2<= dmi[7:0];
					$display("%d@%h: *%h <= %h",$time,cpu.datapath.M.pc8-8,{18'b0,memaddr[13:2],2'b0},{`b3,dmi[7:0],`h0});
				end
				else if(memaddr[1:0]==2'b01)begin
					`b1<= dmi[7:0];
					$display("%d@%h: *%h <= %h",$time,cpu.datapath.M.pc8-8,{18'b0,memaddr[13:2],2'b0},{`h1,dmi[7:0],`b0});
				end
				else begin
					`b0<= dmi[7:0];
					$display("%d@%h: *%h <= %h",$time,cpu.datapath.M.pc8-8,{18'b0,memaddr[13:2],2'b0},{`h1,`b1,dmi[7:0]});
				end
				
			end
		end
		else 
			;
	 end


endmodule
