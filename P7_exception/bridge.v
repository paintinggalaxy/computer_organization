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
	 input [31:0] prwd,
	 input prwe,
	 input [3:0] prbe,
	 output [3:0] devbe,
	 output [1:0] devaddr,
	 output [31:0] devwd,
	 output [31:0] prrd,
	 output dev0we,
	 output dev1we
    );
	 
	 assign devbe = prbe;
	 assign devaddr = praddr[3:2];
	 
	 wire hitdev0, hitdev1;
	 
	 assign hitdev0 = (praddr[31:4]==32'h00007f0);
	 assign hitdev1 = (praddr[31:4]==32'h00007f1);
	
	 assign prrd = (hitdev0)?dev0rd:
						(hitdev1)?dev1rd:
						0;
						
	 assign dev0we = hitdev0&&prwe;
	 assign dev1we = hitdev1&&prwe;
						
	 assign devwd = prwd;
	 

endmodule
