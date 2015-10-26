`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: WPI
// Engineer: Anthony Dresser Mailbox # 87
//
// Create Date:    14:39:55 02/24/2015
// Design Name:
// Module Name:    clkdiv
// Project Name:
// Target Devices:
// Tool versions:
// Description: Creates a clk divider based on the given div_val which is default
// to 1. Automatically determines the size of the counter based on the div_val
// provided.
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module clkdiv #(parameter div_val = 1)(
  input clk_in,
  input reset,
  output reg clk_out
  );

  parameter width = $clog2(div_val);
  parameter half = div_val/2;

  reg [width-1:0] counter;

  always @ (posedge clk_in, posedge reset)
    if(reset)
      counter <= 0;
    else
      if(counter == div_val - 1)
      begin
          counter <= 0;
          clk_out <= 1;
      end
      else if(counter < half)
      begin
          clk_out <= 0;
          counter <= counter + 1'b1;
      end
      else
      begin
        clk_out <= 1;
        counter <= counter + 1'b1;
      end

  endmodule
