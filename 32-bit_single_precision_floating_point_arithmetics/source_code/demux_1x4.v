`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2025 08:46:07 PM
// Design Name: 
// Module Name: demux_1x4
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


module demux_1x4 #(parameter DATA_WIDTH = 32,
                   parameter OP_WIDTH   = 2)
(
    input [DATA_WIDTH - 1 : 0] in,
    input [OP_WIDTH - 1   : 0] opcode,
    output reg [DATA_WIDTH - 1 : 0] demux_add,
    output reg [DATA_WIDTH - 1 : 0] demux_sub,
    output reg [DATA_WIDTH - 1 : 0] demux_mul,
    output reg [DATA_WIDTH - 1 : 0] demux_div
);
    always @(*) 
    begin
        case (opcode)
            2'b00: demux_add = in;
            2'b01: demux_sub = in;
            2'b10: demux_mul = in;
            2'b11: demux_div = in;
            default: begin
                demux_add = 32'b0;
                demux_sub = 32'b0;
                demux_mul = 32'b0;
                demux_div = 32'b0;
            end
        endcase
    end
endmodule
