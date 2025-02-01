module tb_floating_point_addition#
(
    parameter integer DATA_WIDTH = 32,
    parameter integer MENT_WIDTH = 23,
    parameter integer EXPO_WIDTH = 8
);

    reg  [DATA_WIDTH-1:0] floating1_in;
    reg  [DATA_WIDTH-1:0] floating2_in;
    reg                   opcode_in;

    wire [DATA_WIDTH-1:0] floating_addition_out;

    floating_point_addition#
    (
        .DATA_WIDTH(DATA_WIDTH),
        .MENT_WIDTH(MENT_WIDTH),
        .EXPO_WIDTH(EXPO_WIDTH)
    )DUT
    (
        .floating1_in         (floating1_in),
        .floating2_in         (floating2_in),
        .opcode_in            (opcode_in),
        .floating_addition_out(floating_addition_out)
    );

    initial begin
        floating1_in = 32'b0_10000001_1110_1010_1111_0001_1010_101;
        floating2_in = 32'b0_10000000_0101_0001_0100_0111_1010_111;
        opcode_in    = 0;
        $display("flaoting_addition_out = %b_%b_%b",floating_addition_out[31], floating_addition_out[30:23], floating_addition_out[22:0]);
        #100 $finish();        
    end

endmodule