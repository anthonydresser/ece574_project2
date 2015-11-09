-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.3 (win64) Build 1368829 Mon Sep 28 20:06:43 MDT 2015
-- Date        : Sun Nov 08 22:13:46 2015
-- Host        : Windows running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/Anthony/Documents/ece574_project2/ip_repo/microblaze_mcs_0/microblaze_mcs_0_stub.vhdl
-- Design      : microblaze_mcs_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity microblaze_mcs_0 is
  Port ( 
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    UART_Rx : in STD_LOGIC;
    UART_Tx : out STD_LOGIC;
    UART_Interrupt : out STD_LOGIC;
    FIT1_Interrupt : out STD_LOGIC;
    FIT1_Toggle : out STD_LOGIC;
    GPO1 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    GPI1 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    GPI1_Interrupt : out STD_LOGIC;
    INTC_Interrupt : in STD_LOGIC_VECTOR ( 0 to 0 );
    INTC_IRQ : out STD_LOGIC
  );

end microblaze_mcs_0;

architecture stub of microblaze_mcs_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "Clk,Reset,UART_Rx,UART_Tx,UART_Interrupt,FIT1_Interrupt,FIT1_Toggle,GPO1[7:0],GPI1[15:0],GPI1_Interrupt,INTC_Interrupt[0:0],INTC_IRQ";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "microblaze_mcs,Vivado 2015.3";
begin
end;
