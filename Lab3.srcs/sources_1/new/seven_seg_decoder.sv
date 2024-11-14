
module seven_seg_decoder(
    input  wire [3:0] bin,      // 4-bit binary input (0-F)
    output reg [6:0] seg       // 7-bit output for segments a-g
);

// Add your code here -----------------------------------

logic D3, D2, D1, D0;
assign {D3,D2,D1,D0}= bin;


    //  A
    assign seg[0] = (~D3 & ~D2 & ~D1 & D0) | (~D3 & D2 & ~D1 & ~D0) | (D3 & ~D2 & D1 & D0) | (D3 & D2 & ~D1 & D0);

    //  B
    assign seg[1] = (~D3 & D2 & ~D1 & D0) | (~D3 & D2 & D1 & ~D0) | (D3 & ~D2 & D1 & D0) | (D3 & D2 & ~D1 & ~D0) | (D3 & D2 & D1 & ~D0) | (D3 & D2 & D1 & D0);

    //  C
    assign seg[2] = (~D3 & ~D2 & D1 & ~D0) | (D3 & D2 & ~D1 & ~D0) | (D3 & D2 & D1 & ~D0) | (D3 & D2 & D1 & D0);

    //  D
    assign seg[3] = (~D3 & ~D2 & ~D1 & D0) | (~D3 & D2 & ~D1 & ~D0) | (~D3 & D2 & D1 & D0) | (D3 & ~D2 & D1 & ~D0) | (D3 & D2 & D1 & D0);

    //  E
    assign seg[4] = (~D3 & ~D2 & ~D1 & D0) | (~D3 & ~D2 & D1 & D0) | (~D3 & D2 & ~D1 & ~D0) | (~D3 & D2 & ~D1 & D0) | (~D3 & D2 & D1 & D0) | (D3 & ~D2 & ~D1 & D0);

    //  F
    assign seg[5] = (~D3 & ~D2 & ~D1 & D0) | (~D3 & ~D2 & D1 & ~D0) | (~D3 & ~D2 & D1 & D0) | (~D3 & D2 & D1 & D0) | (D3 & D2 & ~D1 & D0);

    //  G
    assign seg[6] = (~D3 & ~D2 & ~D1 & ~D0) | (~D3 & ~D2 & ~D1 & D0) | (~D3 & D2 & D1 & D0) | (D3 & D2 & ~D1 & ~D0);

endmodule