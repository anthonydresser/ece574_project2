// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (win64) Build 1368829 Mon Sep 28 20:06:43 MDT 2015
// Date        : Thu Nov 05 17:26:42 2015
// Host        : Windows running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/Anthony/Documents/ece574_project2/ip_repo/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_in1, clk_100M, clk_10M, reset, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clk_100M,clk_10M,reset,locked" */;
  input clk_in1;
  output clk_100M;
  output clk_10M;
  input reset;
  output locked;
endmodule
