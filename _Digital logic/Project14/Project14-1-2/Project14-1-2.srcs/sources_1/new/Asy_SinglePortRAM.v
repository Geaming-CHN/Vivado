`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/01 14:24:08
// Design Name: 
// Module Name: SinglePortRAM
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


module Asy_SinglePortRAM#(parameter DATA_WIDTH = 4,parameter ADDR_DEPTH = 4)(
    input clk,rst,
    input [ADDR_DEPTH-1:0]addr,
    input [DATA_WIDTH-1:0]data_in,
    input we,oe,
    output reg[DATA_WIDTH-1:0]data_out
    );
    reg [DATA_WIDTH-1:0] RAM[(1<<ADDR_DEPTH)-1:0];
    //write
    always @(posedge clk) 
    begin
        if(rst)
        begin:init_RAM
            integer i;//必须声明在有名字的块中，或写在外面
            for(i=0;i<(1<<ADDR_DEPTH);i = i+1)
            begin
                RAM[i] <= 0;
            end
        end
        else if(we)
        begin
            RAM[addr] <= data_in;
        end
    end
    //read
    //asy
    always @(addr) 
    begin
        if(!we && oe)
            data_out = RAM[addr];
        else
        begin
            data_out = 0;
        end
    end
endmodule