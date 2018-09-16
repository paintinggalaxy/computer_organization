`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:29:45 12/05/2017 
// Design Name: 
// Module Name:    W 
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
module W(
	 input [31:0] pc8M,
	 input [31:0] dmM,
	 input [31:0] aluoutM,
    input [4:0] waM,
	 input [31:0] instrM,
    input clk,
    input rst,
	 input DEMWclr,
	 output[31:0] pc8W,
	 output[31:0] dmW,
	 output[31:0] aluoutW,
    output [4:0] waW
    );
	 reg [4:0] wa=0;
	 reg [31:0] instr = 0;
	 reg [31:0] pc8 = 0;
	 reg [31:0] aluout = 0;
	 reg [31:0] dm = 0;


	 assign waW = wa;
	 assign aluoutW = aluout;
	 assign pc8W = pc8;
	 assign dmW = dm;

	 always@(posedge clk)begin
		if(rst)begin
			pc8<=0;
			wa<= 0;
			instr<=0;
			aluout<=0;
			dm<=0;
		end
		else if(DEMWclr)begin
			pc8<=pc8M;
			wa<= 0;
			instr<=0;
			aluout<=0;
			dm<=0;
		end
		else begin
			pc8<= pc8M;
			wa<= waM;
			instr<= instrM;
			aluout<=aluoutM;
			dm<=dmM;
		end
	 end
	 
endmodule
