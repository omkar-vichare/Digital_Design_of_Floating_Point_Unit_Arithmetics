module addition_stage4#
(
    parameter integer MENT_WIDTH = 23 
)
(
    //INPUT_FROM_STAGE3
    input  [MENT_WIDTH-1:0] addition_in,
    
    //OUTPUT_TO_STAGE5
    output [MENT_WIDTH-1:0] normalized_mentissa
);

    //TO_GET_POSITION_OF_1ST_LOGIC1_CHECKING_FROM_MSB
    reg [4:0] position;
    //TO_DISTINGUISH_BETWEEN_REDUNDANT_POSITION_VALUES
    reg       valid_bit;

    //FOR_LOOP_VARIABLE
    integer i;

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

endmodule