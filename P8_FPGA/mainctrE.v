`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:30:00 12/10/2017 
// Design Name: 
// Module Name:    mainctrE 
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

module mainctrE(
    input [31:0] instrE,
	 output bctr,
	 output [4:0] aluctr

    );
	 wire[5:0] op, f, t;
	 wire[4:0] bits106;
	 assign op = instrE[31:26];
	 assign f = instrE[5:0];


	 
	 assign bctr = `ori||`andi||`xori||
						`addiu||`addi||
						`lw||`lb||`lbu||`lh||`lhu||`sw||`sb||`sh||
						`slti||`sltiu||`lui;
	 
	 assign aluctr = (`addu||`addiu)?`alu_addu:
						  (`subu)?`alu_subu:
						  (`sub)?`alu_sub:
						  (`add||`addi)?`alu_add:
						  (`ori||`or)?`alu_ori:
						  (`lui)?`alu_lui:
						  (`slt||`slti)?`alu_slt:
						  (`sll)?`alu_sll:
						  (`srl)?`alu_srl:
						  (`sra)?`alu_sra:
						  (`sllv)?`alu_sllv:
						  (`srlv)?`alu_srlv:
						  (`srav)?`alu_srav:
						  (`and||`andi)?`alu_and:
						  (`xor||`xori)?`alu_xor:
						  (`nor)?`alu_nor:
						  (`sltu||`sltiu)?`alu_sltu:
						  3'b0;
	

endmodule
