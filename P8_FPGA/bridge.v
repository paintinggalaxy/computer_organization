`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:20 12/25/2017 
// Design Name: 
// Module Name:    bridge 
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
module bridge(
	 input [31:0] praddr,
	 input [31:0] dev0rd,
	 input [31:0] dev1rd,
	 input [31:0] dev2rd,
	 input [31:0] dev3rd,
	 input [31:0] dev4rd,
	 input [31:0] dev5rd,
	 input [31:0] prwd,
	 input prwe,
	 input [3:0] prbe,
	 output [3:0] devbe,
	 output [2:0] devaddr,
	 output [31:0] devwd,
	 output [31:0] prrd,
	 output dev0we,
	 output dev1we,
	 output dev2we,
	 output dev3we,
	 output dev4we,
	 output dev5we
    );
	 
	 assign devbe = prbe;
	 assign devaddr = praddr[4:2];
	 
	 wire hitdev0, hitdev1, hitdev2, hitdev3, hitdev4, hitdev5;
	 
	 assign hitdev0 = (praddr[7:3]==5'b0||praddr[7:2]==6'b000010);
	 assign hitdev1 = (praddr[7:4]==4'b1||praddr[7:3]==5'b00100||praddr[7:2]==6'b001010);
	 assign hitdev2 = (praddr[7:2]==6'b001011||praddr[7:2]==6'b001100);
	 assign hitdev3 = (praddr[7:2]==6'b001101);
	 assign hitdev4 = (praddr[7:3]==5'b00111);
	 assign hitdev5 = (praddr[7:2]==6'b010000);
	
	 assign prrd = (hitdev0)?dev0rd:
						(hitdev1)?dev1rd:
						(hitdev2)?dev2rd:
						(hitdev3)?dev3rd:
						(hitdev4)?dev4rd:
						(hitdev5)?dev5rd:
						0;
						
	 assign dev0we = hitdev0&&prwe;
	 assign dev1we = hitdev1&&prwe;
	 assign dev2we = hitdev2&&prwe;
	 assign dev3we = hitdev3&&prwe;
	 assign dev4we = hitdev4&&prwe;
	 assign dev5we = hitdev5&&prwe;
						
	 assign devwd = prwd;
	 

endmodule
