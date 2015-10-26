// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
// Date        : Mon Oct 26 19:15:26 2015
// Host        : anthony-VirtualBox running 64-bit Ubuntu 14.04.3 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/anthony/Documents/ece574_project2/ip_repo/microblaze_mcs_0/microblaze_mcs_0_stub.v
// Design      : microblaze_mcs_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "microblaze_mcs,Vivado 2015.3" *)
module microblaze_mcs_0(Clk, Reset, UART_Rx, UART_Tx, GPO1, GPI1, GPI1_Interrupt)
/* synthesis syn_black_box black_box_pad_pin="Clk,Reset,UART_Rx,UART_Tx,GPO1[7:0],GPI1[15:0],GPI1_Interrupt" */;
  input Clk;
  input Reset;
  input UART_Rx;
  output UART_Tx;
  output [7:0]GPO1;
  input [15:0]GPI1;
  output GPI1_Interrupt;
endmodule
