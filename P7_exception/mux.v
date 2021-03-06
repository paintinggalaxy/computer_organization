`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:05:54 11/25/2017 
// Design Name: 
// Module Name:    mux 
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

//function mux

`include "head.v"

module m_wd(
	input [1:0] wdctr,
	input [31:0] fromalu,
	input [31:0] fromdm,
	input [31:0] frompc8,
	output [31:0] wdW
	);
	assign wdW = (wdctr==2'b00)?fromalu:
					 (wdctr==2'b01)?fromdm:
					 (wdctr==2'b10)?frompc8:0;


endmodule

module m_alu_b(
	input bctr,
	input [31:0] fromrf,
	input [31:0] fromext,
	output [31:0] b
	);
	assign b = (bctr==0)?fromrf:fromext;
	
endmodule

//forwarding mux

module mf_alu_a(
	input [31:0] aluoutM,
	input [31:0] wdW,
	input [31:0] rd1E,
	input [31:0] pc8M,
	input [2:0] mf_alu_a_sel,
	output [31:0] alu_a
	);
	assign alu_a = (mf_alu_a_sel==`Malu)?aluoutM:
						(mf_alu_a_sel==`Wd)?wdW:
						(mf_alu_a_sel==`Mpc)?pc8M:
						rd1E;	
	
endmodule

module m_aluoutE(
	input [31:0] fromalu,
	input [31:0] fromlo,
	input [31:0] fromhi,
	input [2:0] m_aluoutE_sel,
	output [31:0] realaluout
	);
	assign realaluout = (m_aluoutE_sel==3'b000)?fromalu:
							  (m_aluoutE_sel==3'b001)?fromlo:
							  (m_aluoutE_sel==3'b010)?fromhi:
								3'b000;

endmodule

module mf_alu_b(
	input [31:0] aluoutM,
	input [31:0] wdW,
	input [31:0] rd2E,
	input [31:0] pc8M,
	input [2:0] mf_alu_b_sel,
	output [31:0] alu_b
	);
	assign alu_b = (mf_alu_b_sel==`Malu)?aluoutM:
						(mf_alu_b_sel==`Wd)?wdW:
						(mf_alu_b_sel==`Mpc)?pc8M:
						rd2E;	
	
endmodule

module mf_d_1(
	input [31:0] aluoutM,
	input [31:0] pc8E,
	input [31:0] pc8M,
	input [31:0] wdW,
	input [31:0] rd1,
	input [2:0] mf_d_1_sel,
	output [31:0] d_1
	);
	assign d_1 = (mf_d_1_sel==`Malu)?aluoutM:
						(mf_d_1_sel==`Wd)?wdW:
						(mf_d_1_sel==`Mpc)?pc8M:
						rd1;	
	
endmodule

module mf_d_2(
	input [31:0] aluoutM,
	input [31:0] pc8E,
	input [31:0] pc8M,
	input [31:0] wdW,
	input [31:0] rd2,
	input [2:0] mf_d_2_sel,
	output [31:0] d_2
	);
	assign d_2 = (mf_d_2_sel==`Malu)?aluoutM:
						(mf_d_2_sel==`Wd)?wdW:
						(mf_d_2_sel==`Mpc)?pc8M:
						rd2;	
	
endmodule

module mf_dmi(
	input [31:0] wdW,
	input [31:0] dmM,
	input [2:0] mf_dmi_sel,
	output [31:0] dmi
	);
	assign dmi = (mf_dmi_sel==`Wd)?wdW:
					 dmM;	
	
endmodule

module m_realdmM(
	input [31:0] fromdm,
	input [31:0] fromcp0,
	input [31:0] fromdev,
	input [1:0] m_realdmM_sel,
	input [31:0] memaddrM,
	output [31:0] realdmM
	);
	assign realdmM = (m_realdmM_sel==2'b00)?((memaddrM[31:13]==19'b0)||(memaddrM[31:12]==20'h00002)?fromdm:fromdev):
						  fromcp0;

endmodule

module d_enable(
	input dmnw,
	input we,
	input [31:0] d_enable_sel,
	output todm,
	output todev
	);
	
	assign todm = ((dmnw)?1'b0:we)&&((d_enable_sel[31:13]==19'b0)||(d_enable_sel[31:12]==20'h00002));
	assign todev =((dmnw)?1'b0:we)&&(d_enable_sel[31:8]==24'h00007f);
	
	
endmodule
/*
module mf_epc(
	input [1:0] mf_epc_sel,
	input [31:0] fromcp0,
	input [31:0] fromrealrd2E,
	output [31:0] realepc
	);
	assign realepc = (mf_epc_sel==2'b00)?fromcp0:fromrealrd2E;
	
endmodule
*/
/*
module mf_internal(
	input [31:0] wdW,
	input [31:0] normal,
	input mf_internal_sel,
	output [31:0] rdnew
	);
	assign rdnew = (mf_internal_sel)?wdW:normal;
	
	
endmodule
*/
