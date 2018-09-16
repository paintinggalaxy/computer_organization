`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:15:59 12/05/2017 
// Design Name: 
// Module Name:    cmp 
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
`define rd1_less_rd2 (rd1[31]==1&&rd2[31]==0)||(rd1[31]==rd2[31]&&rd1<rd2)
module cmp(
    input [31:0] rd1,
    input [31:0] rd2,
    output beq,
	 output bne,
	 output greater,
	 output less,
	 output greater0,
	 output less0,
	 output equal0,
	 output rd20
    );
	assign bne = (rd1!=rd2);
	assign greater0 = (rd1[31]==0&&rd1!=0);
	assign less0 = (rd1[31]==1);
	assign equal0 = (rd1==0);
	assign greater = !(`rd1_less_rd2);
	assign less = (`rd1_less_rd2);
	assign beq  = (rd1==rd2);
	assign rd20 = (rd2==0);

endmodule
