module databusbuffer(PortD,control,controlword);
 	
	inout [7:0] PortD;
	output reg[7:0] controlword;


	
	input [5:0]control;
	
	/*
	wire nCs,nRe,nWr,Reset;
	wire [1:0]A;
	assign nCs=control[5];
	assign nRe=control[4];
	assign nWr=control[3];
	assign Reset=control[2];
	assign A={control[1:0]};*/

	initial 
begin 
if(control==6'b010011)
controlword<=PortD;
end 
	





endmodule 