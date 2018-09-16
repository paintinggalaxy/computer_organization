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
	 input CLK_IN1,
    input reset,
	 input[7:0] dip_switch0,
	 input[7:0] dip_switch1,
	 input[7:0] dip_switch2,
	 input[7:0] dip_switch3,
	 input[7:0] dip_switch4,
	 input[7:0] dip_switch5,
	 input[7:0] dip_switch6,	
	 input[7:0] dip_switch7,
	 input [7:0] user_key,
	 input uart_rxd,
	 output uart_txd,
	 output[31:0] led_light,
	 output [3:0] digital_tube_sel0,
	 output [3:0] digital_tube_sel1,
	 output digital_tube_sel2,
	 output [7:0] digital_tube0,
	 output [7:0] digital_tube1,
	 output [7:0] digital_tube2
    );
	clock clock
   (// Clock in ports
    .CLK_IN1(CLK_IN1),      // IN
    // Clock out ports
    .CLK_OUT1(clk),     // OUT
    .CLK_OUT2(clk2));    // OUT
	 reg /*hwint3 = 0,  hwint4 = 0,*/ hwint5 = 0, hwint6 = 0;
	wire [31:0] prrd, prwd, praddr;
	wire [3:0] prbe;
	cpu cpu (
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
	 
	 wire [31:0] dev0rd, dev1rd, dev2rd, dev3rd, dev4rd, dev5rd, devwd;
	 wire [2:0] devaddr;
	 //wire [3:0] devbe;
bridge bridge (
    .praddr(praddr), 
    .dev0rd(dev0rd), 
    .dev1rd(dev1rd), 
    .dev2rd(dev2rd), 
    .dev3rd(dev3rd), 
    .dev4rd(dev4rd), 
    .dev5rd(dev5rd), 
    .prwd(prwd), 
    .prwe(prwe), 
    .prbe(prbe), 
    //.devbe(devbe), 
    .devaddr(devaddr), 
    .devwd(devwd), 
    .prrd(prrd), 
    .dev0we(dev0we), 
    .dev1we(dev1we), 
    .dev2we(dev2we), 
    .dev3we(dev3we), 
    .dev4we(dev4we), 
    .dev5we(dev5we)
    );
	 
	 //device 0
	 timer timer0 (
    .clk(clk), 
    .rst(reset), 
    .addr(devaddr), 
    .we(dev0we), 
    .din(devwd), 
    .dout(dev0rd), 
    .irq(hwint2)
    );
	 
	 	//device 1
	 MiniUART UART (
    .ADD_I(devaddr), 
    .DAT_I(devwd), 
    .DAT_O(dev1rd), 
    .STB_I(dev1we), 
    .WE_I(dev1we), 
    .CLK_I(clk), 
    .RST_I(reset), 
    //.ACK_O(ACK_O), 
    .RxD(uart_rxd), 
    .TxD(uart_txd),
	 .irq(hwint3)
    );
	 
	 //device2 switch64
	 
	 switch64 switch64 (
	 .clk(clk),
    .dip_switch0(dip_switch0), 
    .dip_switch1(dip_switch1), 
    .dip_switch2(dip_switch2), 
    .dip_switch3(dip_switch3), 
    .dip_switch4(dip_switch4), 
    .dip_switch5(dip_switch5), 
    .dip_switch6(dip_switch6), 
    .dip_switch7(dip_switch7), 
    .addr(devaddr), 
    .dout(dev2rd),
	 .irq(hwint4)
    );
	 
	 //device 3
	 led32 led32 (
    .clk(clk), 
    .rst(reset), 
	 .we(dev3we), 
    .din(devwd), 
    .dout(dev3rd), 
    .led_light(led_light)
    );
	 
	 //digital_tube
	 //device 4
	 octlcd octlcd (
    .clk(clk), 
    .rst(reset), 
    .we(dev4we), 
    .addr(devaddr), 
    .din(devwd), 
    .dout(dev4rd), 
    .digital_tube0(digital_tube0), 
    .digital_tube1(digital_tube1), 
    .digital_tube2(digital_tube2), 
    .sel0(digital_tube_sel0), 
    .sel1(digital_tube_sel1), 
    .sel2(digital_tube_sel2)
    );
	 
	 //device5 userkey
	 
	 userkey userkey (
    .user_key(user_key), 
    .dout(dev5rd), 
	 .clk(clk),
	 .rst(reset),
    .irq(hwint7)
    );

	

endmodule
