


module portcl(PCl,PD,control,controlword);
	inout [7:0]PD;
	inout[3:0]PCl;
	input[7:0] controlword;
	input [5:0]control;
	
	
	/*
	wire nCs,nRe,nWr,Reset;
	wire [1:0]A;
	assign nCs=control[5];
	assign nRe=control[4];
	assign nWr=control[3];
	assign Reset=control[2];
	assign A={control[1:0]};*/

	///////////////////
	reg [2:0]selectedport;

	/////




	wire [3:0]PClin;
	reg [3:0]PClout;
													    										  
	
	assign PCl=(controlword[7]==0||control==6'b010010&&controlword==8'b1xxxx0x0)?PClout  :4'hz;	
	assign  PClin=PCl;
	assign PD=(control==6'b001010&&controlword==8'b1xxxx0x1)?{(4'hz),PClin}:8'hzz;
	
always@(PD,controlword)
begin 
	   
	if(controlword[7]==1)
		begin
PClout<={PD[3:0]};
end
else if (controlword[7]==0&&control[2]==0)
begin  
	selectedport={controlword[3:1]};	//for BSR mode 
if(selectedport<4)
 PClout[selectedport] <= controlword[0]; //set or no the selected pin
end
end
endmodule  