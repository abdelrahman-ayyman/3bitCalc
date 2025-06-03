/*
=======================================================
* 3-bit Signed Adder & Subtractor

* This module takes two 3-bit signed number A and B
* Sign bit = 1 means Negative number
* It adds A and B OR subtracts B from A
* Result is a 5-bit signed number

* Team Members:
* 1) Omar Mahmoud Demerdash Sayed (1220134)
* 2) Mostafa Tamer Mostafa (1220202)
* 3) Abdel Rahman Ayman Amin (4220123)
* 4) Noha Wael Ibrahim (1190535)
=======================================================
*/

module add_sub
(
    input [2:0] i_A,
    input [2:0] i_B,
    input i_S, //for addition 0, for subtracion 1
    output reg [3:0] o_res,
    output reg o_Z  //Zero result flag
);

    wire A02,A12,A22,B02,B12,B22,S0,S1,S2,S3,C0,C1,C2;

    assign A02 = i_A[0];
    assign A12 = (i_A[2] ^ i_A[1]) || (~i_A[0] && i_A[1]);
    assign A22 = i_A[2];

    assign B02 = i_B[0];
    assign B12 = (i_B[2] ^ i_B[1]) || (~i_B[0] && i_B[1]);
    assign B22 = i_B[2];

    assign S0 = (B02 ^ i_S) ^ A02 ^ i_S;
    assign C0 = ((B02 ^ i_S) && A02) || ((B02 ^ i_S) && i_S) || (A02 && i_S);

    assign S1 = (B12 ^ i_S) ^ A12 ^ C0;
    assign C1 = ((B12 ^ i_S) && A12) || ((B12 ^ i_S) && C0) || (A12 && C0);

    assign S2 = (B22 ^ i_S) ^ A22 ^ C1;
    assign C2 = ((B22 ^ i_S) && A22) || ((B22 ^ i_S) && C1) || (A22 && C1);

    assign S3 = (C2 ^ C1) ^ S2;

    assign o_res[0] = S0;
    assign o_res[1] = S1 ^ (S0 && S3);
    assign o_res[2] = (S3 ^ S2) || (S2 && ~S1 && ~S0);
    assign o_res[3] = S3;

    assign o_Z=~(o_res[2] || o_res[1] || o_res[0]);
endmodule