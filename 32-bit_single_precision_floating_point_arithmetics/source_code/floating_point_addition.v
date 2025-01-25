module floating_point_addition#
(
    parameter integer DATA_WIDTH = 32,
    parameter integer MENT_WIDTH = 23,
    parameter integer EXPO_WIDTH = 8
)
(
    //32_BIT_FLOATING_INPUT
    input  [DATA_WIDTH-1:0] floating1_in,
    input  [DATA_WIDTH-1:0] floating2_in,
    //32_BIT_FLOATING_OUTPUT
    output [DATA_WIDTH-1:0] floating_addition_out
);
    //WIRES_FOR_BIT_SWIZZLING_FLOATING_NUMBERS
    wire                    sign1    ,sign2;    
    wire   [EXPO_WIDTH-1:0] exponent1,exponent2;
    wire   [MENT_WIDTH-1:0] mentissa1,mentissa2;
    
    //WIRES_FOR_STAGE1 : EXPONENT_COMPARISION    

    //BIT_SWIZZLING
    assign {sign1,exponent1,mentissa1} = floating1_in;
    assign {sign2,exponent2,mentissa2} = floating2_in;

    //STAGE1 : EXPONENT_COMPARISION
    addition_stage1 stage1
        (
         .floating1_in        (floating1_in),    // FROM_TOP
         .floating2_in        (floating2_in),    // FROM_TOP
         .mux1_sel_in         (mux1_sel),        // FROM_CONTROL
         .mux2_sel_in         (mux2_sel),        // FROM_CONTROL
         .mux3_sel_in         (mux3_sel),        // FROM_CONTROL
         .exp_diff_out        (exp_diff),        // TO_CONTROL
         .bigger_operand_out  (bigger_operand),  // TO_STAGE3
         .smaller_operand_out (smaller_operand), // TO_STAGE2
         .bigger_exponent_out (bigger_exponent), // TO_STAGE4
        );

    //CONTROL_UNIT_FOR_FLOATING_ADDITION
    addition_control_unit control_unit
        (
         .exp_diff_out    (exp_diff),            // FROM_STAGE1
        //WARNING : CREATING_COMBINATIONAL_LOOP
         .mux1_sel_out    (mux1_sel),            // TO_STAGE1
         .mux2_sel_out    (mux2_sel),            // TO_STAGE1
         .mux3_sel_out    (mux3_sel),            // TO_STAGE1
         . 
        );
    
    //STAGE2 : ALIGNING_EXPONENT
    addition_stage2 stage2 
        (


        );



endmodule