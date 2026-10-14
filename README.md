# ALU-Verification-Testbench

A testbench for a RISCV-32 bit ALU

Spec:

Its all combinational logic i.e. should result in one cycle

ALUSel - Width = 4
A = 32
B = 32
ALU Out = 32

Interface:
Inputs:

Value A - could be register or PC Value i.e 32 bits to compute
Value B - could be register or Immediate i.e 32 bits to compute
Value ALU Sel - selects the operation the ALU has to peform
Output:

ALU_Out - Computes A and B and gives you the value after computation
0 - ALUSel is a not-used value, i.e 3, 10, 14
ignore i.e it'll wrap i.e 0xFFFFFFFF + 0x00000002 = 0x00000001- overflow computed by ALU both add and sub, no flag bit

Operations:

Logical shifts - zero-filled-extended
Arithmetic shifts - sign-extended

ALUSel Value

(for Project) Operation ALU Function
0 add ALUResult = A + B
1 sll ALUResult = A << B[4:0]
2 slt ALUResult = (A < B (signed)) ? 1 : 0
3 Unused -
4 xor ALUResult = A ^ B
5 srl ALUResult = (unsigned) A >> B[4:0]
6 or ALUResult = A | B
7 and ALUResult = A & B
8 mul ALUResult = (signed) (A _ B)[31:0]
9 mulh ALUResult = (signed) (A _ B)[63:32]
10 Unused -
11 mulhu ALUResult = (A \* B)[63:32] (unsigned)
12 sub ALUResult = A - B
13 sra ALUResult = (signed) A >> B[4:0]
14 Unused -
15 bsel ALUResult = B - A is ignored
