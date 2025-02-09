`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2025 01:39:09 AM
// Design Name: 
// Module Name: Normalizer
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


module Normalizer #(parameter M = 48,
                    parameter MWIDTH = 23,
                    parameter EWIDTH = 8)
(
    input [M - 1 : 0]mantissa_from_multiplier,
    input [EWIDTH - 1 : 0]exponent_from_subtractor,
    output reg [EWIDTH - 1 : 0] normalized_exponent,
    output reg [MWIDTH - 1 : 0] normalized_mantissa
);
    
    reg [EWIDTH - 1 : 0] position;
    reg [M - 1      : 0] shifted_mantissa;

    always @(*)
    begin
                
        casez(mantissa_from_multiplier)
        48'b1??????????????????????????????????????????????? : position = 8'd0;
        48'b01?????????????????????????????????????????????? : position = 8'd1;
        48'b001????????????????????????????????????????????? : position = 8'd2;
        48'b0001???????????????????????????????????????????? : position = 8'd3;
        48'b00001??????????????????????????????????????????? : position = 8'd4;
        48'b000001?????????????????????????????????????????? : position = 8'd5;
        48'b0000001????????????????????????????????????????? : position = 8'd6;
        48'b00000001???????????????????????????????????????? : position = 8'd7;
        48'b000000001??????????????????????????????????????? : position = 8'd8;
        48'b0000000001?????????????????????????????????????? : position = 8'd9;
        48'b00000000001????????????????????????????????????? : position = 8'd10;
        48'b000000000001???????????????????????????????????? : position = 8'd11;
        48'b0000000000001??????????????????????????????????? : position = 8'd12;
        48'b00000000000001?????????????????????????????????? : position = 8'd13;
        48'b000000000000001????????????????????????????????? : position = 8'd14;
        48'b0000000000000001???????????????????????????????? : position = 8'd15;
        48'b00000000000000001??????????????????????????????? : position = 8'd16;
        48'b000000000000000001?????????????????????????????? : position = 8'd17;
        48'b0000000000000000001????????????????????????????? : position = 8'd18;
        48'b00000000000000000001???????????????????????????? : position = 8'd19;
        48'b000000000000000000001??????????????????????????? : position = 8'd20;
        48'b0000000000000000000001?????????????????????????? : position = 8'd21;
        48'b00000000000000000000001????????????????????????? : position = 8'd22;
        48'b000000000000000000000001???????????????????????? : position = 8'd23;
        48'b0000000000000000000000001??????????????????????? : position = 8'd24;
        48'b00000000000000000000000001?????????????????????? : position = 8'd25;
        48'b000000000000000000000000001????????????????????? : position = 8'd26;
        48'b0000000000000000000000000001???????????????????? : position = 8'd27;
        48'b00000000000000000000000000001??????????????????? : position = 8'd28;
        48'b000000000000000000000000000001?????????????????? : position = 8'd29;
        48'b0000000000000000000000000000001????????????????? : position = 8'd30;
        48'b00000000000000000000000000000001???????????????? : position = 8'd31;
        48'b000000000000000000000000000000001??????????????? : position = 8'd32;
        48'b0000000000000000000000000000000001?????????????? : position = 8'd33;
        48'b00000000000000000000000000000000001????????????? : position = 8'd34;
        48'b000000000000000000000000000000000001???????????? : position = 8'd35;
        48'b0000000000000000000000000000000000001??????????? : position = 8'd36;
        48'b00000000000000000000000000000000000001?????????? : position = 8'd37;
        48'b000000000000000000000000000000000000001????????? : position = 8'd38;
        48'b0000000000000000000000000000000000000001???????? : position = 8'd39;
        48'b00000000000000000000000000000000000000001??????? : position = 8'd40;
        48'b000000000000000000000000000000000000000001?????? : position = 8'd41;
        48'b0000000000000000000000000000000000000000001????? : position = 8'd42;
        48'b00000000000000000000000000000000000000000001???? : position = 8'd43;
        48'b000000000000000000000000000000000000000000001??? : position = 8'd44;
        48'b0000000000000000000000000000000000000000000001?? : position = 8'd45;
        48'b00000000000000000000000000000000000000000000001? : position = 8'd46;
        48'b000000000000000000000000000000000000000000000001 : position = 8'd47;
        default: position = 8'd24; // Assume denormalized
        endcase
        
    end
    
    //Mantissa Alignment for final output
    always @ (*)
    begin
        shifted_mantissa = mantissa_from_multiplier << (position + 1);
        normalized_mantissa = shifted_mantissa[47:25];
        normalized_exponent = (exponent_from_subtractor - position) + 1;
    end
    
endmodule
