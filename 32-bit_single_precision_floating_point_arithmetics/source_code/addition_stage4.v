module addition_stage4#
(
    parameter integer MENT_WIDTH = 23,
    parameter integer EXPO_WIDTH = 8 
)
(
    //INPUT_FROM_STAGE1 : EXPONENT_COMPARISION
    input  [EXPO_WIDTH-1      :0] bigger_exponent_in,

    //INPUT_FROM_STAGE3 : MENTISSA_ADDITION
    input  [MENT_WIDTH-1      :0] addition_in,
    
    //INPUT_FROM_CONTROL
    input  [$clog2(MENT_WIDTH):0] normalize_position_in,
    input                         valid_bit_in, 

    //OUTPUT_TO_STAGE5  : ROUNDING_HARDWARE
    output [MENT_WIDTH-1      :0] normalized_mentissa_out,
    output [EXPO_WIDTH-1      :0] normalized_exponent_out
);

    //REG_VARIABLE_FOR_PROCEDURAL_BLOCK
    reg normalized_mentissa_proc;
    reg normalized_exponent_proc;
    
    //NORMALIZATION_OF_MENTISSA
    always@(*)begin
        if(valid_bit_in)begin
            normalized_mentissa_proc = addition_in << normalize_position_in;
        end else begin
            normalized_mentissa_proc = ({MENT_WIDTH-1}'b0);
        end
    end

    //NORMALIZATION_OF_EXPONENT
    always@(*)begin
        if(valid_bit_in)begin
            normalized_exponent_proc = bigger_exponent_in - normalize_position_in;
        end else begin
            normalized_exponent_proc = ({EXPO_WIDTH-1}'b0);
        end
    end

    //ASSIGNING_PROCEDURAL_VALUE_TO_WIRED_OUTPUT
    assign normalized_mentissa_out = normalized_mentissa_proc;
    assign normalized_exponent_out = normalized_exponent_proc;

endmodule