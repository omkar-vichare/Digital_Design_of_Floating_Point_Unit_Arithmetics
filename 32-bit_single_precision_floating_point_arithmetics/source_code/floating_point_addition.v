module floating_point_addition#
(
    parameter integer DATA_WIDTH = 32,
    parameter integer EXPO_WIDTH = 8
)
(
    input  [DATA_WIDTH-1:0] floating1,
    input  [DATA_WIDTH-1:0] floating2,

    output [DATA_WIDTH-1:0] floating_addition_out
);

    wire   [EXPO_WIDTH-1:0] exponent1,exponent2;
    wire                    sign1    ,sign2;    
    
endmodule