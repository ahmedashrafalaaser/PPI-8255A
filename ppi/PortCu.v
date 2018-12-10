


module portcu(PCu,PD,control,controlword);
	inout [7:0]PD;
	inout[3:0]PCu;
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
	
	
	reg [3:0]PCuin;
	reg [3:0]PCuout;
	 
	assign PCu=(controlword[7]==0||control==6'b010010&&controlword[7:5]==3'b100&&controlword[3]==1)?PCuout  :4'hz;

	assign PD[7:4]=(control[5:0]==6'b001010&&controlword[7:5]==3'b100&&controlword[3]==1)?PCuin:4'hz;
	
always@(PD,controlword,PCu)
begin 
	  PCuin<=PCu;

PCuout<={PD[7:4]};

if (controlword[7]==0&&control[2]==0)
begin 	
	
	selectedport={controlword[3:1]};
if(selectedport>4)
 PCuout[selectedport-4] <=controlword[0]; //set or no the selected pin


end
end
	

endmodule 