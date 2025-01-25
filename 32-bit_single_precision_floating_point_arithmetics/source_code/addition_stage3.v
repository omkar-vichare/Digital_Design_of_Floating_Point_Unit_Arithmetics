module addition_stage3#
(
    parameter integer MENT_WIDTH = 23
)
(
    //INPUT_FROM_STAGE1
    input  [MENT_WIDTH-1:0] operand1_in,
    //INPUT_FROM_STAGE2
    input  [MENT_WIDTH-1:0] operand2_in,
    //INPUT_FROM_TOP
    input                   opcode_in,

    //OUTPUT_TO_STAGE4
    output [MENT_WIDTH-1:0] addition_out  
);

    assign addition_out = operand1_in + operand2_in;

endmodule