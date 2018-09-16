`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:58:24 12/05/2017 
// Design Name: 
// Module Name:    hazardmonitor 
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
module hazardmonitor(
	 input [31:0] instr,
    input Tuse_rs0,
    input Tuse_rs1,
    input Tuse_rt0,
    input Tuse_rt1,
    input Tuse_rt2,
	 input [4:0] waE,
	 input [4:0] waM,
    input [2:0] resE,
    input [2:0] resM,
    input [2:0] resW,
	 input busy,
	 input start,
    output stall
    );
	 
	 wire[5:0] op;
	 wire[5:0] f;
	 assign op = instr[31:26];
	 assign f = instr[5:0];
	 
	 wire stall_rs, stall_rt, stall_md;
	 wire stall_rs0_e1,stall_rs0_e2,stall_rs0_m1,stall_rs1_e2;
	 wire stall_rt0_e1,stall_rt0_e2,stall_rt0_m1,stall_rt1_e2;
	 
	 assign stall_rs = stall_rs0_e1||stall_rs0_e2||stall_rs0_m1||stall_rs1_e2;
	 assign stall_rt = stall_rt0_e1||stall_rt0_e2||stall_rt0_m1||stall_rt1_e2;
	 
	 assign stall_rs0_e1 = Tuse_rs0&&(resE==`alu)&&(instr[25:21]==waE)&&(waE!=5'b0);
	 assign stall_rs0_e2 = Tuse_rs0&&(resE==`dm)&&(instr[25:21]==waE)&&(waE!=5'b0);
	 assign stall_rs0_m1 = Tuse_rs0&&(resM==`dm)&&(instr[25:21]==waM)&&(waM!=5'b0);
	 assign stall_rs1_e2 = Tuse_rs1&&(resE==`dm)&&(instr[25:21]==waE)&&(waE!=5'b0);
	 
	 assign stall_rt0_e1 = Tuse_rt0&&(resE==`alu)&&(instr[20:16]==waE)&&(waE!=5'b0);
	 assign stall_rt0_e2 = Tuse_rt0&&(resE==`dm)&&(instr[20:16]==waE)&&(waE!=5'b0);
	 assign stall_rt0_m1 = Tuse_rt0&&(resM==`dm)&&(instr[20:16]==waM)&&(waM!=5'b0);
	 assign stall_rt1_e2 = Tuse_rt1&&(resE==`dm)&&(instr[20:16]==waE)&&(waE!=5'b0);
	 
	 assign stall_md = (busy||start)&&(`mult||`multu||`div||`divu||`mflo||`mfhi||`mthi||`mtlo);
	 
	 assign stall = stall_rs||stall_rt||stall_md;


endmodule
