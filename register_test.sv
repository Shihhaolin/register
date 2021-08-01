`timescale 1ns/100ps

module register_test;

 localparam WIDTH=8;
 `define PERIOD 10ns/1ns
 
  logic  clk = 1'b1;

 always 
    #(`PERIOD/2) clk =~clk;

 logic [WIDTH-1:0] out;
 logic [WIDTH-1:0] data ;
 logic             enable;
 logic             rst_ ;   

 register UUT(.out(out), .data(data), .enable(enable), .rst_(rst_), .clk(clk));

 initial 
 begin
     $timeformat(-9,0,"ns");
     $monitor("%t data=%0h, enable=%0b, rst_=%0b, out=%0h",
      $time, data, enable, rst_, out);
 end



task  outexpect(input logic [WIDTH-1:0] expectvalue);
   if(out !== expectvalue)
   begin
   $display("COUNTER TEST FAILED");
   $display("expect=%0h, actual=%0h", expectvalue, out);
   $finish;
   end
endtask


initial begin
  @(negedge clk)//reset clock
  data='hX; enable=0; rst_=0;@(negedge clk) outexpect('h0);
  data='h1; enable=0; rst_=1;@(negedge clk) outexpect('h0);
  data='h1; enable=1; rst_=1;@(negedge clk) outexpect('h1);
  data='hA; enable=1; rst_=1;@(negedge clk) outexpect('hA);
  data='hC; enable=1; rst_=1;@(negedge clk) outexpect('hC);
  data='hD; enable=0; rst_=1;@(negedge clk) outexpect('hC);
  data='hD; enable=1; rst_=1;@(negedge clk) outexpect('hD);
  data='hF; enable=1; rst_=0;@(negedge clk) outexpect('h0);
$display("COUNTER TEST PASSED");
$finish;
end

endmodule