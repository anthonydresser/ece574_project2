`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Anthony Dresser Mailbox # 87
// 
// Create Date: 10/19/2015 04:41:31 PM
// Design Name: 
// Module Name: top_level
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Top level module for 
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
    output  SCL,
    output  tx,
    output  locked,
    output  sclk,
    output  sync_out,
    output  dacout
//    input [7:0] sw,
//    output [14:0]    leds,
//    output [7:0] an,
//    output [6:0] seg
    );
    
    wire clk_100M, clk_10M;
    wire [7:0] gpo;
    wire [15:0] temp_data;
    wire sync;
    
    assign sync_out = sync;
    assign sclk = clk_10M;
//    assign leds[12:0] = temp_data[12:0];
//    assign leds[14:13] = {TMP_INT, TMP_CT};
    
    microblaze_mcs_0 mcs_0 (
      .Clk(clk_100M),                        // input wire Clk
      .Reset(reset),                    // input wire Reset
      .UART_Rx(rx),                // input wire UART_Rx
      .UART_Tx(tx),                // output wire UART_Tx
      .UART_Interrupt(),  // output wire UART_Interrupt
      .FIT1_Interrupt(),  // output wire FIT1_Interrupt
      .FIT1_Toggle(),        // output wire FIT1_Toggle
      .GPO1(gpo),                      // output wire [7 : 0] GPO1
      .GPI1(temp_data),                      // input wire [15 : 0] GPI1
      .GPI1_Interrupt(),  // output wire GPI1_Interrupt
      .INTC_Interrupt(sync),  // input wire [0 : 0] INTC_Interrupt
      .INTC_IRQ()              // output wire INTC_IRQ
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
        .dout(dacout));
        
      I2C_Interface i2c
      (
        .SCL(SCL),
        .SDA(SDA),
        .reset(reset),
        .dout(temp_data),
        .clk(clk_10M));
        
//    seven_seg display
//    (
//        .clk(clk_10M),
//        .data({16'b0, temp_data}),
//        .rs(reset),
//        .an(an),
//        .seg(seg));
    
endmodule
