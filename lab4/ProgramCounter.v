//Writer:      0416021´¿­»¯Ð 0416246¤ý«Û¯ø

module ProgramCounter(
    clk_i,
	rst_i,
	pc_in_i,
	pc_out_o,
	write
	);
     
//I/O ports
input           clk_i;
input	        rst_i;
input  [32-1:0] pc_in_i;
input				write;
output [32-1:0] pc_out_o;
 
//Internal Signals
reg    [32-1:0] pc_out_o;
 
//Parameter

    
//Main function
always @(posedge clk_i) begin
    if(~rst_i)
	    pc_out_o <= 0;
	else if(write == 1'b1)
	    pc_out_o <= pc_in_i;
	else
		 pc_out_o <= pc_out_o;
end

endmodule



                    
                    