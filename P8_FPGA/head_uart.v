//`define LINE_H      1'b1
//`define LINE_L      1'b0
//`define LINE_IDLE   1'b1
//`define LINE_START  1'b0

`define OFF_UART_DATA       3'b100   //0x7f10
`define OFF_UART_IER        3'b101   //0x7f14
`define OFF_UART_IIR        3'b110  //0x7f18
//`define OFF_UART_LCR        3'b
`define OFF_UART_LSR        3'b111  //0x7f1c
`define OFF_UART_DIVR       3'b000   //0x7f20
`define OFF_UART_DIVT       3'b001   //0x7f24

/* For simulation only, the frequency of system clock is set at 100KHz.
   You must understand its frequency is too low so that only 9600 BAUD
   could be supported!!!*/
`define CLK_FRQ            30000000       // 100KHz : system clock
`define CYCLE               (1000000000/`CLK_FRQ)

`define     SAMPLE_FREQUENCE        8
`define     HALF_BIT                (`SAMPLE_FREQUENCE/2-1)

// define receive-baud rate divisor
`define BAUD_RCV_9600       (`CLK_FRQ/(9600*`SAMPLE_FREQUENCE)-1)
`define BAUD_RCV_19200      (`CLK_FRQ/(19200*`SAMPLE_FREQUENCE)-1)
`define BAUD_RCV_38400      (`CLK_FRQ/(38400*`SAMPLE_FREQUENCE)-1)
`define BAUD_RCV_57600      (`CLK_FRQ/(57600*`SAMPLE_FREQUENCE)-1)
`define BAUD_RCV_115200     (`CLK_FRQ/(115200*`SAMPLE_FREQUENCE)-1)
// define send-baud rate divisor
`define BAUD_SND_9600       (`CLK_FRQ/9600-1)
`define BAUD_SND_19200      (`CLK_FRQ/19200-1)
`define BAUD_SND_38400      (`CLK_FRQ/38400-1)
`define BAUD_SND_57600      (`CLK_FRQ/57600-1)
`define BAUD_SND_115200     (`CLK_FRQ/115200-1)

`timescale  1ns/1ns