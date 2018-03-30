//Writer:      0416021曾香耘 0416246王彥茹

module MUX_4to1(
               data0_i,
               data1_i,
					data2_i,
					data3_i,
               select_i,
               data_o
               );		   
			
//I/O ports               
input   				 data0_i;          
input   				 data1_i;
input   				 data2_i;
input   				 data3_i;
input   [2-1:0]    select_i;
output  				 data_o; 

//Internal Signals
reg     				 data_o;

//Main function
always@(*)
begin
	if(select_i == 2'b00) data_o = data0_i;
	else if(select_i == 2'b01) data_o = data1_i;
	else if(select_i == 2'b10) data_o = data2_i;
	else data_o = data3_i;
end

endmodule
