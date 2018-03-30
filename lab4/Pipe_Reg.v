//Writer:      0416021曾香耘 0416246王彥茹
module Pipe_Reg(
    clk_i,
	rst_i,
	data_i,
	data_o,
	write,
	flush
	);

parameter size = 0;

input					clk_i;		  
input					rst_i;
input		[size-1: 0]	data_i;
input					write;
input					flush;
output reg	[size-1: 0]	data_o;

always @(posedge clk_i) begin
    if(~rst_i || flush)
        data_o <= 0;
    else if(write == 1'b1)
        data_o <= data_i;
	 else
		  data_o <= data_o;
end

endmodule	