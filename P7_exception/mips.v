`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:08:24 12/30/2017 
// Design Name: 
// Module Name:    system 
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
module mips(
    input clk,
    input reset
    );
	 reg hwint4 = 0, hwint5 = 0, hwint6 = 0, hwint7 = 0;
	wire [31:0] prrd, prwd, praddr;
	wire [3:0] prbe;
	cpu cpu (
    .clk(clk), 
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
	 
	 wire [31:0] dev0rd, dev1rd, devwd;
	 wire [1:0] devaddr;
	 wire [3:0] devbe;
	 bridge bridge (
    .praddr(praddr), 
    .dev0rd(dev0rd), 
    .dev1rd(dev1rd), 
    .prwd(prwd), 
    .prwe(prwe), 
	 .prbe(prbe),
	 .devbe(devbe),
    .devaddr(devaddr), 
    .devwd(devwd), 
    .prrd(prrd), 
    .dev0we(dev0we), 
    .dev1we(dev1we)
    );
	 
	 counter timer0 (
    .clk(clk), 
    .rst(reset), 
    .addr(devaddr), 
    .we(dev0we), 
    .din(devwd), 
    .dout(dev0rd), 
    .irq(hwint2)
    );
	 
	 counter timer1 (
    .clk(clk), 
    .rst(reset), 
    .addr(devaddr), 
    .we(dev1we), 
    .din(devwd), 
    .dout(dev1rd), 
    .irq(hwint3)
    );
	

endmodule
