`timescale 1ns / 1ps
/*
module rotating_display (
    input logic [1:0] sw,          // 2-bit switch input
    output logic [6:0] seg0,       // 7-segment output for display 0
    output logic [6:0] seg1,       // 7-segment output for display 1
    output logic [6:0] seg2,       // 7-segment output for display 2
    output logic [6:0] seg3        // 7-segment output for display 3
);

    // Define 7-segment encoding for each character using logic instead of parameter
    logic [6:0] SEG_C = 7'b1000110;  // "C"
    logic [6:0] SEG_0 = 7'b1000000;  // "0"
    logic [6:0] SEG_d = 7'b0100001;  // "d"
    logic [6:0] SEG_E = 7'b0000110;  // "E"

    // Display pattern based on switch input
    always_comb begin
        case (sw)
            2'b00: begin // Display "C0dE"
                seg0 = SEG_C;
                seg1 = SEG_0;
                seg2 = SEG_d;
                seg3 = SEG_E;
            end
            2'b01: begin // Display "E0Cd"
                seg0 = SEG_E;
                seg1 = SEG_0;
                seg2 = SEG_C;
                seg3 = SEG_d;
            end
            2'b10: begin // Display "dEC0"
                seg0 = SEG_d;
                seg1 = SEG_E;
                seg2 = SEG_C;
                seg3 = SEG_0;
            end
            2'b11: begin // Display "0dCE"
                seg0 = SEG_0;
                seg1 = SEG_d;
                seg2 = SEG_C;
                seg3 = SEG_E;
            end
            default: begin // Default case (optional)
                seg0 = 7'b1111111; // Turn off all segments
                seg1 = 7'b1111111;
                seg2 = 7'b1111111;
                seg3 = 7'b1111111;
            end
        endcase
    end
endmodule*/




module rotating_display (
    input logic [1:0] sw,          // 2-bit switch input
    output reg [15:0] word         // Register for word output
);

always @(sw)
begin
    case(sw)
        2'b00: word = 16'hC0DE;   // Hexadecimal representation
        2'b01: word = 16'hEC0D;
        2'b10: word = 16'hDEC0;
        2'b11: word = 16'h0DEC;
        default: word = 16'h0000;  // Default case to avoid undefined behavior
    endcase
end

endmodule















