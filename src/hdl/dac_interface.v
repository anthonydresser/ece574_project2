`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Anthony Dresser Mailbox # 87
// 
// Create Date: 10/19/2015 04:41:31 PM
// Design Name: 
// Module Name:    dacinterface 
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: The logic for interfacing with the DAC, includes a clk which is
// powering both the shift and the counters, which provide different frequencies.
// Reset resets all the counters. Load is the value that the Shift register is 
// loaded with. dout is the value to be pushed to the DAC at any given clk edge. 
// Sync is the sync for the DAC.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dac_interface(
	input clk,
	input reset,
	input [15:0] load,
	output reg dout,
	output reg sync
    );
    
    parameter [1:0] s0 = 1'b0, s1 = 1'b1;

	reg [15:0]shift;
	reg [4:0]cnt;
	reg current_state, next_state, shiftStart;
	
	// state memory logic //
	always @(negedge clk, posedge reset)
        if(reset)
           current_state <= s0;
        else
            current_state <= next_state;
        
    // next state logic //
    always @(current_state, cnt)
        case(current_state)
            s0: next_state <= s1;
            s1: if(cnt == 16)
                    next_state <= s0;
                else
                    next_state <= s1;
        endcase
        
    // state output //
    always @(current_state, shift[15])
        case(current_state)
            s0: begin
                    sync = 1;
                    shiftStart = 0;
                    dout = 0;
                end
            s1: begin
                    sync = 0;
                    shiftStart = 1;
                    dout = shift[15];
                end
        endcase
    
    always @(negedge clk)
        if(shiftStart == 1)
            shift <= {shift[14:0], 1'b0};
        else
            shift <= load;
    
    // counter
	always @ (negedge clk)
	   if(sync == 0)
	       cnt <= cnt + 1;
       else
           cnt <= 0;
			
endmodule
