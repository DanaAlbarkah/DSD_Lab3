/*`timescale 1ns / 1ps
module operations #(
    parameter display_speed = 20
)(
    input logic clk,
    input logic resetn,
     input logic [3:0] a,                // 4-bit input a
    input logic [3:0] b,                // 4-bit input b
    input logic [1:0] alu_op,           // 2-bit operation selector
    input logic [3:0] digits [0:7],      // 4-bit binary input logic)
    output logic  [6:0] Seg,       // 7-bit output for segments a-g
    output logic  [7:0] AN
);

    logic [display_speed - 1:0] count;

module operations #(



)
    //  Seven Segment decoder to generate sev signals from 4
    seven_seg_decoder ssd(
        .bin(digits[count[display_speed - 1:display_speed - 3]]),
        .seg(Seg)
    );

    // Decoder to POWER one segment at a time
    wire [7:0] decoder_out;
    decoder #(
        .n(3)
    ) decoder_inst (
        .in(count[display_speed - 1:display_speed - 3]),
        .out(decoder_out)
    );
    assign AN = ~decoder_out;

    // Counter to slow down to the tranfer of digits to there segment
    counter_n_bit #(
        .n(display_speed)
    ) counter (
        .clk(clk),
        .resetn(resetn),
        .load(1'b0),
        .en(1'b1),
        .load_data(),
        .count(count)
    );

endmodule*/


/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
`timescale 1ns / 1ps

module operations #(
    parameter display_speed = 20
)(
    input logic clk,
    input logic resetn,
    input logic [3:0] a,                // 4-bit input a
    input logic [3:0] b,                // 4-bit input b
    input logic [1:0] alu_op,           // 2-bit operation selector
    output logic [6:0] Seg,             // 7-segment display output
    output logic [7:0] AN               // Segment enable
);
    logic [3:0] digits [0:7];           // Array for 7-segment display values
    logic [3:0] arith_result, logic_result, shift_result, alu_out;
    logic carry_out;

    // Instantiate the Adder_Subtractor_4bit module
    Adder_Subtractor_4bit add_sub_inst (
        .A(a),
        .B(b),
        .M(alu_op[0]),           // Mode input: 0 for addition, 1 for subtraction
        .S(arith_result),        // Output of addition/subtraction
        .Cout(carry_out)         // Carry-out (unused here but available if needed)
    );

    // Logical operations
    assign logic_result = a & b;        // AND operation
    assign shift_result = a << 1;       // Shift left by 1

    // First 2-to-1 MUX: Select between arithmetic result and logical AND
    logic [3:0] mux1_out;
    assign mux1_out = (alu_op[1] == 1'b0) ? arith_result : logic_result;

    // Second 2-to-1 MUX: Select between mux1_out and shift
    assign alu_out = (alu_op[0] == 1'b1) ? shift_result : mux1_out;

  ///  // Map values to the digits array for display on seven-segment
    always_comb begin
        digits[0] = a;
        digits[1] = b;
        digits[2] = alu_out;
        digits[3] = 4'b0000; // Unused segments
        digits[4] = 4'b0000;
        digits[5] = 4'b0000;
        digits[6] = 4'b0000;
        digits[7] = 4'b0000;
    end
//
    // Instantiate seven_seg_decoder to generate segment signals
    logic [2:0] display_select;
    assign display_select = count[display_speed - 1 : display_speed - 3];
    seven_seg_decoder ssd (
        .bin(digits[display_select]),
        .seg(Seg)
    );

    // Decoder to activate one segment at a time
    wire [7:0] decoder_out;
    decoder #(
        .n(3)
    ) decoder_inst (
        .in(display_select),
        .out(decoder_out)
    );
    assign AN = ~decoder_out;

    // Counter to slow down the transfer of digits to their respective segments
    logic [display_speed - 1:0] count;
    counter_n_bit #(
        .n(display_speed)
    ) counter (
        .clk(clk),
        .resetn(resetn),
        .load(1'b0),
        .en(1'b1),
        .load_data(),
        .count(count)
    );

endmodule*/














`timescale 1ns / 1ps

module operations (
   
    input logic [3:0] a,                // 4-bit input a
    input logic [3:0] b,                // 4-bit input b
    input logic [1:0] alu_op,           // 2-bit operation selector
    //input logic M,                     // Mode switch: 0 for addition, 1 for subtraction
 output logic [3:0]alu_out
);
    logic [3:0] arith_result, logic_result, shift_result;
    logic carry_out;

    // Instantiate the Adder_Subtractor_4bit module
    Adder_Subtractor_4bit add_sub_inst (
        .A(a),
        .B(b),
        .M(alu_op[0]),                // Use M to control addition/subtraction
        .S(arith_result),     // Output of addition/subtraction
        .Cout(carry_out)      // Carry-out (unused here but available if needed)
    );

    // Logical operations
    assign logic_result = a & b;        // AND operation
    assign shift_result = a << b;       // Shift left by 1

    // First 2-to-1 MUX: Select between arithmetic result and logical AND
    logic [3:0] mux1_out;

    // Second 2-to-1 MUX: Select between mux1_out and shift
    assign mux1_out = (alu_op== 2'b11) ?logic_result:shift_result;

    assign alu_out = (alu_op[1] == 1'b0) ? arith_result : mux1_out;



    endmodule









