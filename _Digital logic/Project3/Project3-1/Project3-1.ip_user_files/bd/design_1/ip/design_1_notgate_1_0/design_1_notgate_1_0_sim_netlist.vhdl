-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sat Oct 23 11:17:29 2021
-- Host        : LAPTOP-2P04PJLI running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/CODES/vivado/Project3-1/Project3-1.srcs/sources_1/bd/design_1/ip/design_1_notgate_1_0/design_1_notgate_1_0_sim_netlist.vhdl
-- Design      : design_1_notgate_1_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_notgate_1_0 is
  port (
    a : in STD_LOGIC_VECTOR ( 0 to 0 );
    b : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_notgate_1_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_notgate_1_0 : entity is "design_1_notgate_1_0,notgate,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_notgate_1_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_notgate_1_0 : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_notgate_1_0 : entity is "notgate,Vivado 2018.3";
end design_1_notgate_1_0;

architecture STRUCTURE of design_1_notgate_1_0 is
begin
\b[0]_INST_0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => a(0),
      O => b(0)
    );
end STRUCTURE;
