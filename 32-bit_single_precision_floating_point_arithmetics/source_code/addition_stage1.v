module addition_stage1#
(
	parameter integer DATA_WIDTH = 32,
	parameter integer MENT_WIDTH = 23,
	parameter integer EXPO_WIDTH = 8,
)
(
	//INPUT_FROM_ADDITION_TOP_MODULE
	input  [DATA_WIDTH-1:0] floating1_in,
	input  [DATA_WIDTH-1:0] floating2_in,
	//INPUT_FROM_CONTROL_UNIT
	input                   mux1_sel_in,
	input                   mux2_sel_in,
	input                   mux3_sel_in,
	
	//OUTPUT_TO_CONTROL_UNIT
	output [EXPO_WIDTH  :0] exp_diff_out,
    
	//OUTPUT_TO_STAGE2 : ALIGNING_MENTISSA
    output [MENT_WIDTH-1:0] smaller_operand_out,
    
	//OUTPUT_TO_STAGE3 : MENTISSA_ADDITION
	output [MENT_WIDTH-1:0] bigger_operand_out,
	
	//OUTPUT_TO_STAGE4 : NORMALIZER
	output [EXPO_WIDTH-1:0] bigger_exponent_out
);

	//INTERNEDIATE_SIGNAL_FOR_2's_COMPLIMENT
	wire   [EXPO_WIDTH  :0] twos_compliment;
	
	//BIT_SWIZZLING
	assign {sign1,exponent1,mentissa1} = floating1_in;
    assign {sign2,exponent2,mentissa2} = floating2_in;

    // REASON_FOR_EXPONRNT_SUBTRACTION
    // 1. TO_GET_MAGNITUDE_TO_PERFROM_RIGHT_SHIFT
    // 2. TO_KNOW_WHICH_EXPONENT_IS_BIGGER

    assign twos_compliment = (~exponent2) + 1'b1;
    assign exp_diff_out    =   exponent1  + twos_compliment;

    // SELECTING_APPROPRIATELY : SMALLER_AND_BIGGER_MENTISSA
    // ASSUMPTION : EXPONENT1 > EXPONENT2 
    // IF_ASSUMPTION_IS_CORRECT_SEL_LINES_ARE_LOGIC 1

	assign bigger_operand_out  = (mux1_sel_in ? mentissa1 
											  : mentissa2);

	assign smaller_operand_out = (mux2_sel_in ? mentissa2 
											  : mentissa1);      

	// SELECT_BIGGER_EXPONENT
	// FOR_LATER_USE_DURING_NORMALIZATION

	assign bigger_operand_out  = (mux3_sel_in ? exponent1 : exponent2);

endmodule