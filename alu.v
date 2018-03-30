`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2010
// Design Name:
// Module Name:    alu
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

module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
			  bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

wire A_invert, B_invert, Cin;
wire [2-1:0] operation;
wire [30:0] Cout;
wire [30:0] tmp;
wire w_zero, w_overflow, w_cout;
wire [32-1:0] w_result, equal_out;
wire set;

alu_top alu_top0(src1[0], src2[0], set, A_invert, B_invert, Cin, operation, w_result[0], Cout[0], 1'b0, equal_out[0]);
alu_top alu_top1(src1[1], src2[1], 1'b0, A_invert, B_invert, Cout[0], operation, w_result[1], Cout[1], equal_out[0], equal_out[1]);
alu_top alu_top2(src1[2], src2[2], 1'b0, A_invert, B_invert, Cout[1], operation, w_result[2], Cout[2], equal_out[1], equal_out[2]);
alu_top alu_top3(src1[3], src2[3], 1'b0, A_invert, B_invert, Cout[2], operation, w_result[3], Cout[3], equal_out[2], equal_out[3]);
alu_top alu_top4(src1[4], src2[4], 1'b0, A_invert, B_invert, Cout[3], operation, w_result[4], Cout[4], equal_out[3], equal_out[4]);
alu_top alu_top5(src1[5], src2[5], 1'b0, A_invert, B_invert, Cout[4], operation, w_result[5], Cout[5], equal_out[4], equal_out[5]);
alu_top alu_top6(src1[6], src2[6], 1'b0, A_invert, B_invert, Cout[5], operation, w_result[6], Cout[6], equal_out[5], equal_out[6]);
alu_top alu_top7(src1[7], src2[7], 1'b0, A_invert, B_invert, Cout[6], operation, w_result[7], Cout[7], equal_out[6], equal_out[7]);
alu_top alu_top8(src1[8], src2[8], 1'b0, A_invert, B_invert, Cout[7], operation, w_result[8], Cout[8], equal_out[7], equal_out[8]);
alu_top alu_top9(src1[9], src2[9], 1'b0, A_invert, B_invert, Cout[8], operation, w_result[9], Cout[9], equal_out[8], equal_out[9]);
alu_top alu_top10(src1[10], src2[10], 1'b0, A_invert, B_invert, Cout[9], operation, w_result[10], Cout[10], equal_out[9], equal_out[10]);
alu_top alu_top11(src1[11], src2[11], 1'b0, A_invert, B_invert, Cout[10], operation, w_result[11], Cout[11], equal_out[10], equal_out[11]);
alu_top alu_top12(src1[12], src2[12], 1'b0, A_invert, B_invert, Cout[11], operation, w_result[12], Cout[12], equal_out[11], equal_out[12]);
alu_top alu_top13(src1[13], src2[13], 1'b0, A_invert, B_invert, Cout[12], operation, w_result[13], Cout[13], equal_out[12], equal_out[13]);
alu_top alu_top14(src1[14], src2[14], 1'b0, A_invert, B_invert, Cout[13], operation, w_result[14], Cout[14], equal_out[13], equal_out[14]);
alu_top alu_top15(src1[15], src2[15], 1'b0, A_invert, B_invert, Cout[14], operation, w_result[15], Cout[15], equal_out[14], equal_out[15]);
alu_top alu_top16(src1[16], src2[16], 1'b0, A_invert, B_invert, Cout[15], operation, w_result[16], Cout[16], equal_out[15], equal_out[16]);
alu_top alu_top17(src1[17], src2[17], 1'b0, A_invert, B_invert, Cout[16], operation, w_result[17], Cout[17], equal_out[16], equal_out[17]);
alu_top alu_top18(src1[18], src2[18], 1'b0, A_invert, B_invert, Cout[17], operation, w_result[18], Cout[18], equal_out[17], equal_out[18]);
alu_top alu_top19(src1[19], src2[19], 1'b0, A_invert, B_invert, Cout[18], operation, w_result[19], Cout[19], equal_out[18], equal_out[19]);
alu_top alu_top20(src1[20], src2[20], 1'b0, A_invert, B_invert, Cout[19], operation, w_result[20], Cout[20], equal_out[19], equal_out[20]);
alu_top alu_top21(src1[21], src2[21], 1'b0, A_invert, B_invert, Cout[20], operation, w_result[21], Cout[21], equal_out[20], equal_out[21]);
alu_top alu_top22(src1[22], src2[22], 1'b0, A_invert, B_invert, Cout[21], operation, w_result[22], Cout[22], equal_out[21], equal_out[22]);
alu_top alu_top23(src1[23], src2[23], 1'b0, A_invert, B_invert, Cout[22], operation, w_result[23], Cout[23], equal_out[22], equal_out[23]);
alu_top alu_top24(src1[24], src2[24], 1'b0, A_invert, B_invert, Cout[23], operation, w_result[24], Cout[24], equal_out[23], equal_out[24]);
alu_top alu_top25(src1[25], src2[25], 1'b0, A_invert, B_invert, Cout[24], operation, w_result[25], Cout[25], equal_out[24], equal_out[25]);
alu_top alu_top26(src1[26], src2[26], 1'b0, A_invert, B_invert, Cout[25], operation, w_result[26], Cout[26], equal_out[25], equal_out[26]);
alu_top alu_top27(src1[27], src2[27], 1'b0, A_invert, B_invert, Cout[26], operation, w_result[27], Cout[27], equal_out[26], equal_out[27]);
alu_top alu_top28(src1[28], src2[28], 1'b0, A_invert, B_invert, Cout[27], operation, w_result[28], Cout[28], equal_out[27], equal_out[28]);
alu_top alu_top29(src1[29], src2[29], 1'b0, A_invert, B_invert, Cout[28], operation, w_result[29], Cout[29], equal_out[28], equal_out[29]);
alu_top alu_top30(src1[30], src2[30], 1'b0, A_invert, B_invert, Cout[29], operation, w_result[30], Cout[30], equal_out[29], equal_out[30]);
alu_bottom alu_bottom1(src1[31], src2[31], 1'b0, A_invert, B_invert, Cout[30], operation, bonus_control, w_result[31], w_cout, set, w_overflow, equal_out[30]);


or or0(tmp[0], result[0], result[1]);
or or1(tmp[1], result[2], result[3]);
or or2(tmp[2], result[4], result[5]);
or or3(tmp[3], result[6], result[7]);
or or4(tmp[4], result[8], result[9]);
or or5(tmp[5], result[10], result[11]);
or or6(tmp[6], result[12], result[13]);
or or7(tmp[7], result[14], result[15]);
or or8(tmp[8], result[16], result[17]);
or or9(tmp[9], result[18], result[19]);
or or10(tmp[10], result[20], result[21]);
or or11(tmp[11], result[22], result[23]);
or or12(tmp[12], result[24], result[25]);
or or13(tmp[13], result[26], result[27]);
or or14(tmp[14], result[28], result[29]);
or or15(tmp[15], result[30], result[31]);

or or16(tmp[16], tmp[0], tmp[1]);
or or17(tmp[17], tmp[2], tmp[3]);
or or18(tmp[18], tmp[4], tmp[5]);
or or19(tmp[19], tmp[6], tmp[7]);
or or20(tmp[20], tmp[8], tmp[9]);
or or21(tmp[21], tmp[10], tmp[11]);
or or22(tmp[22], tmp[12], tmp[13]);
or or23(tmp[23], tmp[14], tmp[15]);

or or24(tmp[24], tmp[16], tmp[17]);
or or25(tmp[25], tmp[18], tmp[19]);
or or26(tmp[26], tmp[20], tmp[21]);
or or27(tmp[27], tmp[22], tmp[23]);

or or28(tmp[28], tmp[24], tmp[25]);
or or29(tmp[29], tmp[26], tmp[27]);

or or30(tmp[30], tmp[28], tmp[29]);
not not0(w_zero, tmp[30]);



assign A_invert = ALU_control[3];
assign B_invert = ALU_control[2];
assign Cin = ALU_control[2];
assign operation = {ALU_control[1], ALU_control[0]};

always@( * )
begin
	if(rst_n)
	begin
		zero = w_zero;
		overflow = (operation == 2'b10) ? w_overflow: 1'b0;
		result = w_result;
		cout = (operation == 2'b10) ? w_cout : 1'b0;
	end
	else
	begin
		zero = 1'b0;
		overflow = 1'b0;
		result = 32'b0;
		cout = 1'b0;
	end
end

endmodule
