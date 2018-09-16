`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:45:57 12/05/2017 
// Design Name: 
// Module Name:    ATcoder 
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
//step1:unormal rt?
//step2:Tuse of rs, rt
//step3:res
`include "head.v"
 
module ATcoder(
    input [31:0] instr,
	 input change,
    output [4:0] ra1,
    output [4:0] ra2,
    output [4:0] wa,
    output Tuse_rs0,
	 output Tuse_rs1,
	 output Tuse_rt0,
	 output Tuse_rt1,
	 output Tuse_rt2,
    output [2:0]res
    );
	 
	 //ra1,ra2,wa
	 wire[5:0] op, f;
	 wire[4:0] t,bits106;
	 assign op = instr[31:26];
	 assign f = instr[5:0];
	 assign t = instr[20:16];
	 assign bits106 = instr[10:6];
	 assign ra1 = instr[25:21];
	 assign ra2 = instr[20:16];
	 
	 
	 
	 
	 //1
	 assign wa = (`jal||`bgezal||`bgezall)?5'b11111:
					 (`lw||`lb||`lh||`lhu||`lbu||
					  `andi||`xori||`lui||`ori||
					  `addi||`addiu||
					  `slti||`sltiu)?instr[20:16]:instr[15:11];
	 
	 //2
	 //Tuse
	 assign Tuse_rs0 = `beq ||`bne||`bltz||`blez||`bgtz||`bgez||`bgezal||`bgezall||
							 `jr||`jalr;
							 
	 assign Tuse_rs1 = `addu||`add||`subu||`sub||`addiu||`addi||
							 `sw||`sb||`sh||`lw||`lh||`lhu||`lb||`lbu||
							 `sllv||`srlv||`srav||
							 `and||`andi||`xor||`xori||`nor||`ori||`or||
							 `sltu||`slti||`sltiu||`slt||
							 `mult||`multu||`div||`divu||
							 `mthi||`mtlo||
							 `rotrv||(`movz&&!change);
							 
	 assign Tuse_rt0 = `beq||`bne||`movz;
	 
	 assign Tuse_rt1 = `addu||`add||`subu||`sub||
							 `and||`xor||`nor||`or||
							 `sll||`srl||`sra||`sllv||`srlv||`srav||`rotrv||
							 `slt||`sltu||
							 `mult||`multu||`div||`divu;
							 
	 assign Tuse_rt2 = `sw||`sb||`sh;
	 
	 //res
	 assign res = (`add||`addu||`subu||`sub||`addi||`addiu||
					   `sll||`srl||`sra||`sllv||`srlv||`srav||`rotrv||
						`ori||`andi||`xori||`lui||`and||`xor||`nor||`or||
						`sltu||`sltiu||`slti||`slt||
						`mflo||`mfhi||
						(`movz&&!change))?`alu:
					  (`lw||`lb||`lbu||`lhu||`lh)?`dm:
					  (`jal||(`bgezal&&!change)||`jalr)?`pc:
					  `nw;
	 
	 


endmodule
