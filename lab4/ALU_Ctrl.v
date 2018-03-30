//Writer:      0416021´¿­»¯Ð 0416246¤ý«Û¯ø

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation
always@( * )
begin
	if(ALUOp_i == 3'b100) ALUCtrl_o = 4'b0010; //addi, lw 2
	else if(ALUOp_i == 3'b001) ALUCtrl_o = 4'b0110; //beq 6
	else if(ALUOp_i == 3'b011) ALUCtrl_o = 4'b0101; //bne 5
	else if(ALUOp_i == 3'b101) ALUCtrl_o = 4'b1011; //lui 11
	else if(ALUOp_i == 3'b110) ALUCtrl_o = 4'b0001; //ori 1
	else if({ALUOp_i, funct_i} == 9'b010100000) ALUCtrl_o = 4'b0010; //add 2
	else if({ALUOp_i, funct_i} == 9'b010100010) ALUCtrl_o = 4'b0110; //sub 6
	else if({ALUOp_i, funct_i} == 9'b010100100) ALUCtrl_o = 4'b0000; //and 0
	else if({ALUOp_i, funct_i} == 9'b010100101) ALUCtrl_o = 4'b0001; //or 1
	else if({ALUOp_i, funct_i} == 9'b010101010) ALUCtrl_o = 4'b1000; //slt 8
	else if({ALUOp_i, funct_i} == 9'b010101011) ALUCtrl_o = 4'b0111; //sltu 7
	else if({ALUOp_i, funct_i} == 9'b010000000) ALUCtrl_o = 4'b1001; //sll 9
	else if({ALUOp_i, funct_i} == 9'b010000100) ALUCtrl_o = 4'b1010; //sllv 10
	else if({ALUOp_i, funct_i} == 9'b010011000) ALUCtrl_o = 4'b0011; //mul 3 
	else ALUCtrl_o = 4'b1111;
end

endmodule     





                    
                    