`timescale 1ns / 1ps

module Adder_Subtractor_4bit (
    input logic [3:0] A,     // 4-bit input A
    input logic [3:0] B,     // 4-bit input B
    input logic M,           // Mode input (0 for Addition, 1 for Subtraction)
    output logic [3:0] S,    // 4-bit Sum output
    output logic Cout        // Carry-out output
);

    logic [3:0] B_prime;     // B' (inverted B for subtraction)
    logic [3:0] C;           // Carry signals

    // Calculate B' (if M = 1, we invert B, otherwise, B stays the same)
    assign B_prime = B ^ {4{M}};  // XOR all bits of B with M to invert if M = 1


    // First bit (LSB)
    assign S[0] = A[0] ^ B_prime[0] ^ M;              // Sum = A0 XOR B0 XOR M
    assign C[0] = (A[0] & B_prime[0]) | (M & (A[0] ^ B_prime[0])); // Carry for bit 0

    // Second bit
    assign S[1] = A[1] ^ B_prime[1] ^ C[0];            // Sum = A1 XOR B1 XOR C0
    assign C[1] = (A[1] & B_prime[1]) | (C[0] & (A[1] ^ B_prime[1])); // Carry for bit 1

    // Third bit
    assign S[2] = A[2] ^ B_prime[2] ^ C[1];            // Sum = A2 XOR B2 XOR C1
    assign C[2] = (A[2] & B_prime[2]) | (C[1] & (A[2] ^ B_prime[2])); // Carry for bit 2

    // Fourth bit (MSB)
    assign S[3] = A[3] ^ B_prime[3] ^ C[2];            // Sum = A3 XOR B3 XOR C2
    assign Cout = (A[3] & B_prime[3]) | (C[2] & (A[3] ^ B_prime[3])); // Final carry-out

endmodule
