`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:09 12/05/2017 
// Design Name: 
// Module Name:    forwardingctr 
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
`define ra1D instr[25:21]
`define ra2D instr[20:16]



module forwardingctr(
	 input [31:0] instr,
    input [2:0] resM,
    input [2:0] resW,
	 input [2:0] resE,
	 input [4:0] ra1E, 
	 input [4:0] ra2E,
	 input [4:0] ra2M,
	 input [4:0] waM,
	 input [4:0] waW,
	 input [4:0] waE,
    output [2:0] mf_alu_a_sel,
    output [2:0] mf_alu_b_sel,
    output [2:0] mf_d_1_sel,
    output [2:0] mf_d_2_sel,
	 output [2:0] mf_dmi_sel
	 //output [1:0] mf_epc_sel
    );
	 /*
	 wire [5:0] op, f;
	 assign op = instr[31:26];
	 assign f = instr[5:0];
	 */
	 
	 assign mf_alu_a_sel = (ra1E==waM&&waM!=5'b0)&&(resM==`alu)?`Malu:
								  (ra1E==waM&&waM!=5'b0)&&(resM==`pc)?`Mpc:
								  (ra1E==waW&&waW!=5'b0)&&(resW==`alu||resW==`dm||resW==`pc)?`Wd:
								  `deft;
								  
	 assign mf_alu_b_sel = (ra2E==waM&&waM!=5'b0)&&(resM==`alu)?`Malu:
								  (ra2E==waM&&waM!=5'b0)&&(resM==`pc)?`Mpc:
								  (ra2E==waW&&waW!=5'b0)&&(resW==`alu||resW==`dm||resW==`pc)?`Wd:
								  `deft;
								  
	 assign mf_d_1_sel = (`ra1D==waM&&waM!=5'b0)&&(resM==`alu)?`Malu:
								(`ra1D==waM&&waM!=5'b0)&&(resM==`pc)?`Mpc:
								(`ra1D==waW&&waW!=5'b0)&&(resW==`alu||resW==`dm||resW==`pc)?`Wd:
								`deft;
								
	 assign mf_d_2_sel = (`ra2D==waM&&waM!=5'b0)&&(resM==`alu)?`Malu:
								(`ra2D==waM&&waM!=5'b0)&&(resM==`pc)?`Mpc:
								(`ra2D==waW&&waW!=5'b0)&&(resW==`alu||resW==`dm||resW==`pc)?`Wd:
								`deft;
								
	 assign mf_dmi_sel = (ra2M==waW&&waW!=5'b0)&&(resW==`alu||resW==`dm||resW==`pc)?`Wd:
								`deft;
						

	//assign mf_epc_sel = (`eret&&(instrE[31:26]==6'b010000&&instrE[25:21]==5'b00100)&&(instrE[15:11]==5'd14))?2'b01:2'b00;

endmodule
