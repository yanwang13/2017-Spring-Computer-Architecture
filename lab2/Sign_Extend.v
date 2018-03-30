//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416021曾香耘 0416246王彥茹
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
	 ori_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
input				  ori_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;

//Sign extended
always@(*)begin
	if(ori_i==1'b1)begin
		data_o [31:16] = 16'b0000000000000000;
		data_o [15:0] = data_i;
	end
	else begin
		data_o [31:16] = {data_i[15], data_i[15], data_i[15], data_i[15], data_i[15], data_i[15], data_i[15], data_i[15], data_i[15], data_i[15], data_i[15], data_i[15], data_i[15], data_i[15], data_i[15], data_i[15]};
		data_o [15:0] = data_i;
	end
end
endmodule      
     