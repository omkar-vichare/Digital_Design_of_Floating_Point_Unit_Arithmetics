module addition_control_unit#
(
    parameter integer MENT_WIDTH = 23,
    parameter integer EXPO_WIDTH = 8
)
(
    //INPUT_FROM_STAGE1 : EXPONENT_COMPARISION
    input  [EXPO_WIDTH        :0] exp_diff_in,
    //INPUT_FROM_STAGE3 : MENTISSA_ADDITION
    input  [MENT_WIDTH        :0] addition_in, 

    //OUTPUT_TO_STAGE1  : EXPONENT_COMPARISION
    output                        mux1_sel_out,
    output                        mux2_sel_out,
    output                        mux3_sel_out,

    //OUTPUT_TO_STAGE2  : ALIGNING_MENISSA
    output [EXPO_WIDTH-1      :0] rshift_out,

    //OUTPUT_TO_STAGE4  : EXPONENT_MENTISSA_NORMALIZER
    output [$clog2(MENT_WIDTH):0] normalize_position_out, 
    output                        valid_bit_out;
);

    //TO_GET_POSITION_OF_1ST_LOGIC1_CHECKING_FROM_MSB
    reg [$clog2(MENT_WIDTH):0] position;
    //TO_DISTINGUISH_BETWEEN_REDUNDANT_POSITION_VALUES
    reg                        valid_bit;
    
    //FOR_LOOP_VARIABLE : TO_FIND_NORMALIZATION_POINT
    integer i;

    // IF_MSB_OF_exp_diff_IS_LOGIC1_THEN_ASSUMPTION_IS_FALSE
    // SO_MSB_IS_LOGIC1_THEN_ALL_SELECT_LINES_SHOULD_BE_ZERO
    
    assign mux1_sel = (exp_diff_in[EXPO_WIDTH] ? 1'b0 : 1'b1);
    assign mux2_sel = (exp_diff_in[EXPO_WIDTH] ? 1'b0 : 1'b1);
    assign mux3_sel = (exp_diff_in[EXPO_WIDTH] ? 1'b0 : 1'b1);

    //ONLY_MAGNITUDE_IS_REQUIRED_FOR_STAGE2
    assign rshift_out = exp_diff_in[EXPO_WIDTH-1:0];

    //FOR_LOOP_BEGINS_FROM_MSB_TILL_LAST_POSITION
    always @(*) begin
        position  = 5'd0;
        valid_bit = 1'd1;
        for(i = 5'd31; i >= 0 ; i = i - 1)begin
            if(addition_in[i])begin
                position  = i;
                valid_bit = 1'd1; 
                break; //ONCE_FOUND_NO_NEED_TO_FURTHER_ITERATE
            end
        end         
    end
    
    //ASSIGNING_PROCEDURAL_VALUE_TO_WIRED_OUTPUT
    assign valid_bit_out          = valid_bit;
    assign normalize_position_out = position;

endmodule