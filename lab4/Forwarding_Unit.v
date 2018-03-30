//Writer:      0416021曾香耘 0416246王彥茹
module Forwarding_Unit(
    input [4:0] ID_EX_Rs,
    input [4:0] ID_EX_Rt,
    input [4:0] EX_MEM_Rd,
    input [4:0] MEM_WB_Rd,
    input EX_MEM_regwrite,
    input MEM_WB_regwrite,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
    );

always@(*)
begin
	if(EX_MEM_regwrite && (EX_MEM_Rd != 5'd0) && (EX_MEM_Rd == ID_EX_Rs)) ForwardA <= 2'b01;
	else if(MEM_WB_regwrite && (MEM_WB_Rd != 5'd0) && (MEM_WB_Rd == ID_EX_Rs)) ForwardA <= 2'b10;
	else ForwardA <= 2'b00;
end

always@(*)
begin
	if(EX_MEM_regwrite && (EX_MEM_Rd != 5'd0) && (EX_MEM_Rd == ID_EX_Rt)) ForwardB <= 2'b01;
	else if(MEM_WB_regwrite && (MEM_WB_Rd != 5'd0) && (MEM_WB_Rd == ID_EX_Rt)) ForwardB <= 2'b10;
	else ForwardB <= 2'b00;
end

endmodule
