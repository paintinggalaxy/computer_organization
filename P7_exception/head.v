`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Shi Dingyuan
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

`define add (`rtype&&f==6'b100000)
`define sub (`rtype&&f==6'b100010)

`define sll (`rtype&&f==6'b000000)
`define srl (`rtype&&f==6'b000010)
`define sra (`rtype&&f==6'b000011)
`define sllv (`rtype&&f==6'b000100)
`define srlv (`rtype&&f==6'b000110)
`define srav (`rtype&&f==6'b000111)

`define and (`rtype&&f==6'b100100)
`define or  (`rtype&&f==6'b100101)
`define xor (`rtype&&f==6'b100110)
`define nor (`rtype&&f==6'b100111)
`define ori (op==6'b001101)
`define andi (op==6'b001100)
`define xori (op==6'b001110)


`define addu `rtype&f[5]&~f[4]&~f[3]&~f[2]&~f[1]&f[0]
`define subu `rtype&&f[5]&~f[4]&~f[3]&~f[2]&f[1]&f[0]
`define addiu (op==6'b001001)
`define addi (op==6'b001000)
`define lui ~op[5]&~op[4]&op[3]&op[2]&op[1]&op[0]

`define slt (`rtype&&f==6'b101010)
`define slti (op==6'b001010)
`define sltiu (op==6'b001011)
`define sltu (`rtype&&f==6'b101011)

`define lw (op==6'b100011)
`define sw (op==6'b101011)
`define sb (op==6'b101000)
`define sh (op==6'b101001)
`define lb (op==6'b100000)
`define lbu (op==6'b100100)
`define lh (op==6'b100001)
`define lhu (op==6'b100101)


`define jal ~op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0]
`define jr `rtype&~f[5]&~f[4]&f[3]&~f[2]&~f[1]&~f[0]
`define j ~op[5]&~op[4]&~op[3]&~op[2]&op[1]&~op[0]
`define jalr (`rtype&&f==6'b001001)

`define beq ~op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0]
`define bgez ~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&op[0]&~t[4]&~t[3]&~t[2]&~t[1]&t[0]
`define bgtz ~op[5]&~op[4]&~op[3]&op[2]&op[1]&op[0]
`define blez ~op[5]&~op[4]&~op[3]&op[2]&op[1]&~op[0]
`define bltz ~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&op[0]&~t[4]&~t[3]&~t[2]&~t[1]&~t[0]
`define bne ~op[5]&~op[4]&~op[3]&op[2]&~op[1]&op[0]

/*
`define bgezall (op==6'b000001&&t==5'b10011)
`define bgezal (op==6'b000001&&t==5'b10001)
`define movz (op==6'b000000&&f==6'b001010)
`define rotrv (op==6'b000000&&f==6'b000110&&bits106==5'b00001)
*/

`define mult (`rtype&&f==6'b011000)
`define multu (`rtype&&f==6'b011001)
`define div (`rtype&&f==6'b011010)
`define divu (`rtype&&f==6'b011011)

`define mfhi (`rtype&&f==6'b010000)
`define mflo (`rtype&&f==6'b010010)

`define mtlo (`rtype&&f==6'b010011)
`define mthi (`rtype&&f==6'b010001)

`define mfc0 (op==6'b010000&&bits2521==5'b0)
`define mtc0 (op==6'b010000&&bits2521==5'b00100)

`define eret (op==6'b010000&&f==6'b011000)
//res
`define alu 3'b001
`define dm  3'b010
`define pc 3'b011
`define cp0 3'b100
`define nw 3'b000

//forwarding resources
`define deft  3'b000
`define Wd    3'b001
`define Malu  3'b010
`define Mpc   3'b011

//dmictr
`define dm_lw 3'b000
`define dm_lh 3'b001
`define dm_lbu 3'b010
`define dm_lb 3'b011
`define dm_lhu 3'b100

//dmoctr
`define dm_sw 3'b000
`define dm_sh 3'b001
`define dm_sb 3'b011

//aluctr
`define alu_addu 5'b00000
`define alu_subu 5'b00001
`define alu_ori 5'b00010
`define alu_lui 5'b00011
`define alu_sll 5'b00100
`define alu_slt 5'b00101
`define alu_movz 5'b00110
`define alu_rotrv 5'b00111
`define alu_srl 5'b01000
`define alu_sra 5'b01001
`define alu_sllv 5'b01010
`define alu_srlv 5'b01011
`define alu_srav 5'b01100
`define alu_and 5'b01101
`define alu_xor 5'b01110
`define alu_nor 5'b01111
`define alu_sltu 5'b10000
`define alu_add 5'b10001
`define alu_sub 5'b10010
//mdctr

`define md_mult 3'b000
`define md_multu 3'b001
`define md_div 3'b010
`define md_divu 3'b011

//dm
`define b3  mem[memaddr[13:2]][31:24]
`define b2  mem[memaddr[13:2]][23:16]
`define b1  mem[memaddr[13:2]][15:8]
`define b0  mem[memaddr[13:2]][7:0]
`define h1  mem[memaddr[13:2]][31:16]
`define h0  mem[memaddr[13:2]][15:0]
`define signb3 mem[memaddr[13:2]][31]
`define signb2 mem[memaddr[13:2]][23]
`define signb1 mem[memaddr[13:2]][15]
`define signb0 mem[memaddr[13:2]][7]
