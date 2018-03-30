//Writer:      0416021´¿­»¯Ð 0416246¤ý«Û¯ø

module CPU(
        clk_i,
		start_i
		);
		
//I/O port
input         clk_i;
input         start_i;

//Internal Signles
wire	[32-1:0]	pc_out, adder1_out, mux_pc_source_out;
wire	[32-1:0] instruction;
wire	[5-1:0]	mux_write_reg_out;
wire	[32-1:0] alu_result;
wire	[32-1:0]	read_data1, read_data2;
wire	[32-1:0] se_out, mux_alusrc_out, shifter1_out, adder2_out;
wire	and0_out, zero;
wire	regdst, regwrite, branch, alusrc;
wire	[3-1:0] aluop;
wire	[4-1:0] ac_out;
wire			  ori;
wire	[2-1:0] branchtype, memtoreg;
wire			  jump, memread, memwrite;
wire	[32-1:0] readdata, mux_writedata_out;
wire	[28-1:0] shifter2_out;
wire	[32-1:0] mux_after_pc_source_out;
wire 			  jal;
wire	[32-1:0] writedata;
wire	[5-1:0]	writeregister;
wire	[32-1:0]	mux_jr_out;
wire				mux_branch_out;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (start_i),     
	    .pc_in_i(mux_jr_out) ,   
	    .pc_out_o(pc_out) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_out),     
	    .sum_o(adder1_out)    
	    );
	
Instruction_Memory IM(
        .addr_i(pc_out),  
	    .instr_o(instruction)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(regdst),
        .data_o(mux_write_reg_out)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(start_i) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(writeregister) ,  
        .RDdata_i(writedata)  , 
        .RegWrite_i (regwrite),
        .RSdata_o(read_data1) ,  
        .RTdata_o(read_data2)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(regwrite), 
	    .ALU_op_o(aluop),   
	    .ALUSrc_o(alusrc),   
	    .RegDst_o(regdst),   
		 .Branch_o(branch),
		 .ori_o(ori),
		 .BranchType_o(branchtype),
		 .Jump_o(jump),
		 .MemRead_o(memread),
		 .MemWrite_o(memwrite),
		 .MemtoReg_o(memtoreg),
		 .jal_o(jal)
	    );

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(aluop),   
        .ALUCtrl_o(ac_out),
		  .jr_o(jr) 
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
		  .ori_i(ori),
        .data_o(se_out)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(read_data2),
        .data1_i(se_out),
        .select_i(alusrc),
        .data_o(mux_alusrc_out)
        );	
		
ALU ALU(
        .src1_i(read_data1),
	    .src2_i(mux_alusrc_out),
	    .ctrl_i(ac_out),
		 .shamt_i(instruction[10:6]),
	    .result_o(alu_result),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(adder1_out),     
	    .src2_i(shifter1_out),     
	    .sum_o(adder2_out)      
	    );
		
Shift_Left_Two_32 Shifter1(
        .data_i(se_out),
        .data_o(shifter1_out)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(adder1_out),
        .data1_i(adder2_out),
        .select_i(and0_out),
        .data_o(mux_pc_source_out)
        );

and and0(and0_out, branch, mux_branch_out);

Data_Memory DM(
		  .clk_i(clk_i),
		  .addr_i(alu_result),
		  .data_i(read_data2),
		  .MemRead_i(memread),
		  .MemWrite_i(memwrite),
		  .data_o(readdata)
		  );

MUX_3to1 #(.size(32)) Mux_WriteData(
        .data0_i(alu_result),
        .data1_i(readdata),
		  .data2_i(se_out),
        .select_i(memtoreg),
        .data_o(mux_writedata_out)
        );	  
		  
Shift_Left_Two_26 Shifter2(
        .data_i(instruction[25:0]),
        .data_o(shifter2_out)
        ); 		

MUX_2to1 #(.size(32)) Mux_After_PC_Source(
        .data0_i({adder1_out[31:28], shifter2_out}),
        .data1_i(mux_pc_source_out),
        .select_i(jump),
        .data_o(mux_after_pc_source_out)
        );
		  
MUX_2to1 #(.size(32)) Mux_Jal_WriteData(
        .data0_i(mux_writedata_out),
        .data1_i(adder1_out),
        .select_i(jal),
        .data_o(writedata)
        );
		  
MUX_2to1 #(.size(5)) Mux_Jal_31(
        .data0_i(mux_write_reg_out),
        .data1_i(5'b11111),
        .select_i(jal),
        .data_o(writeregister)
        );
		  
MUX_2to1 #(.size(32)) Mux_Jr(
        .data0_i(mux_after_pc_source_out),
        .data1_i(read_data1),
        .select_i(jr),
        .data_o(mux_jr_out)
        );
		  
MUX_4to1 Mux_Branch(
        .data0_i(zero),
        .data1_i(zero | alu_result[31:31]),
		  .data2_i(alu_result[31:31]),
		  .data3_i(~zero),
        .select_i(branchtype),
        .data_o(mux_branch_out)
        );	  
endmodule
		  


