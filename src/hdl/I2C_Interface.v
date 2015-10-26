`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2015 08:15:48 PM
// Design Name: 
// Module Name: I2C_Interface
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


module I2C_Interface(
    output SCL,
    input reset,
    inout SDA,
    output reg [15:0] dout,
    input clk
    );
    
    parameter [2:0] s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100, s5 = 3'b101, s6 = 3'b110;
    parameter [6:0] MSBADDR = 7'b1010001, LSBADDR = 7'b1010011;
    
    reg [2:0] current_state, next_state;
    reg [7:0] MSB, LSB;
    reg [6:0] addrShift;
    reg [7:0] count;
    reg startCount;
    reg SDA_reg;
    reg OE;
    
    wire clk_200K;
    
    assign SCL = clk_200K;
    
    //state memory
    always @(posedge clk_200K, posedge reset)
        if(reset)
            current_state <= s0;
        else
            current_state <= next_state;
    
    //next_state logic
    always @(current_state, count)
        case(current_state)
            s0:
                next_state <= s1;
            s1:
                next_state <= s2;
            s2:
                if(count == 8)
                    next_state <= s3;
                else
                    next_state <= s2;
            s3:
                next_state <= s4;
            s4:
                if(count == 7)
                    next_state <= s5;
                else
                    next_state <= s4;
            s5:
                next_state <= s6;
            s6:
                if(count == 8)
                    next_state <= s6;
                else
                    next_state <= s0;
        endcase
    
    //state_output logic
    always @(posedge clk_200K)
        case(current_state)
            // start a transaction
            s0: begin
                    OE <= 1'b1;
                    SDA_reg <= 1'b1;
                    startCount <= 1'b0;
                    addrShift <= MSBADDR;
                    dout <= {MSB, LSB};
                end
            // pull SDA low
            s1: begin
                    OE <= 1'b1;
                    SDA_reg <= 1'b0;
                    startCount <= 1'b0;
                    addrShift <= MSBADDR;
                end
            //shift address
            s2: begin
                    OE <= 1'b1;
                    startCount <= 1'b1;
                    SDA_reg <= addrShift[6];
                    addrShift <= {addrShift[5:0], addrShift[6]};
                end
            //reset counter before reading
            s3: begin
                    OE <= 1'b0;
                    startCount <= 1'b0;
                    addrShift <= MSBADDR;
                end
            // read MSB
            s4: begin
                    OE <= 1'b0;
                    startCount <= 1'b1;
                    MSB <= {MSB[7:1], SDA};
                    addrShift <= MSBADDR;
                end
            // reset before LSB
            s5: begin
                    OE <= 1'b0;
                    startCount <= 1'b0;
                    addrShift <= MSBADDR;
                end
            // read LSB
            s6: begin
                    OE <= 1'b0;
                    startCount <= 1'b1;
                    LSB <= {LSB[7:1], SDA};
                    addrShift <= MSBADDR;
                end
        endcase
        
    assign SDA = (OE == 1) ? SDA_reg : 1'bz;
        
    // counter
    always @(posedge clk_200K)
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
