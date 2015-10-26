`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2015 04:41:31 PM
// Design Name: 
// Module Name: top_level
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_level(
    input   clk,
    input   reset,
    input   rx,
    inout   SDA,
    output SCL,
    output  tx,
    output locked,
    output sclk,
    output sync,
    output dout,
//    input [7:0] sw,
    output [7:0]    leds
    );
    
    wire clk_100M, clk_10M;
    wire [7:0] gpo;
    wire [15:0] temp_data;
    
    assign sclk = clk_10M;
    assign leds = gpo;
    
    microblaze_mcs_0 mcs_0 (
      .Clk(clk_100M), // input wire Clk
      .Reset(reset), // input wire Reset
      .UART_Rx(rx), // input wire UART_Rx
      .UART_Tx(tx), // output wire UART_Tx
      .GPO1(gpo), // output wire [7 : 0] GPO1
      .GPI1(temp_data), // input wire [15 : 0] GPI1
      .GPI1_Interrupt()  // output wire GPI1_Interrupt
    );
    
      clk_wiz_0 mmcm
     (
     // Clock in ports
      .clk_in1(clk),      // input clk_in1
      // Clock out ports
      .clk_100M(clk_100M),     // output clk_100M
      .clk_10M(clk_10M),     // output clk_10M
      // Status and control signals
      .reset(reset), // input reset
      .locked(locked));      // output locked
      
      dac_interface dac
      (
        .clk(clk_10M),
        .reset(reset),
        .load({8'b0, gpo}),
        .sync(sync),
        .dout(dout));
        
      I2C_Interface i2c
      (
        .SCL(SCL),
        .SDA(SDA),
        .reset(reset),
        .dout(temp_data),
        .clk(clk_10M));
    
endmodule
