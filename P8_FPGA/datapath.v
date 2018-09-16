`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:17 12/06/2017 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
	 input [4:0] ra1,
	 input[4:0] ra2,
	 input [4:0] wa,
    input [1:0] wdctr,
    input extctr,
    input bctr,
    input [4:0] aluctr,
    input memwrite,
	 input[1:0] dmictr,
	 input [2:0] dmoctr,
    input regwrite,
    input br,
	 input[2:0] mf_d_1_sel,
	 input[2:0] mf_d_2_sel,
	 input[2:0] mf_alu_a_sel,
	 input[2:0] mf_alu_b_sel,
	 input[2:0] mf_dmi_sel,
	 input [1:0] m_realdmM_sel,
	 input cp0we,
	 input exlclr,
	 input pcen, 
    input Den, 
	 input Dclr,
    input Eclr, 
    input clk,
	 input clk2,
    input rst,
	 input [5:0] hwint,
	 input [31:0] prrd,
    output [31:0] instrD,
	 output [31:0] instrE,
	 output [31:0] instrM,
	 output [31:0] instrW,
	 output [31:0] memaddrM,
	 output [31:0] dmi,
	 output prwe,
	 output [3:0] prbe,
	 output intreq
    );
	 wire [31:0] pc8;
	 wire[31:0] pc8D;
	 wire[15:0] immD;
	 wire [31:0]npc;
	 wire [31:0] rd1,rd2;
	 wire[31:0] d_1;
	 wire[31:0] d_2;
	 wire [31:0]extout;
	 
	 wire[31:0] rd1E,rd2E,pc8E,immE;
	 wire[4:0] waE,shamt;
	 wire[31:0] aluout;
	 wire[31:0] realb;
	 wire[31:0] realrd1;
	 wire[31:0] realrd2;
	 wire[31:0] rd2M,aluoutM,pc8M;
	 wire[4:0] waM;
	 wire[31:0] dmM;
	 wire[31:0] aluoutW,pc8W,dmW;
	 wire[4:0] waW;
	 wire [31:0]wdW;
	 wire [31:0] epco;
	 //F level
	 wire [31:0] instr;
	 pc pc (
    .npc(npc), 
    .rst(rst), 
	 .pcen(pcen),
	 .j2intpro(intreq),
    .clk(clk), 
	 .clk2(clk2),
    .br(br), 
    .instr(instr), 
    .pc8(pc8)
    );
	 
	 wire [31:0] causeF;
	 excctrF excctrF(
    .pcaddr(pc8), 
	 .br(br),
    .causeF(causeF)
    );
	 
	 //D level
	 wire [31:0] causeD;
	 D D (
    .instri(instr), 
    .pc8i(pc8), 
	 .causeF(causeF),
    .clk(clk), 
    .rst(rst), 
	 .Den(Den),
	 .Dclr(Dclr),
	 .DEMWclr(intreq),
    .immD(immD), 
    .pc8D(pc8D), 
    .instrD(instrD),
	 .causeD(causeD)
    );
	
	 
	 npc npcu(
    .instr(instrD), 
    .pc8(pc8D), 
    .ra(d_1), 
	 .epc(epco),
	 .greater0(greater0),
	 .less0(less0),
	 .equal0(equal0),
    .beq(beq), 
    .npc(npc)
    );
	 
	 
	 grf grf (
    .regwrite(regwrite), 
    .ra1(ra1), 
    .ra2(ra2), 
    .wa(waW), 
    .wd(wdW), 
    .clk(clk), 
    .rst(rst), 
    .rd1(rd1), 
    .rd2(rd2)
    );
	 
	 
	 mf_d_1 mf_d_1 (
    .aluoutM(aluoutM),
	 .pc8E(pc8E),
	 .pc8M(pc8M),
    .wdW(wdW), 
    .rd1(rd1), 
    .mf_d_1_sel(mf_d_1_sel), 
    .d_1(d_1)
    );
	 
	 
	 mf_d_2 mf_d_2 (
    .aluoutM(aluoutM), 
	 .pc8E(pc8E),
	 .pc8M(pc8M),
    .wdW(wdW), 
    .rd2(rd2), 
    .mf_d_2_sel(mf_d_2_sel), 
    .d_2(d_2)
    );
	 

	 
	 ext ext (
    .imm(immD), 
    .extctr(extctr), 
    .extout(extout)
    );
	 
	 
	 cmp cmp (
    .rd1(d_1), 
    .rd2(d_2), 
	 .equal0(equal0),
	 .greater0(greater0),
	 .less0(less0),
    .beq(beq)
    );
	 
	 wire [31:0] causeD2;
	 
	 excctrD excctrD(
    .causeD(causeD), 
    .instrD(instrD), 
	 .npc(npc),
	 .br(br),
    .causeD2(causeD2)
    );
	 
	 //E level
	 
	 wire [31:0] causeE;
	 E E (
	 .instrD(instrD),
	 .causeD(causeD2),
    .rd1D(d_1), 
    .rd2D(d_2), 
    .waD(wa), 
    .immD(extout), 
    .pc8D(pc8D), 
    .clk(clk), 
    .rst(rst), 
	 .DEMWclr(intreq),
	 .Eclr(Eclr),
    .rd1E(rd1E), 
    .rd2E(rd2E), 
    .waE(waE), 
    .immE(immE), 
    .pc8E(pc8E),
	 .instrE(instrE),
	 .causeE(causeE),
	 .shamt(shamt)
    );
	 
	 
	 alu alu (
    .A(realrd1), 
    .B(realb), 
	 .shamt(shamt),
    .aluctr(aluctr), 
    .aluout(aluout),
	 .overflow(overflow)
    );
	 
	 
	 m_alu_b m_alu_b (
    .bctr(bctr), 
    .fromrf(realrd2), 
    .fromext(immE), 
    .b(realb)
    );
	 
	 
	 mf_alu_a mf_alu_a (
    .aluoutM(aluoutM), 
    .wdW(wdW), 
    .rd1E(rd1E), 
	 .pc8M(pc8M),
    .mf_alu_a_sel(mf_alu_a_sel), 
    .alu_a(realrd1)
    );
	 
	 
	 
	 mf_alu_b mf_alu_b (
    .aluoutM(aluoutM), 
    .wdW(wdW), 
    .rd2E(rd2E), 
	 .pc8M(pc8M),
	 .mf_alu_b_sel(mf_alu_b_sel), 
    .alu_b(realrd2)
    );
	 
	 wire [31:0] causeE2;
	 excctrE excctrE (
    .causeE(causeE), 
    .overflow(overflow), 
    .instrE(instrE), 
    .causeE2(causeE2)
    );
	 
	 //M level
	 
	 wire [31:0] causeM;
	 M M (
    .rd2E(realrd2), 
	 .causeE(causeE2),
    .aluout(aluout), 
    .memaddr(aluout), 
    .pc8E(pc8E), 
	 .instrE(instrE),
    .waE(waE), 
    .clk(clk), 
    .rst(rst),
	 .DEMWclr(intreq),
    .rd2M(rd2M), 
    .aluoutM(aluoutM), 
    .memaddrM(memaddrM), 
    .pc8M(pc8M), 
	 .instrM(instrM),
	 .causeM(causeM),
    .waM(waM)
    );
	 
	 
	 d_enable d_enable(
		.dmnw(intreq),
		.we(memwrite),
		.d_enable_sel(memaddrM),
		.todm(realmemwrite),
		.todev(prwe)
	 );
	 
	 dm dmu (
    .memaddr(memaddrM), 
    .dmi(dmi), 
	 .dmictr(dmictr),
	 .prbe(prbe),
    .clk(clk2), 
    .rst(rst), 
    .memwrite(realmemwrite), 
    .dm(dmM)
    );
	 
	 
	 
	 mf_dmi mf_dmi (
    //.aluoutM(aluoutM), 
    .wdW(wdW), 
    .dmM(rd2M), 
    .mf_dmi_sel(mf_dmi_sel), 
    .dmi(dmi)
    );
	 
	 wire[31:0] causeM2;
	 excctrM excctrM (
    .memaddr(memaddrM), 
    .causeM(causeM), 
    .instrM(instrM), 
    .hwint(hwint), 
    .causeM2(causeM2)
    );
	 
	 wire [31:0] cp0dout;
	 cp0 cp0 (
    .cp0addr(instrM[15:11]),
    .cp0din(dmi), 
    .pc8(pc8M), 
    .causeM2(causeM2), 
    .cp0we(cp0we), 
    .exlclr(exlclr), 
    .clk(clk), 
    .rst(rst), 
    .intreq(intreq), 
    .epco(epco), 
    .cp0dout(cp0dout)
    );
	 
	 wire [31:0] realdmM;
	 m_realdmM m_realdmM (
    .fromdm(dmM), 
    .fromcp0(cp0dout),
	 .fromdev(prrd),
    .m_realdmM_sel(m_realdmM_sel), 
	 .memaddrM(memaddrM),
    .realdmM(realdmM)
    );
	 
	 

	 //W level
	 W W (
    .pc8M(pc8M), 
    .dmM(realdmM), 
    .aluoutM(aluoutM), 
    .waM(waM), 
    .instrM(instrM), 
    .clk(clk), 
    .rst(rst), 
	 .DEMWclr(intreq),
    .pc8W(pc8W), 
    .dmW(dmW), 
    .aluoutW(aluoutW), 
    .waW(waW),
	 .instrW(instrW)
    );
	 
	 wire[31:0] realdm;
	 dmoext dmoext (
    .dmW(dmW), 
	 .memaddr(aluoutW),
    .dmoctr(dmoctr), 
    .realdm(realdm)
    );
	 
	 
	 m_wd m_wd (
    .wdctr(wdctr), 
    .fromalu(aluoutW), 
    .fromdm(realdm), 
    .frompc8(pc8W), 
    .wdW(wdW)
    );
	 
	 	 
	 
	 


endmodule
