`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Anthony Dresser Mailbox # 87
// 
// Create Date: 10/19/2015 08:15:48 PM
// Design Name: 
// Module Name: I2C_Interface
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: I2C interface to interface with the temperature sensor on the Nexys4DDR
// board. Refer to datasheet for I2C interface details.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module I2C_Interface(
    output SCL,
    input reset,
    inout SDA,
    output reg [15:0] dout,
    input clk
    );
    
    parameter [3:0] s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011, s4 = 4'b0100, s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111, s8 = 4'b1000, s9 = 4'b1001;
    parameter [7:0] deviceAddr = 8'b10010111, MSBADDR = 8'b00000000;
    
    reg [3:0] current_state, next_state;
    reg [15:0] doutreg;
    reg [7:0] addrShift;
    reg [7:0] count;
    reg startCount, addrShiftStart, dataShiftStart;
    reg SDA_reg;
    reg OE, CE;
    
    wire clk_200K;
    
    //state memory
    always @(negedge clk_200K, posedge reset)
        if(reset)
            current_state <= s0;
        else
            current_state <= next_state;
    
    //next_state logic
    always @(current_state, count)
        case(current_state)
            s0: next_state = s1;
            s1: next_state = s2;
            s2: if(count == 7)
                    next_state = s3;
                else
                    next_state = s2;
            s3: next_state = s4;
            s4: if(count == 7)
                    next_state = s5;
                else
                    next_state = s4;
            s5: next_state = s6;
            s6: if(count == 7)
                    next_state = s7;
                else
                    next_state = s6;
            s7: next_state = s0;
            default: next_state = s0;
        endcase
    
    always @(current_state, addrShift[7])
        case(current_state)
            // Pull SDA High for start of transmission
            s0: begin
                    CE = 0;
                    OE = 1;
                    SDA_reg = 1;
                    startCount = 0;
                    addrShiftStart = 0;
                    dataShiftStart = 0;
                end
            // Pull SDA Low for start of transmission
            s1: begin
                    addrShiftStart = 0;
                    dataShiftStart = 0;
                    CE = 0;
                    OE = 1;
                    SDA_reg = 0;
                    startCount = 0;
                end
            // shift device address
            s2: begin
                    addrShiftStart = 1;
                    dataShiftStart = 0;
                    SDA_reg = addrShift[7];
                    CE = 1;
                    OE = 1;
                    startCount = 1;
                end
            // ack from device
            s3: begin
                    addrShiftStart = 0;
                    dataShiftStart = 0;
                    SDA_reg = 0;
                    CE = 1;
                    OE = 0;
                    startCount <= 0;
                end
            // shift in MSB data from temp sensor
            s4: begin
                    addrShiftStart = 0;
                    dataShiftStart = 1;
                    SDA_reg = 0;
                    CE = 1;
                    OE = 0;
                    startCount = 1;
                end
            // ack
            s5: begin
                   addrShiftStart = 0;
                   dataShiftStart = 0;
                   CE = 1;
                   OE = 1;
                   SDA_reg = 0;
                   startCount = 0;
               end
           // shift in LSB data from temp sensor
           s6: begin
                   addrShiftStart = 0;
                   dataShiftStart = 1;
                   SDA_reg = 0;
                   CE = 1;
                   OE = 0;
                   startCount = 1;
               end
           // no ack
           s7: begin
                   addrShiftStart = 0;
                   dataShiftStart = 0;
                   OE = 1;
                   CE = 1;
                   SDA_reg = 1;
                   startCount = 0;
               end
           // default: should never get here
           default: begin
                       addrShiftStart = 0;
                       dataShiftStart = 0;
                       OE = 1;
                       CE = 1;
                       SDA_reg = 1;
                       startCount = 0;
                   end
        endcase
        
    assign SDA = (OE == 1) ? SDA_reg : 1'bz;
    
    assign SCL = (CE == 1) ? clk_200K : 1'b1;
    
    always @(posedge clk_200K)
        if(current_state == s7)
            dout <= doutreg;
    
    // shift addr register
    always@(negedge clk_200K)
        if(addrShiftStart == 1)
            addrShift <= {addrShift[6:0], addrShift[7]};
        else
            addrShift <= deviceAddr;
    
   // shift in data
    always@(negedge clk_200K)
        if(dataShiftStart == 1)
            doutreg <= {doutreg[14:0], SDA};
        
    // counter
    always @(negedge clk_200K)
        if(startCount == 1)
            count <= count + 1;
        else
            count <= 0;
            
      clkdiv #(.div_val(50)) clk_div200K
      (
        .clk_in(clk),
        .reset(reset),
        .clk_out(clk_200K)
      );
    
endmodule
