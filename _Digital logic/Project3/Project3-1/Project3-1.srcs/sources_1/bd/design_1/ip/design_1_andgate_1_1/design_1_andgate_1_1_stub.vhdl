-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sat Oct 23 11:17:29 2021
-- Host        : LAPTOP-2P04PJLI running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top design_1_andgate_1_1 -prefix
--               design_1_andgate_1_1_ design_1_andgate_0_0_stub.vhdl
-- Design      : design_1_andgate_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_andgate_1_1 is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 0 to 0 );
    b : in STD_LOGIC_VECTOR ( 0 to 0 );
    c : out STD_LOGIC_VECTOR ( 0 to 0 )
  );

end design_1_andgate_1_1;

architecture stub of design_1_andgate_1_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[0:0],b[0:0],c[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "andgate,Vivado 2018.3";
begin
end;
