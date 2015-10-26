// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (win64) Build 1368829 Mon Sep 28 20:06:43 MDT 2015
// Date        : Mon Oct 26 16:05:47 2015
// Host        : AK113-13 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub {c:/Users/addresser/Documents/Project
//               2/ip_repo/microblaze_mcs_0/microblaze_mcs_0_stub.v}
// Design      : microblaze_mcs_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "microblaze_mcs,Vivado 2015.3" *)
module microblaze_mcs_0(Clk, Reset, UART_Rx, UART_Tx, GPO1, GPI1, GPI1_Interrupt)
/* synthesis syn_black_box black_box_pad_pin="Clk,Reset,UART_Rx,UART_Tx,GPO1[7:0],GPI1[7:0],GPI1_Interrupt" */;
  input Clk;
  input Reset;
  input UART_Rx;
  output UART_Tx;
  output [7:0]GPO1;
  input [7:0]GPI1;
  output GPI1_Interrupt;
endmodule
