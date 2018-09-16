`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:37:18 12/10/2017 
// Design Name: 
// Module Name:    mainctrW 
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
`include "head.v"
module mainctrW(
    input [31:0] instrW,
	 //input changeW,
	 output regwrite,
	 output [1:0] wdctr,
	 output exlclr,
	 output [2:0] dmoctr
    );
	 wire[5:0] op, f;
	 wire[4:0] t,bits106;
	 wire[4:0] bits2521;
	 assign t = instrW[20:16];
	 assign op = instrW[31:26];
	 assign f = instrW[5:0];
	 assign bits2521 = instrW[25:21];
	 assign bits106 = instrW[10:6];
	 
	 assign wdctr = (`lw||`lh||`lb||`lbu||`lhu||`mfc0)?2'b01:
						 (`jal||`jalr/*||`bgezal*/)?2'b10:
						 2'b00;
						 
	 assign regwrite = `addu||`add||`addiu||`addi||`subu||`sub||
							 `lw||`lh||`lhu||`lb||`lbu||
							 `sll||`srl||`sra||`sllv||`srlv||`srav||
							 `and||`xor||`nor||`or||
							 `andi||`xori||`ori||`lui||
							 `slti||`sltiu||`sltu||`slt||
							 `jalr||`jal||
							 //(`bgezal&&!changeW)||(`movz&&!changeW)||`rotrv||
							 `mfhi||`mflo||
							 `mfc0;
							 
	 assign dmoctr = (`lw)?`dm_lw:
						 (`lh)?`dm_lh:
						 (`lb)?`dm_lb:
						 (`lbu)?`dm_lbu:
						 (`lhu)?`dm_lhu:3'b000;
						 
	assign exlclr = (`eret);

endmodule
