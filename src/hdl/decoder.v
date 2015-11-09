`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Anthony Dresser Mailbox # 87
// 
// Create Date: 10/30/2015 01:58:58 PM
// Design Name: 
// Module Name: decoder
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


module decoder(
    input[3:0] in,
    output reg [6:0] out
    );
    
    parameter [6:0] zero_char = 7'b0000001,
                    one_char = 7'b1001111,
                    two_char = 7'b0010010,
                    three_char = 7'b0000110,
                    four_char = 7'b1001100,
                    five_char = 7'b0100100,
                    six_char = 7'b0100000,
                    seven_char = 7'b0001111,
                    eight_char = 7'b0000000,
                    nine_char = 7'b0000100,
                    a_char = 7'b0001000,
                    b_char = 7'b1100000,
                    c_char = 7'b0110001,
                    d_char = 7'b1000010,
                    e_char = 7'b0110000,
                    f_char = 7'b0111000;
    
    always @(in)
    begin
        case(in)
            0: out = zero_char;
            1: out = one_char;
            2: out = two_char;
            3: out = three_char;
            4: out = four_char;
            5: out = five_char;
            6: out = six_char;
            7: out = seven_char;
            8: out = eight_char;
            9: out = nine_char;
            10: out = a_char;
            11: out = b_char;
            12: out = c_char;
            13: out = d_char;
            14: out = e_char;
            15: out = f_char;
        endcase
    end
endmodule
