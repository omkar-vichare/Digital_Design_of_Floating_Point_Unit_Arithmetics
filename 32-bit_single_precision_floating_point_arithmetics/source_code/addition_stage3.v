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

    //TO_GET_TWO'S_COMPLIMENT_OF_OPERAND2
    wire   [MENT_WIDTH-1:0] operand2_intermediate; 
    
    //RESOURCE_SHARING : USING_JUST_ONE_ADDITION_MODULE
    assign operand2_inter = opcode_in ? (~operand2_in + 1'b1)
                                      :   operand2_in;

    //ACTUAL_ADDITION_OF_MENTISSAS
    assign addition_out   = operand1_in + operand2_inter;

endmodule