`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:40:34 12/06/2017 
// Design Name: 
// Module Name:    mips 
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
//////////////////////////////////////////////////////////////////////////////////\
`include "head.v"
//step1 controller datapath port attention to the size
//step2 wire
module cpu(
    input clk,
    input reset,
	 input hwint2,
	 input hwint3,
	 input hwint4,
	 input hwint5,
	 input hwint6,
	 input hwint7,
	 input [31:0] prrd,
	 output [3:0] prbe,
	 output [31:0] praddr,
	 output [31:0] prwd,
	 output prwe
    );
	 wire [5:0] hwint;
	 assign hwint = {hwint7,hwint6,hwint5,hwint4,hwint3,hwint2};
	 wire [31:0] instrD;
	 wire [4:0] ra1,ra2,wa;
	 wire [4:0] aluctr;
	 wire [2:0] mf_alu_a_sel,mf_alu_b_sel,mf_d_1_sel,mf_d_2_sel,mf_dmi_sel,m_aluoutE_sel;
	 wire [1:0] wdctr;
	 wire [2:0] dmictr,dmoctr, mdctr;
	 wire pcen,Den,Eclr,br,bctr,extctr,start,busy;
	 wire [1:0] m_realdmM_sel;
	 //mf_epc_sel;
	controller controller (
    .instr(instrD), 
	 .clk(clk),
	 .rst(reset),
	 .busy(busy),
    .ra1(ra1), 
    .ra2(ra2), 
    .wa(wa), 
    .pcen(pcen), 
    .Den(Den), 
    .Eclr(Eclr), 
	 .Dclr(Dclr),
	 .bctr(bctr),
    .mf_alu_a_sel(mf_alu_a_sel), 
    .mf_alu_b_sel(mf_alu_b_sel), 
    .mf_d_1_sel(mf_d_1_sel), 
    .mf_d_2_sel(mf_d_2_sel), 
	 .mf_dmi_sel(mf_dmi_sel),
	 //.mf_epc_sel(mf_epc_sel),
	 .m_aluoutE_sel(m_aluoutE_sel),
	 .m_realdmM_sel(m_realdmM_sel),
	 .cp0we(cp0we),
	 .exlclr(exlclr),
    .br(br), 
	 .intreq(intreq),
	 .dmictr(dmictr),
	 .dmoctr(dmoctr),
    .regwrite(regwrite), 
	 .memwrite(memwrite),
    .aluctr(aluctr), 
	 .extctr(extctr),
    .wdctr(wdctr),
	 .beq(beq), 
    .bne(bne), 
    .greater(greater), 
    .less(less), 
    .greater0(greater0), 
    .less0(less0), 
    .equal0(equal0),
	 .rd20(rd20),
	 .mdctr(mdctr),
	 .start(start),
	 .lowrite(lowrite),
	 .hiwrite(hiwrite)
    );
	 
datapath datapath (
    .ra1(ra1), 
    .ra2(ra2), 
    .wa(wa), 
    .wdctr(wdctr), 
    .extctr(extctr), 
    .bctr(bctr), 
    .aluctr(aluctr), 
    .memwrite(memwrite), 
	 .dmictr(dmictr),
	 .dmoctr(dmoctr),
    .regwrite(regwrite), 
    .br(br), 
	 .pcen(pcen), 
    .Den(Den), 
	 .Dclr(Dclr),
    .Eclr(Eclr), 
    .mf_d_1_sel(mf_d_1_sel), 
    .mf_d_2_sel(mf_d_2_sel), 
    .mf_alu_a_sel(mf_alu_a_sel), 
    .mf_alu_b_sel(mf_alu_b_sel), 
    .mf_dmi_sel(mf_dmi_sel), 
	 //.mf_epc_sel(mf_epc_sel),
	 .m_aluoutE_sel(m_aluoutE_sel),
	 .m_realdmM_sel(m_realdmM_sel),
	 .cp0we(cp0we),
	 .exlclr(exlclr),
    .clk(clk), 
    .rst(reset),
	 .mdctr(mdctr),
	 .start(start),
	 .lowrite(lowrite),
	 .hiwrite(hiwrite),
	 .hwint(hwint),
    .instrD(instrD),
	 .beq(beq), 
    .bne(bne), 
    .greater(greater), 
    .less(less), 
    .greater0(greater0), 
    .less0(less0), 
    .equal0(equal0),
	 .rd20(rd20),
	 .busy(busy),
	 .memaddrM(praddr),
	 .dmi(prwd),
	 .prbe(prbe),
	 .prwe(prwe),
	 .prrd(prrd),
	 .intreq(intreq)
    );
	 
	 


endmodule
