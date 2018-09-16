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
    output [1:0]res
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
	 assign wa = (`jal||`bgezal)?5'b11111:
					 (`lw||`lui||`ori||`addiu||`lb||`lh)?instr[20:16]:instr[15:11];
	 
	 //2
	 //Tuse
	 assign Tuse_rs0 = `beq ||`jr||`bne||`bltz||`blez||`bgtz||`bgez||`bgezal;
	 assign Tuse_rs1 = `addu||`subu||`sw||`lw||`or||`slt||`sb||`addiu||`sh||`lh||`lb||`ori||(`movz&&!change)||`rotrv;
	 assign Tuse_rt0 = `beq||`bne||`movz;
	 assign Tuse_rt1 = `addu||`subu||`or||`slt||`rotrv;
	 assign Tuse_rt2 = `sw||`sb||`sh;
	 
	 //res
	 assign res = (`addu||`subu||`ori||`lui||`or||`slt||`addiu||(`movz&&!change)||`rotrv)?2'b01:
					  (`lw)?2'b10:
					  (`jal||(`bgezal&&!change))?2'b11:
					  2'b00;
	 
	 


endmodule
