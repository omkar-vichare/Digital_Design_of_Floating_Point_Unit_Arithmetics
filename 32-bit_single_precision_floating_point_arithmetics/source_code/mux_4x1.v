`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2025 08:50:56 PM
// Design Name: 
// Module Name: mux_4x1
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


module mux_4x1   #(parameter DATA_WIDTH = 32,
                   parameter OP_WIDTH   = 2)
(
    input [DATA_WIDTH - 1 : 0] mux_add,
    input [DATA_WIDTH - 1 : 0] mux_sub,
    input [DATA_WIDTH - 1 : 0] mux_mul,
    input [DATA_WIDTH - 1 : 0] mux_div,
    input [OP_WIDTH - 1   : 0] opcode,
    output reg [DATA_WIDTH - 1:0] out
);
    always @(*) begin
        case (opcode)
        2'b00: out = mux_add;
        2'b01: out = mux_sub;
        2'b10: out = mux_mul;
        2'b11: out = mux_div;
        default: out = 32'b0;
        endcase
    end
endmodule
