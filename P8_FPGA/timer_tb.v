`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:03:43 12/30/2017
// Design Name:   counter
// Module Name:   G:/CO/P7/microsys/timer_tb.v
// Project Name:  microsys
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module timer_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [1:0] addr;
	reg we;
	reg [31:0] din;

	// Outputs
	wire [31:0] dout;
	wire irq;

	// Instantiate the Unit Under Test (UUT)
	timer uut (
		.clk(clk), 
		.rst(rst), 
		.addr(addr), 
		.we(we), 
		.din(din), 
		.dout(dout), 
		.irq(irq)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		addr = 0;
		we = 0;
		din = 0;

		// Wait 100 ns for global reset to finish
		#2;
		we = 1'b1;
		addr = 2'b01;
		din = 15;
		
        
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
      
endmodule

