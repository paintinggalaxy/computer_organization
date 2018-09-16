`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:11:12 11/26/2017 
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
    input [1:0] wactr,
    input [1:0] wdctr,
    input extctr,
    input bctr,
    input [2:0] aluctr,
    input memwrite,
    input regwrite,
    input [1:0] brctr,
    input clk,
    input rst,
    output [5:0] op,
    output [5:0] func
    );
	 
	 wire[31:0] instr, regdata, aluout, dmout, pcadd4, rd1,rd2, extout, realb;
	 wire[15:0] imm;
	 wire[4:0] rs, rt, rd, shamt, regaddr;
	 
	 ifu ui(
	 .clk(clk),
	 .rst(rst),
	 .br(brctr),
	 .equal(equal),
	 .less(),.greater(),
	 .ra(rd1),
	 .instr(instr),
	 .pcadd4(pcadd4)
	 );
	 
	 decoder ude(
	 .instr(instr),
	 .op(op),
	 .rs(rs),
	 .rt(rt),
	 .rd(rd),
	 .shamt(shamt),
	 .func(func),
	 .imm(imm)
	 );
	 
	 grf ug(
	 .regwrite(regwrite),
	 .ra1(rs),
	 .ra2(rt),
	 .wa(regaddr),
	 .wd(regdata),
	 .clk(clk),
	 .rst(rst),
	 .rd1(rd1),
	 .rd2(rd2)
	 );
	 
	 alu ua(
	 .A(rd1),
	 .B(realb),
	 .aluctr(aluctr),
	 .instr(instr),
	 .equal(equal),
	 .less(),.greater(),
	 .aluout(aluout)
	 );
	 
	 dm udm(
	 .memaddr(aluout),
	 .wd(rd2),
	 .clk(clk),
	 .rst(rst),
	 .memwrite(memwrite),
	 .data(dmout)
	 );
	 
	 ext ue(
	 .imm(imm),
	 .extctr(extctr),
	 .extout(extout)
	 );
	 
	 wdmux umd(
	 .wdctr(wdctr),
	 .fromalu(aluout),
	 .fromdm(dmout),
	 .fromifu(pcadd4),
	 .regdata(regdata)
	 );
	 
	 wamux uma(
	 .wactr(wactr),
	 .rd(rd),
	 .rt(rt),
	 .regaddr(regaddr)
	 );
	 
	 alubmux umb(
	 .bctr(bctr),
	 .fromrf(rd2),
	 .fromext(extout),
	 .b(realb)
	 );

endmodule
