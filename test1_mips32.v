module test1_mips32;
reg clk1,clk2;
integer k;

pipe_MIPS32 mips(clk1,clk2);

initial
begin
	clk1=0;clk1=0;
	repeat(20)
	begin
		#5clk1=1 ; #5clk1=0;   //2 phase clock 
		#5clk2=1 ; #5clk2=0;
	end
end

initial
begin
	for(k=0;k<=31;k=k+1)
	mips.Reg[k]=k;        //Load register file from values 0 to 31 for register R0 to R31 respectively.

	mips.Mem[0]=32'h2801000A;
	mips.Mem[1]=32'h28020014;
	mips.Mem[2]=32'h28030019;
	mips.Mem[3]=32'h0CE77800; //OR R7,R7,R7 --dummy instruction
	mips.Mem[4]=32'h0CE77800; //OR R7,R7,R7 --dummy instruction
	mips.Mem[5]=32'h00222000;
	mips.Mem[6]=32'h0CE77800; //OR R7,R7,R7 --dummy instruction
	mips.Mem[7]=32'h00832800;
	mips.Mem[8]=32'hFC000000;

	mips.HALTED=0;
	mips.TAKEN_BRANCH=0;
	mips.PC=0;

	#280;
	for(k=0;k<6;k=k+1)
	$display("R%1d - %2d",k , mips.Reg[k]);  //Print value of registers
end

initial
begin
	$dumpfile("mips32_1.vcd");
	$dumpvars(0,test1_mips32);
	#300 $finish;
end

endmodule
