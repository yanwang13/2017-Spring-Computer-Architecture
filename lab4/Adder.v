//Writer:      0416021´¿­»¯Ð 0416246¤ý«Û¯ø

module Adder(
    src1_i,
	src2_i,
	sum_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
output [32-1:0]	 sum_o;

//Internal Signals
wire    [32-1:0]	 sum_o;

//Parameter
wire	[32-1:0]	cout;

//Main function
full_adder FA0(src1_i[0], src2_i[0], 1'b0, sum_o[0], cout[0]);
full_adder FA1(src1_i[1], src2_i[1], cout[0], sum_o[1], cout[1]);
full_adder FA2(src1_i[2], src2_i[2], cout[1], sum_o[2], cout[2]);
full_adder FA3(src1_i[3], src2_i[3], cout[2], sum_o[3], cout[3]);
full_adder FA4(src1_i[4], src2_i[4], cout[3], sum_o[4], cout[4]);
full_adder FA5(src1_i[5], src2_i[5], cout[4], sum_o[5], cout[5]);
full_adder FA6(src1_i[6], src2_i[6], cout[5], sum_o[6], cout[6]);
full_adder FA7(src1_i[7], src2_i[7], cout[6], sum_o[7], cout[7]);
full_adder FA8(src1_i[8], src2_i[8], cout[7], sum_o[8], cout[8]);
full_adder FA9(src1_i[9], src2_i[9], cout[8], sum_o[9], cout[9]);
full_adder FA10(src1_i[10], src2_i[10], cout[9], sum_o[10], cout[10]);
full_adder FA11(src1_i[11], src2_i[11], cout[10], sum_o[11], cout[11]);
full_adder FA12(src1_i[12], src2_i[12], cout[11], sum_o[12], cout[12]);
full_adder FA13(src1_i[13], src2_i[13], cout[12], sum_o[13], cout[13]);
full_adder FA14(src1_i[14], src2_i[14], cout[13], sum_o[14], cout[14]);
full_adder FA15(src1_i[15], src2_i[15], cout[14], sum_o[15], cout[15]);
full_adder FA16(src1_i[16], src2_i[16], cout[15], sum_o[16], cout[16]);
full_adder FA17(src1_i[17], src2_i[17], cout[16], sum_o[17], cout[17]);
full_adder FA18(src1_i[18], src2_i[18], cout[17], sum_o[18], cout[18]);
full_adder FA19(src1_i[19], src2_i[19], cout[18], sum_o[19], cout[19]);
full_adder FA20(src1_i[20], src2_i[20], cout[19], sum_o[20], cout[20]);
full_adder FA21(src1_i[21], src2_i[21], cout[20], sum_o[21], cout[21]);
full_adder FA22(src1_i[22], src2_i[22], cout[21], sum_o[22], cout[22]);
full_adder FA23(src1_i[23], src2_i[23], cout[22], sum_o[23], cout[23]);
full_adder FA24(src1_i[24], src2_i[24], cout[23], sum_o[24], cout[24]);
full_adder FA25(src1_i[25], src2_i[25], cout[24], sum_o[25], cout[25]);
full_adder FA26(src1_i[26], src2_i[26], cout[25], sum_o[26], cout[26]);
full_adder FA27(src1_i[27], src2_i[27], cout[26], sum_o[27], cout[27]);
full_adder FA28(src1_i[28], src2_i[28], cout[27], sum_o[28], cout[28]);
full_adder FA29(src1_i[29], src2_i[29], cout[28], sum_o[29], cout[29]);
full_adder FA30(src1_i[30], src2_i[30], cout[29], sum_o[30], cout[30]);
full_adder FA31(src1_i[31], src2_i[31], cout[30], sum_o[31], cout[31]);

endmodule





                    
                    