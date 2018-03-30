//Writer:      0416021������ 0416246���ۯ�
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
