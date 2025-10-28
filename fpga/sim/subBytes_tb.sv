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
    logic [0:3][0:3][7:0] s, sPrime, expected;
    
    subBytes dut(clk, s, sPrime);
    
    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    
    initial begin
        s[0][0] = 8'h19; s[0][1] = 8'ha0; s[0][2] = 8'h9a; s[0][3] = 8'he9;
        s[1][0] = 8'h3d; s[1][1] = 8'hf4; s[1][2] = 8'hc6; s[1][3] = 8'hf8;
        s[2][0] = 8'he3; s[2][1] = 8'he2; s[2][2] = 8'h8d; s[2][3] = 8'h48;
        s[3][0] = 8'hbe; s[3][1] = 8'h2b; s[3][2] = 8'h2a; s[3][3] = 8'h08;
        
        
        expected[0][0] = 8'hd4; expected[0][1] = 8'he0; expected[0][2] = 8'hb8; expected[0][3] = 8'h1e;
        expected[1][0] = 8'h27; expected[1][1] = 8'hbf; expected[1][2] = 8'hb4; expected[1][3] = 8'h41;
        expected[2][0] = 8'h11; expected[2][1] = 8'h98; expected[2][2] = 8'h5d; expected[2][3] = 8'h52;
        expected[3][0] = 8'hae; expected[3][1] = 8'hf1; expected[3][2] = 8'he5; expected[3][3] = 8'h30;
        
        #10;
        
        assert(sPrime[0][0] == expected[0][0]) else $error("sPrime[0][0]=%h, expected %h", sPrime[0][0], expected[0][0]);
        assert(sPrime[0][1] == expected[0][1]) else $error("sPrime[0][1]=%h, expected %h", sPrime[0][1], expected[0][1]);
        assert(sPrime[0][2] == expected[0][2]) else $error("sPrime[0][2]=%h, expected %h", sPrime[0][2], expected[0][2]);
        assert(sPrime[0][3] == expected[0][3]) else $error("sPrime[0][3]=%h, expected %h", sPrime[0][3], expected[0][3]);
        
        assert(sPrime[1][0] == expected[1][0]) else $error("sPrime[1][0]=%h, expected %h", sPrime[1][0], expected[1][0]);
        assert(sPrime[1][1] == expected[1][1]) else $error("sPrime[1][1]=%h, expected %h", sPrime[1][1], expected[1][1]);
        assert(sPrime[1][2] == expected[1][2]) else $error("sPrime[1][2]=%h, expected %h", sPrime[1][2], expected[1][2]);
        assert(sPrime[1][3] == expected[1][3]) else $error("sPrime[1][3]=%h, expected %h", sPrime[1][3], expected[1][3]);
        
        assert(sPrime[2][0] == expected[2][0]) else $error("sPrime[2][0]=%h, expected %h", sPrime[2][0], expected[2][0]);
        assert(sPrime[2][1] == expected[2][1]) else $error("sPrime[2][1]=%h, expected %h", sPrime[2][1], expected[2][1]);
        assert(sPrime[2][2] == expected[2][2]) else $error("sPrime[2][2]=%h, expected %h", sPrime[2][2], expected[2][2]);
        assert(sPrime[2][3] == expected[2][3]) else $error("sPrime[2][3]=%h, expected %h", sPrime[2][3], expected[2][3]);
        
        assert(sPrime[3][0] == expected[3][0]) else $error("sPrime[3][0]=%h, expected %h", sPrime[3][0], expected[3][0]);
        assert(sPrime[3][1] == expected[3][1]) else $error("sPrime[3][1]=%h, expected %h", sPrime[3][1], expected[3][1]);
        assert(sPrime[3][2] == expected[3][2]) else $error("sPrime[3][2]=%h, expected %h", sPrime[3][2], expected[3][2]);
        assert(sPrime[3][3] == expected[3][3]) else $error("sPrime[3][3]=%h, expected %h", sPrime[3][3], expected[3][3]);
        
        // Overall check
        assert(sPrime == expected) else $error("subBytes output mismatch");
        
        $display("Testbench completed successfully");
        $stop();
    end
endmodule