`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:30:00 12/10/2017 
// Design Name: 
// Module Name:    mainctrE 
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

module mainctrE(
    input [31:0] instrE,
	 input changeE,
	 output bctr,
	 output [3:0] aluctr
    );
	 wire[5:0] op, f;
	 wire[4:0] bits106;
	 assign op = instrE[31:26];
	 assign f = instrE[5:0];
	 assign bits106 = instrE[10:6];
	 assign bctr = `ori || `lw || `sw || `lui||`sb||`lb||`sh||`lh||`addiu;
	 assign aluctr = (`addu||`addiu)?`alu_addu:
						  (`subu)?`alu_subu:
						  (`ori||`or)?`alu_ori:
						  (`lui)?`alu_lui:
						  (`slt)?`alu_slt:
						  (`movz&&!changeE)?`alu_movz:
						  (`rotrv)?`alu_rotrv:
						  3'b0;
	 


endmodule
