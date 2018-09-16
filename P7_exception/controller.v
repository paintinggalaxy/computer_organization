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
		input [31:0] instr,
		input beq,
		input bne,
		input greater,
		input less,
		input greater0,
		input less0,
		input equal0,
		input rd20,
		input clk,
		input rst,
		input busy,
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
		//output [1:0] mf_epc_sel,
		output[2:0] m_aluoutE_sel,
		output[1:0] m_realdmM_sel,
		output cp0we,
		output exlclr,
		output br,
		output memwrite,
		output [2:0]dmictr,
		output [2:0]dmoctr,
		output regwrite,
		output bctr,
		output extctr,
		output [4:0] aluctr,
		output [1:0] wdctr,
		output [2:0] mdctr,
		output start,
		output lowrite,
		output hiwrite
    );
	 
	 //main controller and its piperegs

	 wire [31:0] instrE, instrM, instrW;
	
	 mainctr mainctrD (
    .instr(instr), 
	 .beq(beq), 
    .bne(bne), 
    .greater(greater), 
    .less(less), 
    .greater0(greater0), 
    .less0(less0), 
    .equal0(equal0),
	 .rd20(rd20),
    .br(br), 
    .extctr(extctr),
	 //.change(change),
	 .Dclr(Dclr)
    );
	 


	 mcE mcE(
    .instrD(instr), 
	 //.changeD(change),
    .clk(clk), 
    .rst(rst), 
	 .Eclr(Eclr),
	 .DEMWclr(intreq),
    .instrE(instrE)
	 //.changeE(changeE)
    );
	 
	 mainctrE mainctrE (
    .instrE(instrE), 
	 //.changeE(changeE),
    .bctr(bctr), 
    .aluctr(aluctr),
	 .mdctr(mdctr),
	 .start(start),
	 .m_aluoutE_sel(m_aluoutE_sel),
	 .lowrite(lowrite),
	 .hiwrite(hiwrite)
    );

	 mcM mcM (
    .instrE(instrE), 
	 //.changeE(changeE),
    .clk(clk), 
    .rst(rst), 
	 .DEMWclr(intreq),
    .instrM(instrM)
	 //.changeM(changeM)
    );
	 
	 mainctrM mainctrM(
    .instrM(instrM), 
    .memwrite(memwrite),
	 .m_realdmM_sel(m_realdmM_sel),
	 .cp0we(cp0we),
	 .dmictr(dmictr)
    );
	
	 mcW mcW (
    .instrM(instrM), 
	 //.changeM(changeM),
    .clk(clk), 
    .rst(rst), 
	 .DEMWclr(intreq),
    .instrW(instrW)
	 //.changeW(changeW)
    );
	 
	 mainctrW mainctrW (
    .instrW(instrW), 
	 //.changeW(changeW),
    .regwrite(regwrite), 
	 .dmoctr(dmoctr),
	 .exlclr(exlclr),
    .wdctr(wdctr)
    );
	 
	 //A/T coder and its piperegs
	 wire [2:0] resD;
	 wire Tuse_rs0, Tuse_rs1,Tuse_rt0,Tuse_rt1,Tuse_rt2;
	 ATcoder ATcoder (
    .instr(instr), 
	 //.change(change),
    .ra1(ra1), 
    .ra2(ra2), 
    .wa(wa), 
    .Tuse_rs0(Tuse_rs0), 
    .Tuse_rs1(Tuse_rs1), 
    .Tuse_rt0(Tuse_rt0), 
    .Tuse_rt1(Tuse_rt1), 
    .Tuse_rt2(Tuse_rt2), 
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
	 
	 wire [4:0] ra1M, ra2M, waM;
	 wire [2:0]resM;
	 atcM atcM (
    .ra1E(ra1E), 
    .ra2E(ra2E), 
    .waE(waE), 
    .resE(resE), 
    .clk(clk), 
	 .rst(rst),
	 .DEMWclr(intreq),
    .ra1M(ra1M), 
    .ra2M(ra2M), 
    .waM(waM), 
    .resM(resM)
    );
	 
	 wire [4:0] ra1W, ra2W, waW;
	 wire [2:0] resW;
	 atcW atcW (
    .ra1M(ra1M), 
    .ra2M(ra2M), 
    .waM(waM), 
    .resM(resM), 
    .clk(clk), 
	 .rst(rst),
	 .DEMWclr(intreq),
    .ra1W(ra1W), 
    .ra2W(ra2W), 
    .waW(waW), 
    .resW(resW)
    );
	 
	 //forwarding controller
	 forwardingctr forwardingctr (
    .instr(instr), 
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
	 //.mf_epc_sel(mf_epc_sel)
    );
	 wire stall;
	 //hazardmonitor and stall controller
	 hazardmonitor hazardmonitor (
    .instr(instr), 
	 .instrE(instrE),
    .Tuse_rs0(Tuse_rs0), 
    .Tuse_rs1(Tuse_rs1), 
    .Tuse_rt0(Tuse_rt0), 
    .Tuse_rt1(Tuse_rt1), 
    .Tuse_rt2(Tuse_rt2), 
    .waE(waE), 
    .waM(waM), 
    .resE(resE), 
    .resM(resM), 
    .resW(resW), 
	 .busy(busy),
	 .start(start),
    .stall(stall)
    );
	 
	 stallctr stallctr (
    .stall(stall), 
    .pcen(pcen), 
    .Den(Den), 
    .Eclr(Eclr)
    );
	 
	 



endmodule
