`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2015 06:18:14 PM
// Design Name: 
// Module Name: i2c_tb
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


module i2c_tb(
    );
    
    wire SDA;
    reg reset, clk;
    wire [15:0] dout;
    wire SCL;
    
    I2C_Interface uut (
        .SCL(SCL),
        .reset(reset),
        .SDA(SDA),
        .dout(dout),
        .clk(clk)
    );
    
    always
    begin
        clk = 0;
        #50;
        clk = 1;
        #50;
    end
    
    initial begin
        reset = 1;
        #50;
        reset = 0;
        #1000;
    end
    
endmodule
