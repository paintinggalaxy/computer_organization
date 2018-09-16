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
	 input[2:0] dmictr,
	 input [2:0] dmoctr,
    input regwrite,
    input br,
	 input[2:0] mf_d_1_sel,
	 input[2:0] mf_d_2_sel,
	 input[2:0] mf_alu_a_sel,
	 input[2:0] mf_alu_b_sel,
	 input[2:0] mf_dmi_sel,
	 input [2:0] m_aluoutE_sel,
	 input lowrite,
	 input hiwrite,
	 input pcen, 
    input Den, 
	 input Dclr,
    input Eclr, 
    input clk,
    input rst,
	 input [2:0] mdctr,
	 input start,
    output [31:0] instrD,
	 output beq,
	 output bne,
	 output greater,
	 output less,
	 output greater0,
	 output less0,
	 output equal0,
	 output rd20,
	 output busy
    );
	 wire [31:0] pc8, instr,instrE,instrM;
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
	 wire[31:0] rd2M,aluoutM,memaddrM,pc8M;
	 wire[4:0] waM;
	 wire[31:0] dmM;
	 wire[31:0] dmi;
	 wire[31:0] aluoutW,pc8W,dmW;
	 wire[4:0] waW;
	 wire [31:0]wdW, ra;
	 //F level
	 pc pc (
    .npc(npc), 
    .rst(rst), 
	 .pcen(pcen),
    .clk(clk), 
    .br(br), 
    .instr(instr), 
    .pc8(pc8)
    );
	 
	 //D level
	 D D (
    .instri(instr), 
    .pc8i(pc8), 
    .clk(clk), 
    .rst(rst), 
	 .Den(Den),
	 .Dclr(Dclr),
    .immD(immD), 
    .pc8D(pc8D), 
    .instrD(instrD)
    );
	 
	 
	 npc npcu(
    .instr(instrD), 
    .pc8(pc8D), 
    .ra(d_1), 
	 .greater0(greater0),
	 .less0(less0),
	 .equal0(equal0),
	 .bne(bne),
	 .greater(greater),
	 .less(less),
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
	 .bne(bne),
    .beq(beq),
	 .greater(greater),
	 .less(less),
	 .rd20(rd20)
    );
	 
	 
	 //E level
	 E E (
	 .instrD(instrD),
    .rd1D(d_1), 
    .rd2D(d_2), 
    .waD(wa), 
    .immD(extout), 
    .pc8D(pc8D), 
    .clk(clk), 
    .rst(rst), 
	 .Eclr(Eclr),
    .rd1E(rd1E), 
    .rd2E(rd2E), 
    .waE(waE), 
    .immE(immE), 
    .pc8E(pc8E),
	 .instrE(instrE),
	 .shamt(shamt)
    );
	 
	 
	 alu alu (
    .A(realrd1), 
    .B(realb), 
	 .shamt(shamt),
    .aluctr(aluctr), 
    .aluout(aluout)
    );
	 wire [31:0] hio, loo, realaluout;
	 multdiv md (
    .A(realrd1), 
    .B(realb), 
    .mdctr(mdctr), 
    .rst(rst), 
    .clk(clk), 
    .start(start), 
	 .lowrite(lowrite),
	 .hiwrite(hiwrite),
    .busy(busy),
    .hio(hio), 
    .loo(loo)
    );
	 
	 
	 m_aluoutE m_aluoutE (
    .fromalu(aluout), 
    .fromlo(loo), 
    .fromhi(hio), 
    .m_aluoutE_sel(m_aluoutE_sel), 
    .realaluout(realaluout)
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
	 
	 
	 //M level
	 M M (
    .rd2E(realrd2), 
    .aluout(realaluout), 
    .memaddr(realaluout), 
    .pc8E(pc8E), 
	 .instrE(instrE),
    .waE(waE), 
    .clk(clk), 
    .rst(rst), 
    .rd2M(rd2M), 
    .aluoutM(aluoutM), 
    .memaddrM(memaddrM), 
    .pc8M(pc8M), 
	 .instrM(instrM),
    .waM(waM)
    );
	 
	 
	 dm dmu (
    .memaddr(memaddrM), 
    .dmi(dmi), 
	 .dmictr(dmictr),
    .clk(clk), 
    .rst(rst), 
    .memwrite(memwrite), 
    .dm(dmM)
    );
	 
	 
	 
	 mf_dmi mf_dmi (
    //.aluoutM(aluoutM), 
    .wdW(wdW), 
    .dmM(rd2M), 
    .mf_dmi_sel(mf_dmi_sel), 
    .dmi(dmi)
    );
	 
	 

	 //W level
	 W W (
    .pc8M(pc8M), 
    .dmM(dmM), 
    .aluoutM(aluoutM), 
    .waM(waM), 
    .instrM(instrM), 
    .clk(clk), 
    .rst(rst), 
    .pc8W(pc8W), 
    .dmW(dmW), 
    .aluoutW(aluoutW), 
    .waW(waW)
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
