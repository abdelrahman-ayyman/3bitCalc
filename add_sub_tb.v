/*
=======================================================
* 3-bit Signed Adder & Subtractor Testbench

* This module takes two 3-bit signed number A and B
* Sign bit = 1 means Negative number
* It adds A and B OR subtracts B from A
* Result is a 5-bit signed number

* Team Members:
* 1) Omar Mahmoud Demerdash Sayed (1220134)
* 2) Mostafa Tamer Mostafa (1220202)
* 3) Abdel Rahman Ayman Amin (4220123)
* 4) Noha Wael Ibrahim (1190535)

? TO RUN THE TESTBENCH
? vsim add_sub_tb -c -do "run -all"
=======================================================
*/
`timescale 1ns/100ps
module add_sub_tb;

    reg [2:0] A;
    reg [2:0] B;
    reg S;
    wire [3:0] res;
    wire Z;
    integer fd,fs;

    add_sub DUT
    (
        .i_A(A),
        .i_B(B),
        .i_S(S),
        .o_res(res),
        .o_Z(Z)
    );

    integer i,j;
    
    initial begin
        //* ==================================== Addition ==================================== *//
        $display("      ============== Addition ==============      ");
        fd=$fopen("add.txt","w");

        S=0;
        //*FOR loop that iterates first Number A from 3 to 1 with sign bit 1
        for(i=3;i>0;i=i-1)begin
            A[2]=1; //sets sign bit of first Number to 1
            A[1:0]=i[1:0];
            /*FOR loop that iterates second Number B from 3 to 1 with sign bit 1*/
            for(j=3;j>0;j=j-1)begin
                B[2]=1; //sets sign bit of second Number to 1
                B[1:0]=j[1:0];
                #20;
                if (res[2:0]==A[1:0]+B[1:0] && A[2]==B[2]) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end
            end
            /*FOR loop that iterates second Number B from 0 to 3 with sign bit 0*/
            for(j=0;j<=3;j=j+1)begin
                B[2]=0; //sets sign bit of second Number to 0
                B[1:0]=j[1:0];
                #20;
                if (res[2:0]==A[1:0]+B[1:0] && A[2]!=B[2]) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else if (res[2:0]==A[1:0]-B[1:0] && A[2]!=B[2]) begin //Problem if we add without sign bit res will always be wrong so we check difference
                    $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else if (res[2:0]==B[1:0]-A[1:0] && A[2]!=B[2]) begin // for case {110 + 011 = 0001 (ZF = 0)}
                    $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
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
                if (res[2:0]==A[1:0]+B[1:0] && A[2]!=B[2]) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else if (res[2:0]==B[1:0]-A[1:0] && A[2]!=B[2]) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else if (res[2:0]==A[1:0]-B[1:0] && A[2]!=B[2]) begin // for case {010 + 101 = 0001 (ZF = 0)} 
                    $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end
            end
            /*FOR loop that iterates second Number B from 0 to 3 with sign bit 0*/
            for(j=0;j<=3;j=j+1)begin
                B[2]=0; //sets sign bit of second Number to 0
                B[1:0]=j[1:0];
                #20;
                if (res[2:0]==A[1:0]+B[1:0] && A[2]==B[2]) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end
            end
        end
        $fclose(fd);


        //* ==================================== Subtraction ==================================== *//
        fs=$fopen("sub.txt","w");
        $display(" ");
        $display("      ============ Subtraction =============      ");
        S=1;
        //*FOR loop that iterates first Number A from 3 to 1 with sign bit 1
        for(i=3;i>0;i=i-1)begin
            A[2]=1; //sets sign bit of first Number to 1
            A[1:0]=i[1:0];
            /*FOR loop that iterates second Number B from 3 to 1 with sign bit 1*/
            for(j=3;j>0;j=j-1)begin
                B[2]=1; //sets sign bit of second Number to 1
                B[1:0]=j[1:0];
                #20;
                if (res[2:0]==A[1:0]-B[1:0] && A[2]==B[2]) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else if (res[2:0]==B[1:0]-A[1:0] && A[2]==B[2]) begin//for case {110 - 111 = 0001 (ZF = 0)}
                    $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end
            end
            /*FOR loop that iterates second Number B from 0 to 3 with sign bit 0*/
            for(j=0;j<=3;j=j+1)begin
                B[2]=0; //sets sign bit of second Number to 0
                B[1:0]=j[1:0];
                #20;
                if (res[2:0]==A[1:0]+B[1:0] && A[2]!=B[2]) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
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
                if (res[2:0]==A[1:0]+B[1:0] && A[2]!=B[2]) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end
            end
            /*FOR loop that iterates second Number B from 0 to 3 with sign bit 0*/
            for(j=0;j<=3;j=j+1)begin
                B[2]=0; //sets sign bit of second Number to 0
                B[1:0]=j[1:0];
                #20;
                if (res[2:0]==A[1:0]+B[1:0] && A[2]==B[2]) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else if (res[2:0]==B[1:0]-A[1:0] && A[2]==B[2]) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else if (res[2:0]==A[1:0]-B[1:0] && A[2]==B[2]) begin
                    $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end else begin
                    $fdisplay(fd,"Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                    $display("Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[3],Z);
                end
            end
        end
        $fclose(fs);
        $finish();
    end
endmodule