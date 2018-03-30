//Writer:      0416021´¿­»¯Ð 0416246¤ý«Û¯ø

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	ori_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output			ori_o;
output			MemRead_o;
output			MemWrite_o;
output         MemtoReg_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg				ori_o;
reg				MemRead_o;
reg				MemWrite_o;
reg	 		   MemtoReg_o;

//Parameter


//Main function
always@(*)
begin
	if(instr_op_i == 6'b000000) // r-type
	begin
		RegDst_o = 1'b1;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b1;
		Branch_o = 1'b0;
		ALU_op_o = 3'b010;
		ori_o = 1'b0;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 1'b0;
	end
	else if(instr_op_i == 6'b001000) //i-type
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		Branch_o = 1'b0;
		ALU_op_o = 3'b100;
		ori_o = 1'b0;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 1'b0;
	end
	else if(instr_op_i == 6'b000100) //beq
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b0;
		Branch_o = 1'b1;
		ALU_op_o = 3'b001;
		ori_o = 1'b0;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 1'b1;
	end
	else if(instr_op_i == 6'b000101) //bne
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b0;
		Branch_o = 1'b1;
		ALU_op_o = 3'b011;
		ori_o = 1'b0;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 1'b1;
	end
	else if(instr_op_i == 6'b001111) //load upper
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		Branch_o = 1'b0;
		ALU_op_o = 3'b101;
		ori_o = 1'b0;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 1'b0;
	end
	else if(instr_op_i == 6'b001101) //ori
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		Branch_o = 1'b0;
		ALU_op_o = 3'b110;
		ori_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 1'b0;
	end
	else if(instr_op_i == 6'b100011) //lw
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		Branch_o = 1'b0;
		ALU_op_o = 3'b100;
		ori_o = 1'b0;
		MemRead_o = 1'b1;
		MemWrite_o = 1'b0;
		MemtoReg_o = 1'b1;
	end
	else if(instr_op_i == 6'b101011) //sw
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b0;
		Branch_o = 1'b0;
		ALU_op_o = 3'b100;
		ori_o = 1'b0;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b1;
		MemtoReg_o = 1'b1;
	end
	else
	begin
		RegDst_o = 1'b1;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		Branch_o = 1'b1;
		ALU_op_o = 3'b111;
		ori_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 1'b1;
	end
end


endmodule





                    
                    