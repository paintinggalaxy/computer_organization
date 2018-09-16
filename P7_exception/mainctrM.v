`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:34:39 12/10/2017 
// Design Name: 
// Module Name:    mainctrM 
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
module mainctrM(
    input [31:0] instrM,
	 output memwrite,
	 output cp0we,
	 output [1:0] m_realdmM_sel,
	 output [2:0] dmictr
    );
	 wire[5:0] op, f;
	 wire[4:0] bits2521;
	 assign bits2521 = instrM[25:21];
	 assign op = instrM[31:26];
	 assign f = instrM[5:0];
	 
	 assign memwrite = `sw||`sb||`sh;
	 assign dmictr = (`sw)?`dm_sw:
						  (`sh)?`dm_sh:
						  (`sb)?`dm_sb:
						  3'b000;
	assign m_realdmM_sel = (`mfc0)?2'b01:2'b00;	
	
	assign cp0we = (`mtc0)?2'b01:2'b00;
	
	
	
endmodule
