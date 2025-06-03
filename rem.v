/*
=======================================================
* 3-bit Signed Remainder

* This module takes two 3-bit signed number A and B
* Sign bit = 1 means Negative number
* It gets remainder when A is divided by B
* Result is a 3-bit signed number

* Team Members:
* 1) Omar Mahmoud Demerdash Sayed (1220134)
* 2) Mostafa Tamer Mostafa (1220202)
* 3) Abdel Rahman Ayman Amin (4220123)
* 4) Noha Wael Ibrahim (1190535)
=======================================================
*/

module rem 
(
    input [2:0] i_A,
    input [2:0] i_B,
    output reg [2:0] o_res,
    output reg o_DZ, //Divison By Zero Flag
    output reg o_Z  //Zero result flag
);

always @(*)begin
    case(i_A[1:0])
        2'b00: begin
            o_res[0]=0;
            o_res[1]=0;
        end
        2'b01:begin
            o_res[0]=i_B[1];
            o_res[1]=0;
        end
        2'b10:begin
            o_res[0]=0;
            o_res[1]=i_B[0] && i_B[1];
        end
        2'b11:begin
            o_res[0]=(~i_B[0] && i_B[1]);
            o_res[1]=0;
        end
    endcase
    o_res[2]=i_A[2];
    o_DZ=~(i_B[0] || i_B[1]);
    o_Z=~(o_res[1] || o_res[0]);
end
endmodule