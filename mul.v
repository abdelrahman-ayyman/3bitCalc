/*
=======================================================
* 3-bit Signed Multiplier

* This module takes two 3-bit signed number A and B
* Sign bit = 1 means Negative number
* It multiplies A and B
* Result is a 4-bit signed number

* Team Members:
* 1) Omar Mahmoud Demerdash Sayed (1220134)
* 2) Mostafa Tamer Mostafa (1220202)
* 3) Abdel Rahman Ayman Amin (4220123)
* 4) Noha Wael Ibrahim (1190535)
=======================================================
*/

module mul  
(
    input [2:0] i_A,
    input [2:0] i_B,
    output reg [4:0] o_res,
    output reg o_Z  //Zero result flag
);

    assign o_res[0] = i_A[0] && i_B[0];
    assign o_res[1] = (i_A[1] && i_B[0]) ^ (i_A[0] && i_B[1]);
    assign o_res[2] = ((i_A[1] && i_B[0]) && (i_A[0] && i_B[1])) ^ (i_A[1] && i_B[1]); 
    assign o_res[3] = ((i_A[1] && i_B[0]) && (i_A[0] && i_B[1])) && (i_A[1] && i_B[1]);
    assign o_res[4] = (i_A[2] ^ i_B[2]);
    assign o_Z=~(o_res[3] || o_res[2] || o_res[1] || o_res[0]);
endmodule