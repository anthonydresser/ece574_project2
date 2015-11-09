// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (win64) Build 1368829 Mon Sep 28 20:06:43 MDT 2015
// Date        : Sun Nov 08 22:13:46 2015
// Host        : Windows running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/Anthony/Documents/ece574_project2/ip_repo/microblaze_mcs_0/microblaze_mcs_0_stub.v
// Design      : microblaze_mcs_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "microblaze_mcs,Vivado 2015.3" *)
module microblaze_mcs_0(Clk, Reset, UART_Rx, UART_Tx, UART_Interrupt, FIT1_Interrupt, FIT1_Toggle, GPO1, GPI1, GPI1_Interrupt, INTC_Interrupt, INTC_IRQ)
/* synthesis syn_black_box black_box_pad_pin="Clk,Reset,UART_Rx,UART_Tx,UART_Interrupt,FIT1_Interrupt,FIT1_Toggle,GPO1[7:0],GPI1[15:0],GPI1_Interrupt,INTC_Interrupt[0:0],INTC_IRQ" */;
  input Clk;
  input Reset;
  input UART_Rx;
  output UART_Tx;
  output UART_Interrupt;
  output FIT1_Interrupt;
  output FIT1_Toggle;
  output [7:0]GPO1;
  input [15:0]GPI1;
  output GPI1_Interrupt;
  input [0:0]INTC_Interrupt;
  output INTC_IRQ;
endmodule
