`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:14:46 01/15/2018
// Design Name:   mips
// Module Name:   G:/CO/P8/counter/counter.v
// Project Name:  counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter;

	// Inputs
	reg CLK_IN1;
	reg reset;
	reg [7:0] dip_switch0;
	reg [7:0] dip_switch1;
	reg [7:0] dip_switch2;
	reg [7:0] dip_switch3;
	reg [7:0] dip_switch4;
	reg [7:0] dip_switch5;
	reg [7:0] dip_switch6;
	reg [7:0] dip_switch7;
	reg [7:0] user_key;

	// Outputs
	wire [31:0] led_light;
	wire [3:0] digital_tube_sel0;
	wire [3:0] digital_tube_sel1;
	wire digital_tube_sel2;
	wire [7:0] digital_tube0;
	wire [7:0] digital_tube1;
	wire [7:0] digital_tube2;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.CLK_IN1(CLK_IN1), 
		.reset(reset), 
		.dip_switch0(dip_switch0), 
		.dip_switch1(dip_switch1), 
		.dip_switch2(dip_switch2), 
		.dip_switch3(dip_switch3), 
		.dip_switch4(dip_switch4), 
		.dip_switch5(dip_switch5), 
		.dip_switch6(dip_switch6), 
		.dip_switch7(dip_switch7), 
		.user_key(user_key), 
		.led_light(led_light), 
		.digital_tube_sel0(digital_tube_sel0), 
		.digital_tube_sel1(digital_tube_sel1), 
		.digital_tube_sel2(digital_tube_sel2), 
		.digital_tube0(digital_tube0), 
		.digital_tube1(digital_tube1), 
		.digital_tube2(digital_tube2)
	);

	initial begin
		// Initialize Inputs
		CLK_IN1 = 0;
		reset = 0;
		dip_switch0 = 0;
		dip_switch1 = 0;
		dip_switch2 = 0;
		dip_switch3 = 0;
		dip_switch4 = 0;
		dip_switch5 = 0;
		dip_switch6 = 0;
		dip_switch7 = 0;
		user_key = 8'hff;

		// Wait 100 ns for global reset to finish
		#270;
      reset = 1;
		#50 dip_switch0 = 7;
		

	end
	
	always#5 CLK_IN1 = ~CLK_IN1;
      
endmodule

