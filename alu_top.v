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

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)

               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
					
					equal,					
					equal_out
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;
input			  equal;


output        result;
output        cout;
output		  equal_out;

reg           result;


wire inverted_a, inverted_b;
wire after_and, after_or;
wire after_add;

xor a_inverter(inverted_a, src1, A_invert);
xor b_inverter(inverted_b, src2, B_invert);
and and_gate(after_and, inverted_a, inverted_b);
or or_gate(after_or, inverted_a, inverted_b);
full_adder FA(inverted_a, inverted_b, cin, after_add, cout);

or check_equal(equal_out, equal, after_add);


always@( * )
begin
	case(operation)
		2'b00: result = after_and;
		2'b01: result = after_or;
		2'b10: result = after_add;
		2'b11: result = less;
	endcase
end

endmodule
