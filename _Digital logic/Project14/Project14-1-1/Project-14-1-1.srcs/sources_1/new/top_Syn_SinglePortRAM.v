`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/01 23:23:18
// Design Name: 
// Module Name: top_Syn_SinglePortRAM
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


module top_Syn_SinglePortRAM#(parameter DATA_WIDTH = 4,parameter ADDR_DEPTH = 4)(
    input clk,rst,
    input [ADDR_DEPTH-1:0]addr,
    input [DATA_WIDTH-1:0]data_in,
    input we,oe,
    output wire[3:0]an,
    output wire[6:0]display
    );
    wire[DATA_WIDTH-1:0]data_out;
    wire clk_div;
    reg [25:0]target = 50000;
    wire [15:0]BCD;
    //divider
    divider d(.clk(clk),.rst(rst),.target(target),.clk_div(clk_div));
    //Syn_SinglePortRAM
    Syn_SinglePortRAM S(.clk(clk),.rst(rst),.addr(addr),.data_in(data_in),.we(we),.oe(oe),.data_out(data_out));
    //transformer
    transformer t(.data(data_out),.BCD(BCD));
    //display7seg
    display7seg dis(.clk(clk_div),.data3(BCD[15:12]),.data2(BCD[11:8]),.data1(BCD[7:4]),.data0(BCD[3:0]),.an(an),.display(display));
endmodule
