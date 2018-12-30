module test2_mips32;
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

	mips.Mem[0]=32'h00222000;
	
	mips.HALTED=0;
	mips.TAKEN_BRANCH=0;
	mips.PC=0;

	#280;
	for(k=0;k<6;k=k+1)
	$display("R%1d - %2d",k , mips.Reg[k]);  //Print value of registers
end

initial
begin
	$dumpfile("mips32_2.vcd");
	$dumpvars(0,test2_mips32);
	#300 $finish;
end

endmodule
