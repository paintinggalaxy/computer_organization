`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:45:00 12/05/2017 
// Design Name: 
// Module Name:    head 
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

//add the head file define the instrs opcode or func code or others
`define rtype (op==6'b000000)
`define addu `rtype&f[5]&~f[4]&~f[3]&~f[2]&~f[1]&f[0]
`define subu `rtype&&f[5]&~f[4]&~f[3]&~f[2]&f[1]&f[0]
`define ori (op==6'b001101)
`define lw op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0]
`define sw op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0]
`define beq ~op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0]
`define lui ~op[5]&~op[4]&op[3]&op[2]&op[1]&op[0]
`define jal ~op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0]
`define jr `rtype&~f[5]&~f[4]&f[3]&~f[2]&~f[1]&~f[0]
`define j ~op[5]&~op[4]&~op[3]&~op[2]&op[1]&~op[0]
`define bgez ~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&op[0]&~t[4]&~t[3]&~t[2]&~t[1]&t[0]
`define bgtz ~op[5]&~op[4]&~op[3]&op[2]&op[1]&op[0]
`define blez ~op[5]&~op[4]&~op[3]&op[2]&op[1]&~op[0]
`define bltz ~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&op[0]&~t[4]&~t[3]&~t[2]&~t[1]&~t[0]
`define bne ~op[5]&~op[4]&~op[3]&op[2]&~op[1]&op[0]
`define or `rtype&f[5]&~f[4]&~f[3]&f[2]&~f[1]&f[0]
`define slt (`rtype&&(f==6'b101010))
`define sb (op==6'b101000)
`define sh (op==6'b101001)
`define lb (op==6'b100000)
`define lh (op==6'b100001)
`define addiu (op==6'b001001)
`define bgezal (op==6'b000001&&t==5'b10001)
`define movz (op==6'b000000&&f==6'b001010)
`define rotrv (op==6'b000000&&f==6'b000110&&bits106==5'b00001)

//res
`define alu 2'b01
`define dm  2'b10
`define pc 2'b11
`define nw 2'b00

//forwarding resources
`define deft  3'b000
`define Wd    3'b001
`define Malu  3'b010
`define Mpc   3'b011

//aluctr
`define alu_addu 4'b0000
`define alu_subu 4'b0001
`define alu_ori 4'b0010
`define alu_lui 4'b0011
`define alu_sll 4'b0100
`define alu_slt 4'b0101
`define alu_movz 4'b0110
`define alu_rotrv 4'b0111



