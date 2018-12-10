`include "ppi8255a.v"
`timescale 1 ns / 1 ps
module test_bench () ;

  wire [7:0] PortA , PortB , PortD ;
  wire [3:0] PortCl , PortCu;
  reg nCs, nRe , nWr , Reset ;
  reg [1:0] A;
  //set ports 
  reg [7:0] Porta , Portb , Portd ;
  reg [3:0] Portcl , Portcu ;
  assign PortA=Porta;
  assign PortB=Portb;
  assign PortD=(nRe)?Portd:8'hzz;
  assign PortCl=Portcl;
  assign PortCu=Portcu;												 
  ////
  //set  control words 
  initial 
    begin
      nCs <=0;
      Reset <= 0 ;
      nWr <= 0;
      nRe <= 1 ; 
      A <= 2'b11 ;
      Portd <=8'b10001011;   //from 0 to 30	   pa output
      #30
      nRe <= 1 ; nWr=0;
      A <= 2'b11 ;
      Portd <=8'b10011010;  // from 30 t60   pcl output
      #30
      nRe <= 1 ; nWr=0;
      A <= 2'b11 ;
      Portd <=8'b10001001;//60=>90	 pb&Pcu output
      #30
      nRe <= 1 ; 	   nWr=0;
      A <= 2'b11 ;
      Portd <=8'b10000000;//90=>120  all output
      #30				  
      nRe <= 1 ; 			 nWr=0;
      A <= 2'b11 ;
      Portd <=8'b0001_0100;// BSR  	  2=>rest
      #10								  
	  nRe <= 1 ; 	nWr=0;		 			 
      A = 2'b11 ;						  
      Portd <=8'b0001_1010;// BSR  	 5=>rest
      #10							   	  
	  nRe <= 1 ; 	nWr=0;		 			  
      A <= 2'b11 ;						  
      Portd <=8'b0001_0111;// BSR  	 3=>set
      #10								 
	  nRe <= 1 ; 	nWr=0;		 			  
      A <= 2'b11 ;						  
      Portd <=8'b0001_0101;// BSR  	2=>set
      								    									
    end						   
  initial 
 	begin 
     ///  30 t   port a is output and other input
	 Porta<=8'hzz;
	 #8	 
	 nRe<=1 ; nWr<=0; A<=2'b00;
	 #1							 //  @ 9    porta =F8
	    Portb<=8'h32; Portcl<=4'ha;Portcu<=4'hf;Portd<=8'hf8; 
			//                    
  	 #7							//   @ 16    nochange wil happen to next inputs
	   nRe<=0 ; nWr<=1; A<=2'b00;
	   #1
	    Portb<=8'h32; Portcl<=4'ha;Portcu<=4'hf;Portd<=8'h28; 
	    //                     
	  #6						//		@23          portd =fa 
	  nRe<=0 ; nWr<=1; A<=2'b10;
	  #1
	    Portb<=8'h32; Portcl<=4'ha;Portcu<=4'hf;Portd<=8'h28; 
	   //                    
	 #6										   /////end 30
	 ////////////for 30 portcl output  other input 
	Portcl<=4'hz;
	#1	 	//  					  31
	nRe<=1 ; nWr<=0; A<=2'b10;
	#1									 //@ 32        portcl =5
	   Porta<=8'h85; Portb<=8'hf2; Portcu<=4'hb;Portd<=8'h15; 
	 				//       
  	 #8			//40
	   nRe<=0 ; nWr<=1; A<=2'b00;
	   #1			//                        @41 portd=85
	   Porta<=8'h85; Portb<=8'h62; Portcu<=4'h2;Portd<=8'h54; 
	    //  
	  #8				   //49
	  nRe<=0 ; nWr<=1; A<=2'b10;
	  #1				  //                  @50     portd =fz
	   Porta<=8'h55; Portb<=8'h32; Portcu<=4'hf;Portd<=8'h28; 
	   // 	 
	 #10						/////60 ends
	 ///////////////// for 30t Portcu&pb output	other input	
		 Portcu<=4'hz;Portb<=8'hzz;
		 #1				  //61
		 nRe<=1 ; nWr<=0; A<=2'b01;
		 #1					 //       @62     portb =28
	   Porta<=8'h55;  Portcl<=4'ha;Portd<=8'h28; 
	 				//
  	 #8	  			//70
	   nRe<=1 ; nWr<=0; A<=2'b10;
	   #1			//             @71    Pcu=2
	   Porta<=8'h56; Portcl<=4'ha;Portd<=8'h23; 
	    //  
	  #8		   //79
	  nRe<=0 ; nWr<=1; A<=2'b10;
	  #1		   //           @80     portd =z9
	   Porta<=8'h65;  Portcl<=4'h9;Portd<=8'h66; 
	   // 
	 #10					/// end 90
	 //////////////all output 
	 Porta=8'hzz;Portcl=4'hz;
	 #1						  //91
	 nRe<=1 ; nWr<=0; A<=2'b01;	
	 #1					   // @92    porta =a1 
	 Portd<=8'ha1; 
	 			//
  	 #8			   //100
	   nRe<=0 ; nWr<=1; A<=2'b01;
	   #1		   //101
	   Portd<=8'h12; 
	    //nochange wil happen to inputs 
	  #8				//109
	  nRe<=0 ; nWr<=0; A<=2'b10;
	  #1			   //110
	   Portd<=8'h10; 
	   //ochange all zzzz cannot expect 
	 #9					  //119
	 ///////////		  BSR
	 #2	  //121
	 nRe<=1 ; nWr<=0; A<=2'b01;
	 #1	//122
	   Porta<=8'h55; Portb<=8'h32; Portd<=8'h28; 
	  #8 //130
	 #1	  //131
	  nRe<=1 ; nWr<=0; A<=2'b00;// 				 
  	 #1	 				 // 132
	   Porta<=8'h55; Portb<=8'h32; Portd<=8'h28; 
	  #8//140
	 #1	 //141
	  nRe<=1 ; nWr<=0; A<=2'b10;//  				
	  #1//142	 			
	   Porta<=8'h55; Portb<=8'h32; Portd<=8'h28; 
	   #8//150
	 #1	 //151
	  nRe<=1 ; nWr<=0; A<=2'b10;//			  
	 #1			   //152
	   Porta<=8'h55; Portb<=8'h32; Portd<=8'h28; 
	 
	
	  
end

PPI8255A test(PortA,PortB,PortD,PortCl,PortCu,nCs,nRe,nWr,Reset,A);
initial
	$monitor($time,  , "   %h  %h   %h  %h  %h  %h  %h  %h  %h  %h   ",PortA,PortB,PortD,PortCl,PortCu,nCs,nRe,nWr,Reset,A);  
																   												   									 
endmodule 