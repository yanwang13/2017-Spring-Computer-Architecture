`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:41:19 03/17/2017 
// Design Name: 
// Module Name:    half_adder 
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
module full_adder(
    input src1,
    input src2,
    input cin,
    output result,
    output cout
    );

wire tmp, tmp1, tmp2;

xor res1(tmp, src1, src2);
xor res2(result, tmp, cin);
and carry1(tmp1, src1, src2);
and carry2(tmp2, tmp, cin);
or carry3(cout, tmp1, tmp2);

endmodule
