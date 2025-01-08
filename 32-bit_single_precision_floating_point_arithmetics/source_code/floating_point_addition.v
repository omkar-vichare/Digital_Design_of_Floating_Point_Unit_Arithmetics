module floating_point_addition#
(
    parameter integer DATA_WIDTH = 32,
    parameter integer MENT_WIDTH = 23,
    parameter integer EXPO_WIDTH = 8
)
(
    input  [DATA_WIDTH-1:0] floating1,
    input  [DATA_WIDTH-1:0] floating2,

    output [DATA_WIDTH-1:0] floating_addition_out
);

    wire                    sign1    ,sign2;    
    wire   [EXPO_WIDTH-1:0] exponent1,exponent2;
    wire   [MENT_WIDTH-1:0] mentissa1,mentissa2;
    
    assign {sign1,exponent1,mentissa1} = floating1;
    assign {sign2,exponent2,mentissa2} = floating2;

endmodule