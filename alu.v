/*
=======================================================
* 3-bit Arithmetic Unit Calculator

* This module takes two 3-bit signed number A and B
* Sign bit = 1 means Negative number
* Result is a 5-bit signed number
* Input op is selection for operation chosen (0,1,2,3)

! if op = 0 (00) , Multiplication ( A x B )
! if op = 1 (01) , Remainder      ( A mod B )
! if op = 2 (10) , Addition       ( A + B )
! if op = 3 (11) , Subtraction    ( A - B )

* Team Members:
* 1) Omar Mahmoud Demerdash Sayed (1220134)
* 2) Mostafa Tamer Mostafa (1220202)
* 3) Abdel Rahman Ayman Amin (4220123)
* 4) Noha Wael Ibrahim (1190535)
=======================================================
*/

module alu
(
    input [1:0] op,
    input [2:0] A,
    input [2:0] B,
    output reg [4:0] result,
    output reg DZF,
    output reg ZF,
    output reg SF
);

    wire [3:0] add_sub_result;

    /* ---- Addition & Subtration ---- */
    add_sub add_sub_unit
    (
        .i_A(A),
        .i_B(B),
        .i_S(op[0]), // 0 for addition, 1 for subtraction
        .o_res(add_sub_result)
    );

    wire [4:0] mul_result;

    /* ---- Multiplication ---- */
    mul mul_unit
    (
        .i_A(A),
        .i_B(B),
        .o_res(mul_result)
    );

    wire [2:0] rem_result;
    wire DZ;

    /* ---- Remainder ---- */
    rem rem_unit
    (
        .i_A(A),
        .i_B(B),
        .o_res(rem_result),
        .o_DZ(DZ) // division by zero flag
    );
    
    always @(*) begin
        DZF = 0;
        case (op)
        2'b00: begin
                result = mul_result;
                SF = mul_result[4];
                end
        2'b01: begin
                DZF = DZ;
                result = rem_result[1:0];
                SF = rem_result[2];
                result[4]=rem_result[2]; //sign bit to fifth bit in result
                end
        2'b10,
        2'b11: begin
                result = add_sub_result[2:0];
                SF = add_sub_result[3];
                result[4]=add_sub_result[3]; //sign bit to fifth bit in result
                end
            default: result = 4'b0;
        endcase
        ZF = (result[3:0] == 0);
    end
endmodule