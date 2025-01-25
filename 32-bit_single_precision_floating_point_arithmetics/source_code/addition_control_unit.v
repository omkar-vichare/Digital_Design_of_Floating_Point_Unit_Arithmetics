module addition_control_unit#
(
    parameter integer EXPO_WIDTH = 8
)
(
    //INPUT_FROM_STAGE1
    input  [EXPO_WIDTH  :0] exp_diff_in,

    //OUTPUT_TO_STAGE1
    output                  mux1_sel_out,
    output                  mux2_sel_out,
    output                  mux3_sel_out,

    //OUTPUT_TO_STAGE2
    output [EXPO_WIDTH-1:0] rshift_out
);

    // IF_MSB_OF_exp_diff_IS_LOGIC1_THEN_ASSUMPTION_IS_FALSE
    // SO_MSB_IS_LOGIC1_THEN_ALL_SELECT_LINES_SHOULD_BE_ZERO
    
    assign mux1_sel = (exp_diff_in[EXPO_WIDTH] ? 1'b0 : 1'b1);
    assign mux2_sel = (exp_diff_in[EXPO_WIDTH] ? 1'b0 : 1'b1);
    assign mux3_sel = (exp_diff_in[EXPO_WIDTH] ? 1'b0 : 1'b1);

    //ONLY_MAGNITUDE_IS_REQUIRED_FOR_STAGE2
    assign rshift_out = exp_diff_in[EXPO_WIDTH-1:0];

endmodule