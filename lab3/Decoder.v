//Writer:      0416021´¿­»¯Ð 0416246¤ý«Û¯ø

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	ori_o,
	BranchType_o,
	Jump_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o,
	jal_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output			ori_o;
output [2-1:0] BranchType_o;
output			Jump_o;
output			MemRead_o;
output			MemWrite_o;
output [2-1:0] MemtoReg_o;
output			jal_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg				ori_o;
reg	 [2-1:0] BranchType_o;
reg				Jump_o;
reg				MemRead_o;
reg				MemWrite_o;
reg	 [2-1:0] MemtoReg_o;
reg				jal_o;

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
		BranchType_o = 2'b11;
		Jump_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b00;
		jal_o = 1'b0;
	end
	else if(instr_op_i == 6'b001000) //i-type
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		Branch_o = 1'b0;
		ALU_op_o = 3'b100;
		ori_o = 1'b0;
		BranchType_o = 2'b11;
		Jump_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b00;
		jal_o = 1'b0;
	end
	else if(instr_op_i == 6'b000100) //beq
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b0;
		Branch_o = 1'b1;
		ALU_op_o = 3'b001;
		ori_o = 1'b0;
		BranchType_o = 2'b00;
		Jump_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b11;
		jal_o = 1'b0;
	end
	else if(instr_op_i == 6'b001111) //li
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		Branch_o = 1'b0;
		ALU_op_o = 3'b101;
		ori_o = 1'b0;
		BranchType_o = 2'b11;
		Jump_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b00;
		jal_o = 1'b0;
	end
	else if(instr_op_i == 6'b001101) //ori
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		Branch_o = 1'b0;
		ALU_op_o = 3'b110;
		ori_o = 1'b1;
		BranchType_o = 2'b11;
		Jump_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b00;
		jal_o = 1'b0;
	end
	else if(instr_op_i == 6'b000101) //bne
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b0;
		Branch_o = 1'b1;
		ALU_op_o = 3'b001;
		ori_o = 1'b0;
		BranchType_o = 2'b11;
		Jump_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b11;
		jal_o = 1'b0;
	end
	else if(instr_op_i == 6'b100011) //lw
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		Branch_o = 1'b0;
		ALU_op_o = 3'b100;
		ori_o = 1'b0;
		BranchType_o = 2'b11;
		Jump_o = 1'b1;
		MemRead_o = 1'b1;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b01;
		jal_o = 1'b0;
	end
	else if(instr_op_i == 6'b101011) //sw
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b0;
		Branch_o = 1'b0;
		ALU_op_o = 3'b100;
		ori_o = 1'b0;
		BranchType_o = 2'b11;
		Jump_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b1;
		MemtoReg_o = 2'b11;
		jal_o = 1'b0;
	end
	else if(instr_op_i == 6'b000010) //jump
	begin
		RegDst_o = 1'b1;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b0;
		Branch_o = 1'b0;
		ALU_op_o = 3'b111;
		ori_o = 1'b0;
		BranchType_o = 2'b11;
		Jump_o = 1'b0;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b11;
		jal_o = 1'b0;
	end
	else if(instr_op_i == 6'b000011) //jal
	begin
		RegDst_o = 1'b1;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		Branch_o = 1'b0;
		ALU_op_o = 3'b111;
		ori_o = 1'b0;
		BranchType_o = 2'b11;
		Jump_o = 1'b0;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b11;
		jal_o = 1'b1;
	end
	else if(instr_op_i == 6'b000111) //ble
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b0;
		Branch_o = 1'b1;
		ALU_op_o = 3'b001;
		ori_o = 1'b0;
		BranchType_o = 2'b01;
		Jump_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b11;
		jal_o = 1'b0;
	end
	else if(instr_op_i == 6'b000110) //blt
	begin
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b0;
		Branch_o = 1'b1;
		ALU_op_o = 3'b001;
		ori_o = 1'b0;
		BranchType_o = 2'b10;
		Jump_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b11;
		jal_o = 1'b0;
	end
	else
	begin
		RegDst_o = 1'b1;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b0;
		Branch_o = 1'b0;
		ALU_op_o = 3'b111;
		ori_o = 1'b0;
		BranchType_o = 2'b11;
		Jump_o = 1'b1;
		MemRead_o = 1'b0;
		MemWrite_o = 1'b0;
		MemtoReg_o = 2'b11;
		jal_o = 1'b0;
	end
end


endmodule





                    
                    