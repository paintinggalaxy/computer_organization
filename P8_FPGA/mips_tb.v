`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:00:16 01/19/2018
// Design Name:   mips
// Module Name:   G:/CO/P8/uart2/mips_tb.v
// Project Name:  uart2
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

module mips_tb;

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
	reg uart_rxd;

	// Outputs
	wire uart_txd;
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
		.uart_rxd(uart_rxd), 
		.uart_txd(uart_txd), 
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
		dip_switch0 = 8'hff;
		dip_switch1 = 8'hff;
		dip_switch2 = 8'hff;
		dip_switch3 = 8'hff;
		dip_switch4 = 8'hff;
		dip_switch5 = 8'hff;
		dip_switch6 = 8'hff;
		dip_switch7 = 8'hff;
		user_key = 8'hff;
		uart_rxd = 0;

		// Wait 100 ns for global reset to finish
		#260  reset = 1; 
		// Add stimulus here

	end
	
	always#5 CLK_IN1 = ~CLK_IN1;
      
endmodule

