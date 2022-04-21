//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Sat Oct 23 10:53:12 2021
//Host        : LAPTOP-2P04PJLI running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (S1,
    S2,
    a,
    b,
    c,
    d,
    e);
  input S1;
  input S2;
  input a;
  input b;
  input c;
  input d;
  output [0:0]e;

  wire S1;
  wire S2;
  wire a;
  wire b;
  wire c;
  wire d;
  wire [0:0]e;

  design_1 design_1_i
       (.S1(S1),
        .S2(S2),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e));
endmodule
