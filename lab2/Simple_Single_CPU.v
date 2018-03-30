//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416021曾香耘 0416246王彥茹
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire	[32-1:0]	pc_out, adder1_out, mux_pc_source_out;
wire	[32-1:0] instruction;
wire	[5-1:0]	mux_write_reg_out;
wire	[32-1:0] alu_result;
wire	[32-1:0]	read_data1, read_data2;
wire	[32-1:0] se_out, mux_alusrc_out, shifter_out, adder2_out;
wire	and0_out, zero;
wire	regdst, regwrite, branch, alusrc;
wire	[3-1:0] aluop;
wire	[4-1:0] ac_out;
wire			  ori;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(mux_pc_source_out) ,   
	    .pc_out_o(pc_out) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_out),     
	    .sum_o(adder1_out)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
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
	    .rst_i(rst_i) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(mux_write_reg_out) ,  
        .RDdata_i(alu_result)  , 
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
		.ori_o(ori)
	    );

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(aluop),   
        .ALUCtrl_o(ac_out) 
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
	    .src2_i(shifter_out),     
	    .sum_o(adder2_out)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(se_out),
        .data_o(shifter_out)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(adder1_out),
        .data1_i(adder2_out),
        .select_i(and0_out),
        .data_o(mux_pc_source_out)
        );

and and0(and0_out, branch, zero);		  

endmodule
		  


