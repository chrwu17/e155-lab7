// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// subBytes_tb
// Tests the subBytes module with a sample test case
/////////////////////////////////////////////
module subBytes_tb();
    logic clk;
    logic [0:3][0:3][7:0] s, sPrime;
    
    subBytes dut(clk, s, sPrime);
    
    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    
    initial begin
        // Test input
        s[0][0] = 8'h19; s[0][1] = 8'ha0; s[0][2] = 8'h9a; s[0][3] = 8'he9;
        s[1][0] = 8'h3d; s[1][1] = 8'hf4; s[1][2] = 8'hc6; s[1][3] = 8'hf8;
        s[2][0] = 8'he3; s[2][1] = 8'he2; s[2][2] = 8'h8d; s[2][3] = 8'h48;
        s[3][0] = 8'hbe; s[3][1] = 8'h2b; s[3][2] = 8'h2a; s[3][3] = 8'h08;
        
        #10; // Wait for sync sbox
        #10;
        $display("Testbench completed successfully");
        $stop();
    end
endmodule