module addition_stage2#
(
    paramter integer MENT_WIDTH = 23,
    paramter integer EXPO_WIDTH = 8
)
(
    //INPUT_FROM_STAGE1
    input  [MENT_WIDTH-1:0] smaller_operand_in, 
    //INPUT_FROM_CONTROL
    input  [EXPO_WIDTH-1:0] rshift_in,    

    //OUTPUT_TO_STAGE3
    output [MENT_WIDTH-1:0] smaller_operand_out
);

    assign smaller_operand_out = smaller_operand_in << rshift_in; 

endmodule