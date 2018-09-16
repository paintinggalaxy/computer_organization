`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:38:57 01/19/2018
// Design Name:   cpu
// Module Name:   G:/CO/P8/uart2/cpu_tb.v
// Project Name:  uart2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_tb;

	// Inputs
	reg clk;
	reg clk2;
	reg reset;
	reg hwint2;
	reg hwint3;
	reg hwint4;
	reg hwint5;
	reg hwint6;
	reg hwint7;
	reg [31:0] prrd;

	// Outputs
	wire [3:0] prbe;
	wire [31:0] praddr;
	wire [31:0] prwd;
	wire prwe;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.clk(clk), 
		.clk2(clk2), 
		.reset(reset), 
		.hwint2(hwint2), 
		.hwint3(hwint3), 
		.hwint4(hwint4), 
		.hwint5(hwint5), 
		.hwint6(hwint6), 
		.hwint7(hwint7), 
		.prrd(prrd), 
		.prbe(prbe), 
		.praddr(praddr), 
		.prwd(prwd), 
		.prwe(prwe)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clk2 = 0;
		reset = 0;
		hwint2 = 0;
		hwint3 = 0;
		hwint4 = 0;
		hwint5 = 0;
		hwint6 = 0;
		hwint7 = 0;
		prrd = 0;

		
		#50;
      reset = 1;
		// Add stimulus here
		prrd = 32'h00001234;
		#100 hwint3 = 1;
		
	end
	
	always #10 clk = ~clk;
	always #5 clk2 = ~clk2;
      
endmodule

