`timescale 1ns/100ps

module register (
                output logic [7:0] out,
                input  logic [7:0] data ,
                input  logic       clk  ,
                input  logic       enable  ,
                input  logic       rst_
                );
                
always_ff @(posedge clk, negedge rst_)
    if (!rst_)
      out <= 0;
    else if (enable)
      out <= data;

endmodule
