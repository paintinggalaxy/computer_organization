`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:40:17 12/18/2017
// Design Name:   multdiv
// Module Name:   G:/CO/P6/pipeline50/md_tb.v
// Project Name:  pipeline50
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: multdiv
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module md_tb;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [2:0] mdctr;
	reg rst;
	reg clk;
	reg start;
	reg lowrite;
	reg hiwrite;

	// Outputs
	wire busy;
	wire [31:0] hio;
	wire [31:0] loo;

	// Instantiate the Unit Under Test (UUT)
	multdiv uut (
		.A(A), 
		.B(B), 
		.mdctr(mdctr), 
		.rst(rst), 
		.clk(clk), 
		.start(start), 
		.lowrite(lowrite), 
		.hiwrite(hiwrite), 
		.busy(busy), 
		.hio(hio), 
		.loo(loo)
	);

	initial begin
		// Initialize Inputs
		A = -5;
		B = 2;
		mdctr = 0;
		rst = 0;
		clk = 0;
		start = 1;
		lowrite = 0;
		hiwrite = 0;
		#10 start = 0;
		
		#100;
		start = 1;
		A = -5;
		B = 2;
		mdctr = 1;
		#10 start = 0;
		
		#105;
		start = 1;
		A = -5;
		B = -2;
		mdctr = 0;
		
		#10 start = 0;
		
		#100;
		start = 1;
		A = -5;
		B = -2;
		mdctr = 1;
		
		#10 start = 0;
		
		#100;
		start = 1;
		A = 5;
		B = 2;
		mdctr = 0;
		
		#10;
		start = 0;
		
	end
   always #5 clk = ~clk;
endmodule

