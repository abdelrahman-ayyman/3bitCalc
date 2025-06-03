/*
=======================================================
* 3-bit Arithmetic Unit Calculator Testbench

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

? TO RUN THE TESTBENCH
? vsim alu_tb -c -do "run -all"
=======================================================
*/
`timescale 1ns/100ps
module alu_tb;

    reg [2:0] A;
    reg [2:0] B;
    reg [1:0] op;
    wire [4:0] res;
    wire DZF;
    wire ZF;
    wire SF;
    integer fd;

    alu DUT
    (
        .op(op),
        .A(A),
        .B(B),
        .result(res),
        .DZF(DZF),
        .ZF(ZF),
        .SF(SF)
    );

    integer i,j,k;
    initial begin
        fd = $fopen("alu.txt", "w");
        $display("        ================= ALU =================         ");
        //*FOR loop that iterates first Number A from 3 to 1 with sign bit 1
        for(i=3;i>0;i=i-1)begin
            A[2]=1; //sets sign bit of first Number to 1
            A[1:0]=i[1:0];
            /*FOR loop that iterates second Number B from 3 to 1 with sign bit 1*/
            for(j=3;j>0;j=j-1)begin
                B[2]=1; //sets sign bit of second Number to 1
                B[1:0]=j[1:0];
                #20;
                for (k=0;k<=3;k=k+1) begin
                    op=k;
                    case (op)
                    2'b00:  begin
                            /*Multiplication*/
                            #20;
                            if (res[3:0]==A[1:0]*B[1:0] && A[2]==B[2] && res[4]==0) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    2'b01:  begin
                            /*Remainder*/
                            #20;
                            if (res[1:0]==A[1:0]%B[1:0] && res[4]==A[2] && DZF==0) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end else if (res[2]==A[2] && DZF==1) begin //Checks Division By Zero
                                $fdisplay(fd,"Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Fail A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end
                            end
                    2'b10:  begin
                            /*Addition*/
                            #20;
                            if (res[2:0]==A[1:0]+B[1:0] && A[2]==B[2]) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    2'b11:  begin
                            /*Subtraction*/
                            #20;
                            if (res[2:0]==A[1:0]-B[1:0] && A[2]==B[2]) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else if (res[2:0]==B[1:0]-A[1:0] && A[2]==B[2]) begin//for case {110 - 111 = 0001 (ZF = 0)}
                                $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    endcase
                end
            end
            /*FOR loop that iterates second Number B from 0 to 3 with sign bit 0*/
            for(j=0;j<=3;j=j+1)begin
                B[2]=0; //sets sign bit of second Number to 0
                B[1:0]=j[1:0];
                #20;
                for (k=0;k<=3;k=k+1) begin
                    op=k;
                    case (op)
                    2'b00:  begin
                            /*Multiplication*/
                            #20;
                            if (res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[3:0]!=0 && res[4]==1) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else if (res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[3:0]==0 && res[4]==0) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else if(res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[4]==1) begin // Added for Negative Zero Case
                                $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    2'b01:  begin
                            /*Remainder*/
                            #20
                            if (res[1:0]==A[1:0]%B[1:0] && res[4]==A[2] && DZF==0) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end else if (res[4]==A[2] && DZF==1) begin //Checks Division By Zero
                                $fdisplay(fd,"Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Fail A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end
                            end
                    2'b10:  begin
                            /*Addition*/
                            #20;
                            if (res[2:0]==A[1:0]+B[1:0] && A[2]!=B[2]) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else if (res[2:0]==A[1:0]-B[1:0] && A[2]!=B[2]) begin //Problem if we add without sign bit res will always be wrong so we check difference
                                $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else if (res[2:0]==B[1:0]-A[1:0] && A[2]!=B[2]) begin // for case {110 + 011 = 0001 (ZF = 0)}
                                $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    2'b11:  begin
                            /*Subtraction*/
                            #20;
                            if (res[2:0]==A[1:0]+B[1:0] && A[2]!=B[2]) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    endcase
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
                for (k=0;k<=3;k=k+1) begin
                    op=k;
                    case (op)
                    2'b00:  begin
                            /*Multiplication*/
                            #20;
                            if (res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[3:0]!=0 && res[4]==1) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else if (res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[3:0]==0 && res[4]==0) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else if(res[3:0]==A[1:0]*B[1:0] && A[2]!=B[2] && res[4]==1) begin // Added for Negative Zero Case
                                $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    2'b01:  begin
                            /*Remainder*/
                            #20;
                            if (res[1:0]==A[1:0]%B[1:0] && res[4]==A[2] && DZF==0) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end else if (res[4]==A[2] && DZF==1) begin //Checks Division By Zero
                                $fdisplay(fd,"Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Fail A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end
                            end
                    2'b10:  begin
                            /*Addition*/
                            #20;
                            if (res[2:0]==A[1:0]+B[1:0] && A[2]!=B[2]) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else if (res[2:0]==B[1:0]-A[1:0] && A[2]!=B[2]) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else if (res[2:0]==A[1:0]-B[1:0] && A[2]!=B[2]) begin // for case {010 + 101 = 0001 (ZF = 0)} 
                                $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    2'b11:  begin
                            /*Subtraction*/
                            #20;
                            if (res[2:0]==A[1:0]+B[1:0] && A[2]!=B[2]) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    endcase
                end
            end
            /*FOR loop that iterates second Number B from 0 to 3 with sign bit 0*/
            for(j=0;j<=3;j=j+1)begin
                B[2]=0; //sets sign bit of second Number to 0
                B[1:0]=j[1:0];
                #20;
                for (k=0;k<=3;k=k+1) begin
                    op=k;
                    case (op)
                    2'b00:  begin
                            /*Multiplication*/
                            #20;
                            if (res[3:0]==A[1:0]*B[1:0] && A[2]==B[2] && res[4]==0) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A x B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    2'b01:  begin
                            /*Remainder*/
                            #20;
                            if (res[1:0]==A[1:0]%B[1:0] && res[4]==A[2] && DZF==0) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end else if (res[4]==A[2] && DZF==1) begin //Checks Division By Zero
                                $fdisplay(fd,"Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Pass A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                                $display("Fail A=%b , B=%b | A %% B = result = %b | SF = %b, ZF = %b, DZF = %b",A,B,res,res[4],ZF,DZF);
                            end
                            end
                    2'b10:  begin
                            /*Addition*/
                            #20;
                            if (res[2:0]==A[1:0]+B[1:0] && A[2]==B[2]) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A + B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    2'b11:  begin
                            /*Subtraction*/
                            #20;
                            if (res[2:0]==A[1:0]+B[1:0] && A[2]==B[2]) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else if (res[2:0]==B[1:0]-A[1:0] && A[2]==B[2]) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else if (res[2:0]==A[1:0]-B[1:0] && A[2]==B[2]) begin
                                $fdisplay(fd,"Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Pass A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end else begin
                                $fdisplay(fd,"Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                                $display("Fail A=%b , B=%b | A - B = result = %b | SF = %b, ZF = %b",A,B,res,res[4],ZF);
                            end
                            end
                    endcase
                end
                
            end
        end
        $fclose(fd);
        $finish();
    end
endmodule