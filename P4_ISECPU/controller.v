`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:25:08 11/25/2017 
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
`define rtype ~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0]
`define addu `rtype&f[5]&~f[4]&~f[3]&~f[2]&~f[1]&f[0]
`define subu `rtype&&f[5]&~f[4]&~f[3]&~f[2]&f[1]&f[0]
`define ori ~op[5]&~op[4]&op[3]&op[2]&~op[1]&op[0]
`define lw op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0]
`define sw op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0]
`define beq ~op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0]
`define lui ~op[5]&~op[4]&op[3]&op[2]&op[1]&op[0]
`define jal ~op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0]
`define jr `rtype&~f[5]&~f[4]&f[3]&~f[2]&~f[1]&~f[0]
`define j ~op[5]&~op[4]&~op[3]&~op[2]&op[1]&~op[0]
`define sll `rtype&~f[5]&~f[4]&~f[3]&~f[2]&~f[1]&~f[0]
`define addiu ~op[5]&~op[4]&op[3]&~op[2]&~op[1]&op[0]

module controller(
    input [5:0] op,
    input [5:0] f,
    output [1:0] wactr,
    output [1:0] wdctr,
    output extctr,
    output bctr,
    output [2:0] aluctr,
    output memwrite,
    output regwrite,
    output [1:0] brctr
    );
	 assign wactr[1] = `jal;
	 assign wactr[0] = `lw || `ori || `lui || `addiu;
	 assign wdctr[1] = `jal;
	 assign wdctr[0] = `lw;
	 assign extctr = `lw || `sw || `addiu;
	 assign bctr = `ori || `lw || `sw || `lui ||`addiu;
	 assign aluctr[2] = `sll;
	 assign aluctr[1] = `ori || `lui;
	 assign aluctr[0] = `subu || `lui;
	 assign memwrite = `sw;
	 assign regwrite = `addu || `subu || `ori || `lw || `lui || `jal || `sll || `addiu;
	 assign brctr[1] = `jal || `jr || `j;
	 assign brctr[0] = `beq || `jr;

endmodule
