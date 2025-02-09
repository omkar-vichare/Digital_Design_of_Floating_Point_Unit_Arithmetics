`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2025 08:55:56 PM
// Design Name: 
// Module Name: exception_handler
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


module exception_handler #(parameter DATA_WIDTH = 32,
                           parameter OP_WIDTH   = 2)
(
    input  [DATA_WIDTH - 1 : 0] float_num1,
    input  [DATA_WIDTH - 1 : 0] float_num2,
    input  [OP_WIDTH   - 1 : 0] opcode,
    output                      sel,
    output [DATA_WIDTH - 1 : 0] exception_out
    );
    
    wire [DATA_WIDTH - 1 : 0] add_exception;
    wire [DATA_WIDTH - 1 : 0] sub_exception;
    wire [DATA_WIDTH - 1 : 0] mul_exception;
    wire [DATA_WIDTH - 1 : 0] div_exception;
    
   /* wire  [DATA_WIDTH - 1 : 0] demux_addition_exception1; 
    wire  [DATA_WIDTH - 1 : 0] demux_subtraction_exception1;
    wire  [DATA_WIDTH - 1 : 0] demux_multiplication_exception1;
    wire  [DATA_WIDTH - 1 : 0] demux_division_exception1;
    
    wire  [DATA_WIDTH - 1 : 0] demux_addition_exception2; 
    wire  [DATA_WIDTH - 1 : 0] demux_subtraction_exception2;
    wire  [DATA_WIDTH - 1 : 0] demux_multiplication_exception2;
    wire  [DATA_WIDTH - 1 : 0] demux_division_exception2;*/
    
    //demux_1x4 D1 (.in(float_num1) , .opcode(opcode), .demux_add(demux_addition_exception1), .demux_sub(demux_subtraction_exception1), .demux_mul(demux_multiplication_exception1), .demux_div(demux_division_exception1));
    
   // demux_1x4 D2 (.in(float_num2) , .opcode(opcode), .demux_add(demux_addition_exception2), .demux_sub(demux_subtraction_exception2), .demux_mul(demux_multiplication_exception2), .demux_div(demux_division_exception2));
    
    addition_exception       E1(.float_num1(float_num1), .float_num2(float_num2), .sel(sel), .out(add_exception));
    subtraction_exception    E2(.float_num1(float_num1), .float_num2(float_num2), .sel(sel), .out(sub_exception));
    multiplication_exception E3(.float_num1(float_num1), .float_num2(float_num2), .sel(sel), .out(mul_exception));
    division_exception       E4(.float_num1(float_num1), .float_num2(float_num2), .sel(sel), .out(div_exception));
    
    mux_4x1 M1(.mux_add(add_exception), .mux_sub(sub_exception), .mux_mul(mul_exception), .mux_div(div_exception), .opcode(opcode), .out(exception_out));
    
endmodule
