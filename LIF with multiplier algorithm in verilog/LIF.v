module LIF_mul(clk,rst,VOUT); // LIF with 32 bit array multiplier algorithm
  input clk,rst;
  output reg signed [31:0] VOUT;
  
 //initial codition
reg signed [31:0] v=32'h00000000;  //v=0;

//////LIF parameter//
reg signed [31:0] Vth=32'h0000fc93;//0.98
reg signed [31:0] cnt125=32'h00002000;//0.125
reg signed [31:0] cnt1=32'h00010000;//1
///////////////////////////////////
reg signed [31:0] a;                                                                 // adder output
reg signed [63:0] m;                                                                //  multiplier output

//clock
  parameter s0=8'h00;
  parameter s1=8'h01; 
  parameter s2=8'h02;
  parameter s3=8'h03;
  parameter s4=8'h04;
//////////////////////////////////

wire[7:0] p_s;
wire[63:0] mult_out;
reg [7:0] n_s;
    array_multiplier array_mult32 (a, cnt125, mult_out);
    assign   p_s=n_s;
    always @(posedge clk or negedge rst)
    begin
       if (!rst)
       n_s<=s0; 
       else if (clk)
      begin 
       case (p_s)
    ////////////////////////
    s0: begin

    a<=cnt1-v;
    n_s<=s1;
    end
    
    s1:begin
    
    m<=mult_out;
    n_s<=s2;
    end
    
    s2:begin 
    
     
    a<=v+{m[63],m[46:16]};
    n_s<=s3; 
    end
       
    s3:begin
   
    if (a>=Vth)
        begin
        v<=32'h00000000;
        VOUT<=32'h00000000;
      end
         else
         begin
         v<=a;
         VOUT<=a;
         end
    
 
   
    n_s<=s0;
    end
        
    endcase
    end
    end
    endmodule      
   
