`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:24:09 12/06/2017 
// Design Name: 
// Module Name:    controller 
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
module controller(
		input [31:0] instrD,
		input [31:0] instrE,
		input [31:0] instrM,
		input [31:0] instrW,
		input clk,
		input rst,
		input intreq,
		output [4:0] ra1,
		output [4:0] ra2,
		output [4:0] wa,
		output pcen,
		output Den,
		output Eclr,
		output Dclr,
		output[2:0] mf_alu_a_sel,
		output[2:0] mf_alu_b_sel,
		output[2:0] mf_d_1_sel,
		output[2:0] mf_d_2_sel,
		output[2:0] mf_dmi_sel,
		output[1:0] m_realdmM_sel,
		output cp0we,
		output exlclr,
		output br,
		output memwrite,
		output [1:0]dmictr,
		output [2:0]dmoctr,
		output regwrite,
		output bctr,
		output extctr,
		output [4:0] aluctr,
		output [1:0] wdctr
    );
	 
	 //main controller and its piperegs
	
	 mainctr mainctrD (
    .instr(instrD), 
    .br(br), 
    .extctr(extctr),
	 .Dclr(Dclr)
    );
	 

	 mainctrE mainctrE (
    .instrE(instrE), 
    .bctr(bctr), 
    .aluctr(aluctr)
    );
	
	 
	 
	 mainctrM mainctrM(
    .instrM(instrM), 
    .memwrite(memwrite),
	 .m_realdmM_sel(m_realdmM_sel),
	 .cp0we(cp0we),
	 .dmictr(dmictr)
    );
	
	 
	 mainctrW mainctrW (
    .instrW(instrW), 
    .regwrite(regwrite), 
	 .dmoctr(dmoctr),
	 .exlclr(exlclr),
    .wdctr(wdctr)
    );
	 
	 //A/T coder and its piperegs
	 wire [2:0] resD;
	 
	 ATcoder ATcoder (
    .instr(instrD), 
    .ra1(ra1), 
    .ra2(ra2), 
    .wa(wa), 
    .Tuse_rs0(Tuse_rs0), 
    .Tuse_rs1(Tuse_rs1), 
    .Tuse_rt0(Tuse_rt0), 
    .Tuse_rt1(Tuse_rt1), 
    //.Tuse_rt2(Tuse_rt2), 
    .res(resD)
    );
	 wire [4:0] ra1E,ra2E,waE;
	 wire [2:0] resE;
	 atcE atcE (
    .ra1i(ra1), 
    .ra2i(ra2), 
    .wai(wa), 
    .resi(resD), 
    .clk(clk), 
	 .rst(rst),
	 .Eclr(Eclr),
	 .DEMWclr(intreq),
    .ra1E(ra1E), 
    .ra2E(ra2E), 
    .waE(waE), 
    .resE(resE)
    );
	 
	 wire [4:0] ra2M, waM;
	 wire [2:0]resM;
	 atcM atcM ( 
    .ra2E(ra2E), 
    .waE(waE), 
    .resE(resE), 
    .clk(clk), 
	 .rst(rst),
	 .DEMWclr(intreq),
    .ra2M(ra2M), 
    .waM(waM), 
    .resM(resM)
    );
	 
	 wire [4:0] waW;
	 wire [2:0] resW;
	 atcW atcW (
    .waM(waM), 
    .resM(resM), 
    .clk(clk), 
	 .rst(rst),
	 .DEMWclr(intreq), 
    .waW(waW), 
    .resW(resW)
    );
	 
	 //forwarding controller
	 forwardingctr forwardingctr (
    .instr(instrD), 
    .resM(resM), 
    .resW(resW), 
	 .resE(resE),
    .ra1E(ra1E), 
    .ra2E(ra2E), 
	 .ra2M(ra2M),
	 .waE(waE),
    .waM(waM), 
    .waW(waW), 
    .mf_alu_a_sel(mf_alu_a_sel), 
    .mf_alu_b_sel(mf_alu_b_sel), 
    .mf_d_1_sel(mf_d_1_sel), 
    .mf_d_2_sel(mf_d_2_sel), 
    .mf_dmi_sel(mf_dmi_sel)
    );
	 wire stall;
	 //hazardmonitor and stall controller
	 hazardmonitor hazardmonitor (
    .instr(instrD), 
	 .instrE(instrE),
    .Tuse_rs0(Tuse_rs0), 
    .Tuse_rs1(Tuse_rs1), 
    .Tuse_rt0(Tuse_rt0), 
    .Tuse_rt1(Tuse_rt1),  
    .waE(waE), 
    .waM(waM), 
    .resE(resE), 
    .resM(resM), 
    .resW(resW), 
    .stall(stall)
    );
	 
	 stallctr stallctr (
    .stall(stall), 
    .pcen(pcen), 
    .Den(Den), 
    .Eclr(Eclr)
    );
	 
	 



endmodule
