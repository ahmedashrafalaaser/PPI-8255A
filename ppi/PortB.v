
module portb(PB,PD,control,controlword);
	inout [7:0]PB,PD;
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
	reg [7:0]PBin;
	reg [7:0]PBout;
	assign  PB=(control==6'b010001&&controlword[7]==1&&controlword[2:1]==2'b00)?PBout:8'hzz;
	assign PD=(control==6'b001001&&controlword[7]==1&&controlword[2:1]==2'b01)?PBin:8'hzz;
	
always@(PD)
begin 		
PBout<=PD;
PBin<=PB;
end
	

endmodule 
