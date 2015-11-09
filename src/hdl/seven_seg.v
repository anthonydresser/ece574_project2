`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2015 02:00:10 PM
// Design Name: 
// Module Name: seven_seg
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


module seven_seg(
    input[31:0] data,
    input clk,
    input rs,
    output reg [7:0] an,
    output reg [6:0] seg
    );
    
    parameter [2:0] s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100, s5 = 3'b101, s6 = 3'b110, s7 = 3'b111;
    
    reg [2:0] next_state, current_state;
    wire clk_1K;
    wire [55:0] din_dec;
    
    always @(posedge clk_1K, posedge rs)
    begin
        if(rs)
            current_state <= s0;
        else
            current_state <= next_state;
    end
    
    always @(current_state)
    begin
        case(current_state)
            s0: next_state = s1;
            s1: next_state = s2;
            s2: next_state = s3;
            s3: next_state = s4;
            s4: next_state = s5;
            s5: next_state = s6;
            s6: next_state = s7;
            s7: next_state = s0;
        endcase
    end
    
    always @(posedge clk_1K)
    begin
        case(current_state)
            s0: begin
                an <= 8'b11111110;
                seg <= din_dec[6:0];
                end
            s1: begin
                an <= 8'b11111101;
                seg <= din_dec[13:7];
                end
            s2: begin
                an <= 8'b11111011;
                seg <= din_dec[20:14];
                end
            s3: begin
                an <= 8'b11110111;
                seg <= din_dec[27:21];
                end
            s4: begin
                an <= 8'b11101111;
                seg <= din_dec[34:28];
                end
            s5: begin
                an <= 8'b11011111;
                seg <= din_dec[41:35];
                end
            s6: begin
                an <= 8'b10111111;
                seg <= din_dec[48:42];
                end
            s7: begin
                an <= 8'b01111111;
                seg <= din_dec[55:49];
                end
        endcase
    end
    
    clkdiv #(.div_val(1000)) clk_div1K
    (
        .clk_in(clk),
        .reset(rs),
        .clk_out(clk_1K)
    );
    
    genvar i;
    
    generate
        for (i=0; i < 8; i=i+1) begin: decode
            decoder u (.in(data[(i*4)+3 : (i*4)]), .out(din_dec[(i*7)+6 : (i*7)]));
        end
    endgenerate
    
endmodule
