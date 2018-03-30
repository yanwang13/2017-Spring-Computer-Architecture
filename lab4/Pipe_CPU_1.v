//Writer:      0416021曾香耘 0416246王彥茹
module Pipe_CPU_1(
        clk_i,
		rst_i
		);
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/
/**** IF stage ****/

wire	[32-1:0]	pc_out, adder1_out, mux_pc_source_out;
wire	[32-1:0] instruction;
wire				pcwrite, IF_ID_write;
wire				IF_flush;

/**** ID stage ****/

wire	[5-1:0]	mux_write_reg_out;
wire	[32-1:0]	read_data1, read_data2;

//control signal
wire	regdst, regwrite, branch, alusrc;
wire	[3-1:0] aluop;
wire			  ori;
wire	        memtoreg;
wire			  memread, memwrite;
wire			  ID_flush;


/**** EX stage ****/

wire	[32-1:0] alu_result;
wire	[32-1:0] se_out, mux_alusrc_out, shifter_out, adder2_out;
wire	[4-1:0] ac_out;
wire	[32-1:0] mux5_out, mux6_out;

//control signal
wire           zero;
wire	[2-1:0]	ForwardA, ForwardB;
wire				EX_flush;

/**** MEM stage ****/
wire	and0_out;
wire	[32-1:0] readdata;

//control signal


/**** WB stage ****/
wire	[32-1:0] mux_writedata_out;

//control signal

/**** Pipe Line Register ****/
/**** IF/ID ****/
wire [64-1:0] IF_ID_out;
/**** ID/EX ****/
wire [153-1:0] ID_EX_out;
/**** EX/MEM ****/
wire [107-1:0] EX_MEM_out;
/**** MEM/WB ****/
wire [71-1:0] MEM_WB_out;

/****************************************
Instnatiate modules
****************************************/
//Instantiate the components in IF stage
MUX_2to1 #(.size(32)) Mux1(
		  .data0_i(adder1_out),
        .data1_i(EX_MEM_out[101:70]),
        .select_i(and0_out),
        .data_o(mux_pc_source_out)
		);

ProgramCounter PC(
		 .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(mux_pc_source_out) ,   
	    .pc_out_o(pc_out),
		 .write(pcwrite)
        );

Instr_Memory IM(
		 .pc_addr_i(pc_out),  
	    .instr_o(instruction)
	    );

Adder Add_pc(
		 .src1_i(32'd4),     
	    .src2_i(pc_out),     
	    .sum_o(adder1_out)
		);

//Pipeline IF/ID
Pipe_Reg #(.size(64)) IF_ID(       //N is the total length of input/output
		 .clk_i(clk_i),
		 .rst_i(rst_i),
		 .data_i({adder1_out,instruction}),
		 .data_o(IF_ID_out),
		 .write(IF_ID_write),
		 .flush(IF_flush)
		);
//Instantiate the components in ID stage
Reg_File RF(
		  .clk_i(clk_i),      
	     .rst_i(rst_i) ,     
        .RSaddr_i(IF_ID_out[25:21]) ,  
        .RTaddr_i(IF_ID_out[20:16]) ,  
        .RDaddr_i(MEM_WB_out[4:0]) ,  
        .RDdata_i(mux_writedata_out)  , 
        .RegWrite_i (MEM_WB_out[70]),
        .RSdata_o(read_data1) ,  
        .RTdata_o(read_data2)   
		);

Decoder Control(
		 .instr_op_i(IF_ID_out[31:26]), 
	    .RegWrite_o(regwrite), 
	    .ALU_op_o(aluop),   
	    .ALUSrc_o(alusrc),   
	    .RegDst_o(regdst),   
		 .Branch_o(branch),
		 .ori_o(ori),
		 .MemRead_o(memread),
		 .MemWrite_o(memwrite),
		 .MemtoReg_o(memtoreg)
		);

Sign_Extend Sign_Extend(
		  .data_i(IF_ID_out[15:0]),
		  .ori_i(ori),
        .data_o(se_out)
		);	

Pipe_Reg #(.size(153)) ID_EX(
		 .clk_i(clk_i),
		 .rst_i(rst_i),
		 .data_i({IF_ID_out[25:21], regwrite, memtoreg, branch, memread, memwrite, regdst, aluop, alusrc, IF_ID_out[63:32], read_data1, read_data2, se_out, IF_ID_out[20:11]}),
		 .data_o(ID_EX_out),
		 .write(1'b1),
		 .flush(ID_flush)
		);


//Instantiate the components in EX stage	   
ALU ALU(
		 .src1_i(mux5_out), //
	    .src2_i(mux_alusrc_out),
	    .ctrl_i(ac_out),
		 .shamt_i(ID_EX_out[20:16]),
	    .result_o(alu_result),
		.zero_o(zero)
		);

ALU_Ctrl ALU_Ctrl(
		  .funct_i(ID_EX_out[15:10]),   
        .ALUOp_i(ID_EX_out[141:139]),   
        .ALUCtrl_o(ac_out) 
		);

MUX_2to1 #(.size(32)) Mux2(
		  .data0_i(mux6_out), //
        .data1_i(ID_EX_out[41:10]),
        .select_i(ID_EX_out[138]),
        .data_o(mux_alusrc_out)
        );

MUX_2to1 #(.size(5)) Mux3(
			.data0_i(ID_EX_out[9:5]),
        .data1_i(ID_EX_out[4:0]),
        .select_i(ID_EX_out[142]),
        .data_o(mux_write_reg_out)
        );
		  
Adder Adder2(
        .src1_i(ID_EX_out[137:106]),     
	    .src2_i(shifter_out),     
	    .sum_o(adder2_out)      
	    );
		 
Shift_Left_Two_32 Shifter(
        .data_i(ID_EX_out[41:10]),
        .data_o(shifter_out)
        ); 	

MUX_3to1 #(.size(32)) Mux5 (
    .data0_i(ID_EX_out[105:74]), 
    .data1_i(EX_MEM_out[68:37]), 
    .data2_i(mux_writedata_out), 
    .select_i(ForwardA), 
    .data_o(mux5_out)
    );

MUX_3to1 #(.size(32)) Mux6 (
    .data0_i(ID_EX_out[73:42]), 
    .data1_i(EX_MEM_out[68:37]), 
    .data2_i(mux_writedata_out), 
    .select_i(ForwardB), 
    .data_o(mux6_out)
    );

Pipe_Reg #(.size(107)) EX_MEM(
		 .clk_i(clk_i),
		 .rst_i(rst_i),
		 .data_i({ID_EX_out[147:143], adder2_out, zero, alu_result, mux6_out, mux_write_reg_out}),
		 .data_o(EX_MEM_out),
		 .write(1'b1),
		 .flush(EX_flush)
		);

//Instantiate the components in MEM stage
Data_Memory DM(
		  .clk_i(clk_i),
		  .addr_i(EX_MEM_out[68:37]),
		  .data_i(EX_MEM_out[36:5]),
		  .MemRead_i(EX_MEM_out[103]),
		  .MemWrite_i(EX_MEM_out[102]),
		  .data_o(readdata)
	    );

and and0(and0_out, EX_MEM_out[104], EX_MEM_out[69]);

Pipe_Reg #(.size(71)) MEM_WB(
		 .clk_i(clk_i),
		 .rst_i(rst_i),
		 .data_i({EX_MEM_out[106:105], readdata, EX_MEM_out[68:37], EX_MEM_out[4:0]}),
		 .data_o(MEM_WB_out),
		 .write(1'b1),
		 .flush(1'b0)
		);

//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux4(
			.data0_i(MEM_WB_out[36:5]),
        .data1_i(MEM_WB_out[68:37]),
        .select_i(MEM_WB_out[69]),
        .data_o(mux_writedata_out)
        );

/****************************************
signal assignment
****************************************/	

Forwarding_Unit FU(
    .ID_EX_Rs(ID_EX_out[152:148]), 
    .ID_EX_Rt(ID_EX_out[9:5]), 
    .EX_MEM_Rd(EX_MEM_out[4:0]), 
    .MEM_WB_Rd(MEM_WB_out[4:0]), 
    .EX_MEM_regwrite(EX_MEM_out[106]), 
    .MEM_WB_regwrite(MEM_WB_out[70]), 
    .ForwardA(ForwardA), 
    .ForwardB(ForwardB)
    );
	 
Hazard_Detection_Unit HDU(
    .IF_ID_Rs(IF_ID_out[25:21]), 
    .IF_ID_Rt(IF_ID_out[20:16]), 
    .ID_EX_Rt(ID_EX_out[9:5]), 
    .ID_EX_memread(ID_EX_out[144]),
	 .branch(and0_out),
    .pcwrite(pcwrite), 
    .IF_ID_write(IF_ID_write), 
    .ID_flush(ID_flush),
	 .EX_flush(EX_flush),
	 .IF_flush(IF_flush)
    );

endmodule

