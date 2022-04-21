`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/12/02 08:45:46
// Design Name:
// Module Name: top_Syn_DoublePortRAM
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module top_Syn_DoublePortRAM#(parameter DATA_WIDTH = 4,
                              parameter ADDR_DEPTH = 3)
                            (input clk,
                              rst,
                              input [ADDR_DEPTH-1:0]addr_a,
                              addr_b,
                              input [DATA_WIDTH-1:0]din_a,
                              din_b,
                              input we_a,
                              we_b,
                              input oe_a,
                              oe_b,
                              output wire[3:0]an,
                              output wire[6:0]display,
                              output wire error);
    wire[DATA_WIDTH-1:0]dout_a,dout_b;
    wire clk_div;
    reg [25:0]target = 50000;
    wire [15:0]BCD_a;
    wire [15:0]BCD_b;
    //divider
    divider d(.clk(clk),.rst(rst),.target(target),.clk_div(clk_div));
    //Syn_DoublePortRAM
    Syn_DoublePortRAM S(.clk(clk),.rst(rst),.addr_a(addr_a),.addr_b(addr_b),.din_a(din_a),.din_b(din_b),.we_a(we_a),.we_b(we_b),.oe_a(oe_a),.oe_b(oe_b),.dout_a(dout_a),.dout_b(dout_b),.error(error));
    //transformer
    transformer t_a(.data(dout_a),.BCD(BCD_a));
    transformer t_b(.data(dout_b),.BCD(BCD_b));
    //display7seg
    display7seg dis(.clk(clk_div),.data3(BCD_a[7:4]),.data2(BCD_a[3:0]),.data1(BCD_b[7:4]),.data0(BCD_b[3:0]),.an(an),.display(display));
endmodule
