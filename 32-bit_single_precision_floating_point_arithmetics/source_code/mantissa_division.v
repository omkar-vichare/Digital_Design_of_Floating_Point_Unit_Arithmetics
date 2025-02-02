`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2025 06:22:47 PM
// Design Name: 
// Module Name: division2
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

//Mantissa division using newton raphson method
module division2(
    input [23:0] mantissa_num1,  // 24-bit mantissa num1
    input [23:0] mantissa_num2,  // 24-bit mantissa num2
    output reg [47:0] mantissa_div_result  // 48-bit result (after normalization)
);

    reg [47:0] reciprocal;  // to hold reciprocal of mantissa_num2
    reg [47:0] intermediate_result;  // to hold intermediate division result
    integer i;  // loop variable for iterations

    always @(*) begin
        // Step 1: Initialize the reciprocal of mantissa_num2 using an approximation
        reciprocal = {24'b1, mantissa_num2};  // initial approximation (1 / mantissa_num2)

        // Step 2: Apply Newton-Raphson method to find the reciprocal
        for (i = 0; i < 5; i = i + 1) begin  // iterate 5 times (can be adjusted for precision)
            reciprocal = reciprocal * (48'b10 - (mantissa_num2 * reciprocal));  // Newton-Raphson iteration
        end

        // Step 3: Perform the division by multiplying mantissa_num1 with the reciprocal of mantissa_num2
        intermediate_result = {24'b1, mantissa_num1} * reciprocal;  // multiply mantissa_num1 by reciprocal

        // Step 4: Normalize the result by adjusting the bit-width (if necessary)
        mantissa_div_result = intermediate_result >> 24;  // Right-shift to normalize the result

    end

endmodule
