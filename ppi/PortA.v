

module porta(PA,PD,control,controlword);
	inout [7:0]PA,PD;
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
	reg [7:0]PAin;
	reg [7:0]PAout;
	assign  PA=(control==6'b010000&&controlword[7:4]==4'b1000)?PAout:8'hzz;
	assign PD=(control==6'b001000&&controlword[7:4]==4'b1001)?PAin:8'hzz;
	
always@(PD)
begin 		
PAout<=PD;
PAin<=PA;
end
	

endmodule 