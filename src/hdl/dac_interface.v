`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Anthony Dresser
// 
// Create Date:    22:57:55 02/02/2015 
// Design Name: 
// Module Name:    dacinterface 
// Project Name: 
// Target Devices: 
// Tool versions: 
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
	output dout,
	output reg sync
    );
    
    parameter [1:0] s0 = 0, s1 = 1;

	reg [15:0]shift;
	reg [4:0]cnt;
	reg [1:0] current_state, next_state;
	
	// state memory logic //
	always @(posedge clk, posedge reset)
	if(reset)
	   current_state <= s0;
    else
        current_state <= next_state;
        
    // next state logic //
    always @(current_state, cnt)
        case(current_state)
            s0:
                next_state <= s1;
            s1:
                if(cnt == 16)
                    next_state <= s0;
                else
                    next_state <= s1;
        endcase
        
    // state output //
    always @(posedge clk)
        case(current_state)
            s0: begin
                    sync <= 1;
                    shift <= load;
                end
            s1: begin
                    sync = 0;
                    shift <= {shift[14:0], 1'b0};
                end
        endcase
    
    assign dout = shift[15];
    
    // counter
	always @ (posedge clk)
	   if(!sync)
	       cnt <= cnt + 1;
       else
           cnt <= 0;
			
	
endmodule
