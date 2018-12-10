


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




	reg [3:0]PClin;
	reg [3:0]PClout;
													    										  
	
	assign PCl=(controlword[7]==0||control==6'b010010&&controlword[7]==1&&controlword[0]==0 &&controlword[2]==0 )?PClout  :4'hz;	 
	assign PD[3:0]=(control==6'b001010&&controlword[7]==1&&controlword[0]==1 &&controlword[2]==0)?PClin:4'hz;
	
always@(PD,controlword,PCl)
begin 
	PClin<=PCl;   
	
PClout<={PD[3:0]};
 if (controlword[7]==0&&control[2]==0)
begin  	 
	
	selectedport={controlword[3:1]};	//for BSR mode 
if(selectedport<4)
 PClout[selectedport] <= controlword[0]; //set or no the selected pin
end
end																	   
endmodule  