`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:32:53 01/09/2018 
// Design Name: 
// Module Name:    octlcd 
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
module octlcd(
	input clk,
	input rst,
	input we,
	input[2:0] addr,
	input [31:0] din,
	output [31:0] dout,
	output [7:0] digital_tube0,
	output [7:0] digital_tube1,
	output [7:0] digital_tube2,
	output [3:0] sel0,
	output [3:0] sel1,
	output sel2
    );
	
	wire[35:0] datawi;
	reg [35:0] data;
	reg [9:0] count;
	wire [9:0] countwi;
	wire [3:0] trans0;
	wire [3:0] trans1;
	wire [3:0] trans2;
	assign countwi = (count==10'b1111111111)?0:count+1;
	assign sel2 = 1'b1;
	assign sel1 = (count[9:8]==2'b00)?4'b0001:
						(count[9:8]==2'b01)?4'b0010:
						(count[9:8]==2'b10)?4'b0100:
						(count[9:8]==2'b11)?4'b1000:4'b0000;
						
	assign sel0 = sel1;		
	assign datawi = (we)?((addr==3'b110)?{data[35:32],din}:{din[3:0],data[31:0]}):data;
	assign dout = (addr==3'b110)?data[31:0]:{28'b0,data[35:32]};
	
	assign trans0 = (sel0==4'b0001)?data[3:0]:
						(sel0==4'b0010)?data[7:4]:
						(sel0==4'b0100)?data[11:8]:
						(sel0==4'b1000)?data[15:12]:4'b0;
						
	assign trans1 =(sel1==4'b0001)?data[19:16]:
						(sel1==4'b0010)?data[23:20]:
						(sel1==4'b0100)?data[27:24]:
						(sel1==4'b1000)?data[31:28]:4'b0;
						
	assign trans2 =data[35:32];
						
	assign digital_tube0 = (trans0==4'h0)?8'h81:
								 (trans0==4'h1)?8'hcf:
								 (trans0==4'h2)?8'h92:
								 (trans0==4'h3)?8'h86:
								 (trans0==4'h4)?8'hcc:
								 (trans0==4'h5)?8'ha4:
								 (trans0==4'h6)?8'ha0:
								 (trans0==4'h7)?8'h8f:
								 (trans0==4'h8)?8'h80:
								 (trans0==4'h9)?8'h84:
								 (trans0==4'ha)?8'h88:
								 (trans0==4'hb)?8'he0:
								 (trans0==4'hc)?8'hb1:
								 (trans0==4'hd)?8'hc2:
								 (trans0==4'he)?8'hb0:
								 (trans0==4'hf)?8'hb8:8'h00;
								 
		assign digital_tube1 = (trans1==4'h0)?8'h81:
								 (trans1==4'h1)?8'hcf:
								 (trans1==4'h2)?8'h92:
								 (trans1==4'h3)?8'h86:
								 (trans1==4'h4)?8'hcc:
								 (trans1==4'h5)?8'ha4:
								 (trans1==4'h6)?8'ha0:
								 (trans1==4'h7)?8'h8f:
								 (trans1==4'h8)?8'h80:
								 (trans1==4'h9)?8'h84:
								 (trans1==4'ha)?8'h88:
								 (trans1==4'hb)?8'he0:
								 (trans1==4'hc)?8'hb1:
								 (trans1==4'hd)?8'hc2:
								 (trans1==4'he)?8'hb0:
								 (trans1==4'hf)?8'hb8:8'h00;


		assign digital_tube2 = (trans2==4'h0)?8'h81:
								 (trans2==4'h1)?8'hcf:
								 (trans2==4'h2)?8'h92:
								 (trans2==4'h3)?8'h86:
								 (trans2==4'h4)?8'hcc:
								 (trans2==4'h5)?8'ha4:
								 (trans2==4'h6)?8'ha0:
								 (trans2==4'h7)?8'h8f:
								 (trans2==4'h8)?8'h80:
								 (trans2==4'h9)?8'h84:
								 (trans2==4'ha)?8'h88:
								 (trans2==4'hb)?8'he0:
								 (trans2==4'hc)?8'hb1:
								 (trans2==4'hd)?8'hc2:
								 (trans2==4'he)?8'hb0:
								 (trans2==4'hf)?8'hb8:8'h00;

	always@(posedge clk)begin
		if(!rst)begin
			data<=0;
			count<=10'b0;
		end
		else begin
			data<=datawi; 
			count<=countwi;
		end
	end

endmodule
