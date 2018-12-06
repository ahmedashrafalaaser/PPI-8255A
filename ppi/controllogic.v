
module controllogic(nCs,nRe,nWr,Reset,A,control);
	input nCs,nRe,nWr,Reset;
	input [1:0]A;
	output reg[5:0] control;
	


	always@(nCs,nRe,nWr,Reset,A)
		begin 
	 		control={nCs,nRe,nWr,Reset,A[1:0]};
		end
	


endmodule
