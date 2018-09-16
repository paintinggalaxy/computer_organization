`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:05 12/25/2017 
// Design Name: 
// Module Name:    cp0 
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
`define im sr[15:10]
`define exl sr[1]
`define ie sr[0]
`define ip causeM2[15:10]
`define exccode causeM2[6:2]


module cp0(
    input [4:0] cp0addr,
    input [31:0] cp0din,
    input [31:0] pc8,
	 input [31:0] causeM2,
    input cp0we,
    input exlclr,
    input clk,
    input rst,
    output intreq,
    output [31:0] epco,
    output [31:0] cp0dout
    );
	 
	 
	 reg [31:0] epc = 0, prid = 32'h16721145,cause = 0, sr = 32'h0;
	 
	 assign intreq = (((`ip&`im)&&`ie)||(`exccode!=5'b0))&&!`exl;
	 
	 assign epco = (cp0we&&cp0addr==5'd14)?cp0din:epc;
	 
	 assign cp0dout = (cp0addr==5'd12)?sr:
							(cp0addr==5'd13)?cause:
							(cp0addr==5'd14)?epc:
							(cp0addr==5'd15)?prid:0;
	
	always@(posedge clk)begin
		if(rst)begin
			sr<= 32'h0000ff11;
			cause <= 0;
			epc<= 0;
		end
		
		else if(intreq)begin
			`exl<=1;
			cause<= causeM2;
			epc<= (causeM2[31]==1)?pc8-12:
										  pc8-8;
		end
		
		else if(cp0we)begin
			if(cp0addr==5'd12)
				sr<= cp0din;
			else if(cp0addr==5'd14)
				epc<= cp0din;
		end
		
		else if(exlclr)
			`exl<=0;
		else 
			cause[15:10]<= `ip;
	end

endmodule
