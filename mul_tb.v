/*
=======================================================
* 3-bit Signed Multiplier Testbench

* This module takes two 3-bit signed number A and B
* Sign bit = 1 means Negative number
* It multiplies A and B
* Result is a 4-bit signed number

* Team Members:
* 1) Omar Mahmoud Demerdash Sayed (1220134)
* 2) Mostafa Tamer Mostafa (1220202)
* 3) Abdel Rahman Ayman Amin (4220123)
* 4) Noha Wael Ibrahim (1190535)

? TO RUN THE TESTBENCH
? vsim mul_tb -c -do "run -all"
=======================================================
*/
`timescale 1ns/100ps
module mul_tb;

    reg [2:0] A;
    reg [2:0] B;
    wire [4:0] res;
    wire Z;
    integer fd;

    mul DUT
    (
        .i_A(A),
        .i_B(B),
        .o_res(res),
        .o_Z(Z)
    );

    integer i,j;
    initial begin
        fd = $fopen("mult.txt", "w");
        $display("          =========== Multiplication ===========          ");
        //*FOR loop that iterates first Number A from 3 to 1 with sign bit 1
        for(i=3;i>0;i=i-1)begin
            A[2]=1; //sets sign bit of first Number to 1
            A[1:0]=i[1:0];
            /*FOR loop that iterates second Number B from 3 to 1 with sign bit 1*/
            for(j=3;j>0;j=j-1)begin
                B[2]=1; //sets sign bit of second Number to 1
                B[1:0]=j[1:0];
                #20;
                if (res[3:0]==A[1:0]*B[1:0] && A[2]==B[2] && res[4]==0) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end
            end
            /*FOR loop that iterates second Number B from 0 to 3 with sign bit 0*/
            for(j=0;j<=3;j=j+1)begin
                B[2]=0; //sets sign bit of second Number to 0
                B[1:0]=j[1:0];
                #20;
                if (res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[3:0]!=0 && res[4]==1) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end else if (res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[3:0]==0 && res[4]==0) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end else if(res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[4]==1) begin // Added for Negative Zero Case
                    $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end
            end
        end

        //*FOR loop that iterates first Number A from 0 to 3 with sign bit 0
        for(i=0;i<=3;i=i+1)begin
            A[2]=0; //sets sign bit of first Number to 0
            A[1:0]=i[1:0];
            /*FOR loop that iterates second Number B from 3 to 1 with sign bit 1*/
            for(j=3;j>0;j=j-1)begin
                B[2]=1; //sets sign bit of second Number to 1
                B[1:0]=j[1:0];
                #20;
                if (res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[3:0]!=0 && res[4]==1) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end else if (res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[3:0]==0 && res[4]==0) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end else if(res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[4]==1) begin // Added for Negative Zero Case
                    $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end
            end
            /*FOR loop that iterates second Number B from 0 to 3 with sign bit 0*/
            for(j=0;j<=3;j=j+1)begin
                B[2]=0; //sets sign bit of second Number to 0
                B[1:0]=j[1:0];
                #20;
                if (res[3:0]==A[1:0]*B[1:0] && A[2]==B[2] && res[4]==0) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                    $display("Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],Z);
                end
            end
        end
        $fclose(fd);
        $finish();
    end
endmodule