//Writer:      0416021������ 0416246���ۯ�

module Shift_Left_Two_26(
    data_i,
    data_o
    );

//I/O ports                    
input [26-1:0] data_i;
output [28-1:0] data_o;

//shift left 2
assign data_o = {data_i[25:0], 2'b0}; 
endmodule

