`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:31:15 11/25/2017 
// Design Name: 
// Module Name:    grf 
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
module grf(
    input regwrite,
    input [4:0] ra1,
    input [4:0] ra2,
    input [4:0] wa,
    input [31:0] wd,
    input clk,
    input rst,
    output [31:0] rd1,
    output [31:0] rd2
    );
	
	//store units
	reg[31:0] regs[31:0];
	
	assign rd1 = regs[ra1];
	assign rd2 = regs[ra2];
	
	integer i;
	
	initial begin
		for(i=0;i<1024;i=i+1)
			regs[i] = 0;
	end
	//exceution
	always@(posedge clk)begin
		if(rst==1)begin
			for(i =0;i<28;i = i+1)
				regs[i] <=0;
			regs[28]<=32'h00001800;
			regs[29]<=32'h00002ffc;
			regs[30]<=32'b0;
			regs[31]<=32'b0;
		end
		else if(regwrite==1)begin
			if(wa!=5'b0)begin
				regs[wa] <= wd;
				$display("@%h: $%d <= %h", u0.ui.pc, wa,wd);
			end
			else
				;
		end
	end

endmodule
