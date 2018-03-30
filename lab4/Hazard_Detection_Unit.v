//Writer:      0416021曾香耘 0416246王彥茹
module Hazard_Detection_Unit(
    input [4:0] IF_ID_Rs,
    input [4:0] IF_ID_Rt,
    input [4:0] ID_EX_Rt,
    input ID_EX_memread,
	 input branch,
    output reg pcwrite,
    output reg IF_ID_write,
    output reg ID_flush,
	 output reg EX_flush,
	 output reg IF_flush
    );

always@(*)
begin
	if(ID_EX_memread && ((ID_EX_Rt == IF_ID_Rs) || (ID_EX_Rt == IF_ID_Rt)))
	begin
		pcwrite <= 1'b0;
		IF_ID_write <= 1'b0;
		ID_flush <= 1'b1;
		EX_flush <= 1'b0;
		IF_flush <= 1'b0;
	end
	else if(branch)
	begin
		pcwrite <= 1'b1;
		IF_ID_write <= 1'b1;
		ID_flush <= 1'b1;
		EX_flush <= 1'b1;
		IF_flush <= 1'b1;
	end
	else
	begin
		pcwrite <= 1'b1;
		IF_ID_write <= 1'b1;
		ID_flush <= 1'b0;
		EX_flush <= 1'b0;
		IF_flush <= 1'b0;
	end
end

endmodule
