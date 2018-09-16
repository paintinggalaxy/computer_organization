`timescale 1ns / 1ps
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
//////////////////////////////////////////////////////////////////////////////////
module dm(
    input [31:0] memaddr,
    input [31:0] wd,
    input clk,
    input rst,
    input memwrite,
    output [31:0] data
    );
	 integer i;
	 //store units
	 reg[31:0] mem[1023:0];
	 
	 assign data = mem[memaddr[11:2]];
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
			mem[memaddr[11:2]] <= wd;
			$display("@%h: *%h <= %h",u0.ui.pc, memaddr,wd);
		end
		else 
			;
	 end


endmodule
