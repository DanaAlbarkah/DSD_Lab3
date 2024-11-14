
//this runs task 2
/*
module sev_seg_top(
    input wire CLK100MHZ,    // using the same name as pin names
    input wire CPU_RESETN,   
    output wire CA, CB, CC, CD, CE, CF, CG, DP,
    output wire [7:0] AN,    
    input wire [15:0] SW     
);


logic reset_n;
logic clk;

assign reset_n = CPU_RESETN;
assign clk = CLK100MHZ;


// Seven segments Controller
wire [6:0] Seg;
wire [3:0] digits[0:7];

logic [3:0]a=SW[3:0];
logic  [3:0]b=SW[7:4];
logic [1:0]alu_op=SW[9:8];
logic [3:0] alu_out;

operations op(
.a(a),
.b(b),
.alu_op(alu_op),
.alu_out(alu_out));





assign digits[0] = alu_out;//a instead of SW[3:0];
assign digits[1] = 4'b1111;//SW[7:4];
assign digits[2] = 4'b1111;//alu_op;//SW[11:8];
assign digits[3] = 4'b1111;//SW[15:12];
assign digits[4] = 4'b1111;
assign digits[5] = 4'b1111;
assign digits[6] = 4'b1111;
assign digits[7] = 4'b1111;


sev_seg_controller ssc(
    .clk(clk),
    .resetn(reset_n),
    .digits(digits),
    .Seg(Seg),
    .AN(AN)
);

assign CA = Seg[0];
assign CB = Seg[1];
assign CC = Seg[2];
assign CD = Seg[3];
assign CE = Seg[4];
assign CF = Seg[5];
assign CG = Seg[6];
assign DP = 1'b1; // turn off the dot point on seven segs


endmodule : sev_seg_top

*/


//

//this runs task 3
/*
module sev_seg_top(
    input wire CLK100MHZ,    // using the same name as pin names
    input wire CPU_RESETN,   
    output wire CA, CB, CC, CD, CE, CF, CG, DP,
    output wire [7:0] AN,    
    input wire [15:0] SW     );
logic reset_n;
logic clk;
assign reset_n = CPU_RESETN;
assign clk = CLK100MHZ;
logic [3:0] rom_out;// ROM instance
ROMdesign  ROM(
    .addr(SW[3:0]),       
   .data(rom_out)   );
wire [6:0] Seg;// Seven segments Controller
wire [3:0] digits[0:7];
assign digits[0] = rom_out;
assign digits[1] = 4'b1111;;
assign digits[2] = 4'b1111;;
assign digits[3] = 4'b1111;//SW[15:12];
assign digits[4] = 4'b1111;
assign digits[5] = 4'b1111;
assign digits[6] = 4'b1111;
assign digits[7] = rom_out;
sev_seg_controller ssc(
    .clk(clk),
    .resetn(reset_n),
    .digits(digits),
    .Seg(Seg),
    .AN(AN));
//ROMdesign ROM( //.addr(SW[3:0]),       //.data(digits)   //);
assign CA = Seg[0];
assign CB = Seg[1];
assign CC = Seg[2];
assign CD = Seg[3];
assign CE = Seg[4];
assign CF = Seg[5];
assign CG = Seg[6];
assign DP = 1'b1; // turn off the dot point on seven segs
endmodule : sev_seg_top*/


/////this runs task4
module sev_seg_top(
    input wire CLK100MHZ,    // using the same name as pin names
    input wire CPU_RESETN,   
    output wire CA, CB, CC, CD, CE, CF, CG, DP,
    output wire [7:0] AN,    
    input wire [15:0] SW     
);


logic reset_n;
logic clk;

assign reset_n = CPU_RESETN;
assign clk = CLK100MHZ;


// Seven segments Controller
wire [6:0] Seg;
wire [3:0] digits[0:7];

//logic [3:0]a=SW[3:0];
//logic  [3:0]b=SW[7:4];
logic [1:0]sw=SW[1:0];
logic[6:0] Rotating_out;  

 logic [15:0] SEG;;


 rotating_display RO(
.sw(SW[1:0]),          // 2-bit switch input
   .word(SEG)       // Register for word output
);


   

    // Split SEG (16-bit value) into 4-bit digits for each 7-segment display
    assign digits[0] = SEG[3:0];    // Least significant 4 bits
    assign digits[1] = SEG[7:4];    // Next 4 bits
    assign digits[2] = SEG[11:8];   // Next 4 bits
    assign digits[3] = SEG[15:12];  // Most significant 4 bits
    assign digits[4] = 4'b1111;     // Turn off remaining digits (set to all segments on)
    assign digits[5] = 4'b1111;
    assign digits[6] = 4'b1111;
    assign digits[7] = 4'b1111;


sev_seg_controller ssc(
    .clk(clk),
    .resetn(reset_n),
    .digits(digits),
    .Seg(Seg),
    .AN(AN)
);

assign CA = Seg[0];
assign CB = Seg[1];
assign CC = Seg[2];
assign CD = Seg[3];
assign CE = Seg[4];
assign CF = Seg[5];
assign CG = Seg[6];
assign DP = 1'b1; // turn off the dot point on seven segs


endmodule : sev_seg_top


















































/*

`timescale 1ns / 1ps

module sev_seg_top(
    input wire CLK100MHZ,      // Clock input
    input wire CPU_RESETN,     // Reset input (active low)
    output wire CA, CB, CC, CD, CE, CF, CG, DP,  // Seven segment outputs
    output wire [7:0] AN,      // Anodes for the 7-segment display
    input wire [15:0] SW       // Switches for inputs and controls
);

    // Internal signals
    logic reset_n;
    logic clk;

    assign reset_n = CPU_RESETN;
    assign clk = CLK100MHZ;

    // Wires to connect to the operations module
    wire [6:0] Seg;            // Seven segment segment output (CA to CG)
    wire [1:0] alu_op;         // ALU operation selector
    wire M;                    // Mode for add/subtract

    // Assign the ALU operation and mode control inputs
    assign alu_op = SW[9:8];
    assign M = SW[10];

    // Instantiate the operations module
operations op(

a.(digit[0]),                // 4-bit input a
    b.(digit[1]),                // 4-bit input b
    input logic [1:0] alu_op,           // 2-bit operation selector
    input logic M                     // Mode switch: 0 for addition, 1 for subtraction
 
);
// Seven segments Controller
wire [6:0] Seg;
wire [3:0] digits[0:7];

assign digits[0] = SW[3:0];
assign digits[1] = SW[7:4];
assign digits[2] = SW[11:8];
assign digits[3] = SW[15:12];
assign digits[4] = 4'b1111;
assign digits[5] = 4'b1111;
assign digits[6] = 4'b1111;
assign digits[7] = 4'b1111;


sev_seg_controller ssc(
    .clk(clk),
    .resetn(reset_n),
    .digits(digits),
    .Seg(Seg),
    .AN(AN)
);
    // Map the segments from the operations module to the output pins
    assign CA = Seg[0];
    assign CB = Seg[1];
    assign CC = Seg[2];
    assign CD = Seg[3];
    assign CE = Seg[4];
    assign CF = Seg[5];
    assign CG = Seg[6];
    assign DP = 1'b1;           // Turn off the decimal point on the 7-segment display

endmodule : sev_seg_top

*/


































