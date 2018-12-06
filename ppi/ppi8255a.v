`include "includes.v"

module PPI8255A(PortA,PortB,PortD,PortCl,PortCu,nCs,nRe,nWr,Reset,A);
inout [7:0] PortA,PortB,PortD;
inout[3:0] PortCl,PortCu;
input nCs,nRe,nWr,Reset;
input [1:0]A;


//bettween input and control
wire [5:0]control; 
controllogic T(nCs,nRe,nWr,Reset,A,control);
//////////////////////////////////////////
// bettween portd and conterol word and internaldatabus
wire [7:0]controlword;
databusbuffer l(PortD,control,controlword);


/////////////////////////////
porta k(PortA,PortD,control,controlword);
portb m(PortB,PortD,control,controlword);
portcl n(PortCl,PortD,control,controlword);
portcu o(PortCu,PortD,control,controlword);





endmodule 
module test bench ();
  PPI8255A test(PortA,PortB,PortD,PortCl,PortCu,nCs,nRe,nWr,Reset,A);
  wire [7:0] PortA , portB , PortD ;
  wire [3:0] PortCl , PortCU ;
  reg nCs, nRe , nWr , reset ;
  reg [1:0] A,
  //test case 1
  initial 
    begin
      nCs =0;
      reset = 0 ;
      nWr = 0;
      nRe = 1 ; 
      A = 2'b11 ;
      PortD =8'b10000011;
      #300
      
      PortD =8'b10000001;
      #300
      
      PortD =8'b10010000;
      #300
      
      PortD =8'b10001001;
      #300
      
      PortD =8'b10010010;
      #300
      
      PortD =8'b10010011;
      #300
      
      PortD =8'b10011000;
      #300
      
      PortD =8'b10011011;
      #300
      
      PortD =8'b10000011;
      #300
      
      PortD =8'b10000011;
      #300
    end
  initial 
    
     nCs =0;
      reset = 0 ;
      nWr = 0;
      nRe = 1 ; 
      A = 2'b11 ;
  // test case 2
  
  // test case 3 
  
