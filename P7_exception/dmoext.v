`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:34 12/19/2017 
// Design Name: 
// Module Name:    dmoext 
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
module dmoext(
    input [31:0] dmW,
	 input [31:0] memaddr,
    input [2:0] dmoctr,
    output [31:0] realdm
    );
	 assign realdm = (dmoctr==`dm_lw)?dmW:  //lw
						  (dmoctr==`dm_lh)?(memaddr[1]?{{16{dmW[31]}},dmW[31:16]}:{{16{dmW[15]}},dmW[15:0]}): //lh
						  (dmoctr==`dm_lb)?(memaddr[1]?(memaddr[0]?{{24{dmW[31]}},dmW[31:24]}:{{24{dmW[23]}},dmW[23:16]}):(memaddr[0]?{{24{dmW[15]}},dmW[15:8]}:{{24{dmW[7]}},dmW[7:0]})):  //lb
						  (dmoctr==`dm_lbu)?(memaddr[1]?(memaddr[0]?{24'b0,dmW[31:24]}:{24'b0,dmW[23:16]}):(memaddr[0]?{24'b0,dmW[15:8]}:{24'b0,dmW[7:0]})):
					     (dmoctr==`dm_lhu)?(memaddr[1]?{16'b0,dmW[31:16]}:{16'b0,dmW[15:0]}):32'b0;


endmodule
