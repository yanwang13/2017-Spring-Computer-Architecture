//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416021曾香耘 0416246王彥茹
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
           src1_i,          // 32 bits source 1          (input)
           src2_i,          // 32 bits source 2          (input)
           ctrl_i,   		 // 4 bits ALU control input  (input)
			  shamt_i,
           result_o,        // 32 bits result_o            (output)
           zero_o           // 1 bit when the output is 0, zero_o must be set (output)
           );


input  [32-1:0] src1_i;
input  [32-1:0] src2_i;
input   [4-1:0] ctrl_i;
input	 [5-1:0] shamt_i;

output [32-1:0] result_o;
output          zero_o;

reg    [32-1:0] result_o;
reg             zero_o;

always@( * )
begin
	case(ctrl_i)
		4'b0000: result_o = src1_i & src2_i;
		4'b0001: result_o = src1_i | src2_i;
		4'b0010: result_o = src1_i + src2_i;
		4'b0110: result_o = src1_i - src2_i;
		4'b1100: result_o = ~(src1_i | src2_i);
		4'b1101: result_o = ~(src1_i & src2_i);
		4'b0111: result_o = (src1_i < src2_i) ? 32'd1 : 32'd0; //sltu
		4'b1000: result_o = ($signed(src1_i) < $signed(src2_i)) ? 32'd1 : 32'd0; //slt
		4'b1001: result_o = src2_i << shamt_i;
		4'b1010: result_o = src2_i << src1_i;
		4'b1011: result_o = src2_i << 16;
		4'b0101: result_o = src1_i - src2_i;
		default: result_o = 32'd0;
	endcase
end

always@( * )
begin
	if(ctrl_i != 4'b0101) zero_o = (result_o == 0);
	else zero_o = (result_o != 0);
end

endmodule
