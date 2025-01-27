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
    
    //OPCODE_TO_DECIDE_OPERATION
    input                   opcode_in,
    //32_BIT_FLOATING_OUTPUT
    output [DATA_WIDTH-1:0] floating_addition_out
);
    //WIRES_FOR_BIT_SWIZZLING_FLOATING_NUMBERS
    wire                    sign1    ,sign2;    
    wire   [EXPO_WIDTH-1:0] exponent1,exponent2;
    wire   [MENT_WIDTH-1:0] mentissa1,mentissa2;
    
    //WIRES_FOR_STAGE1 : EXPONENT_COMPARISION    
    wire   [EXPO_WIDTH  :0] exp_diff,
    wire                    mux1_sel,
    wire                    mux2_sel,
    wire                    mux3_sel,

    //WIRES_FOR_STAGE2 : ALIGNING_MENTISSA
    wire   [EXPO_WIDTH-1:0] rshift_by,
    wire   [MENT_WIDTH-1:0] smaller_operand, 

    //WIRES_FOR_STAGE3 : MENTISSA_ADDITION
    wire   [MENT_WIDTH-1:0] bigger_operand,
    wire   [MENT_WIDTH-1:0] rshift_operand,
    wire   [MENT_WIDTH-1:0] addition_out,

    //WIRES_FOR_STAGE4 : NORMALIZATION
    wire   [EXPO_WIDTH-1:0] bigger_exponent

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
         .exp_diff_in  (exp_diff),               // FROM_STAGE1
        //WARNING : CREATING_COMBINATIONAL_LOOP ???
        //          I THINK IT'S NOT
         .mux1_sel_out (mux1_sel),               // TO_STAGE1
         .mux2_sel_out (mux2_sel),               // TO_STAGE1
         .mux3_sel_out (mux3_sel),               // TO_STAGE1
         .rshift_out   (rshift_by),              // TO_STAGE2
        );
    
    //STAGE2 : ALIGNING_EXPONENT
    addition_stage2 stage2 
        (
         .smaller_operand_in  (smaller_operand), // FROM_STAGE1
         .rshift_in           (rshift_by),       // FROM_CONTROL
         .smaller_operand_out (rshift_operand)   // TO_STAGE3
        );

    //STAGE3 : MENTISSA_ADDITION
    addition_stage3 stage3
        (
         .operand1_in  (bigger_operand),         // FROM_STAGE1
         .operand2_in  (rshift_operand),         // FROM_STAGE2
         .opcode_in    (opcode_in),              // FROM_TOP
         .addition_in  (addition_out)            // TO_STAGE4
        );

    //STAGE4: MENTISSA_NORMALIZER
    addition_stage4 stage4 
        (
         .addition_in  (addition_out),           // FROM_STAGE3
         .normalized_mentissa_out 
                       (normalized_mentissa),    // TO_STAGE5
        );

    //STAGE5 : ROUNDING_HARDWARE
    addition_stage5 stage5 
        (

        );

endmodule