`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:01 10/10/2011 
// Design Name: 
// Module Name:    alu_top 
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

module alu_bottom(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
					bonus_control,
               result,     //1 bit result   (output)
               cout,					//1 bit carry out(output)
					set,
					overflow,
					equal
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;
input [2:0]   bonus_control;
input 		  equal;

output        result;
output        cout;
output        set;
output 		  overflow;

reg           result;
reg           tmp_set;

wire inverted_a, inverted_b;
wire after_and, after_or;
wire after_add;
wire n_src1, n_src2;
wire n_result;
wire [3:0] over;
wire equal_out;
wire n_less, n_equal, sgt, sle;

xor a_inverter(inverted_a, src1, A_invert);
xor b_inverter(inverted_b, src2, B_invert);
and and_gate(after_and, inverted_a, inverted_b);
or or_gate(after_or, inverted_a, inverted_b);
full_adder FA(inverted_a, inverted_b, cin, after_add, cout);

not not_src1(n_src1, src1);
not not_src2(n_src2, src2);
not not_result(n_result, result);
and and0(over[0], n_src1, n_src2);
and and1(over[1], over[0], result);
and and2(over[2], src1, src2);
and and3(over[3], over[2], n_result);
or over_or(overflow, over[1], over[3]);

or check_equal(equal_out, equal, after_add);
not not_less(n_less, after_add);
not not_equal(n_equal, equal_out);
and sgt_gate(sgt, n_less, equal_out);
or sle_gate(sle, after_add, n_equal);

always@( * )
begin
	case(operation)
		2'b00: result = after_and;
		2'b01: result = after_or;
		2'b10: result = after_add;
		2'b11: result = less;
	endcase
end

assign set = tmp_set;

always@(*)
begin
	case(bonus_control)
		3'b000: tmp_set = after_add;
		3'b001: tmp_set = sgt;
		3'b010: tmp_set = sle;
		3'b011: tmp_set = n_less;
		3'b110: tmp_set = n_equal;
		3'b100: tmp_set = equal_out;
		default: tmp_set = 1'b0;
	endcase
end

endmodule
