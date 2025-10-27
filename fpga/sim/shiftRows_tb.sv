// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// shiftRows_tb
// Tests the shiftRows module with sample case
/////////////////////////////////////////////
module shiftRows_tb();
    logic [0:3][0:3][7:0] s, sPrime, expected;
    
    shiftRows dut(s, sPrime);
    
    initial begin
        s[0][0] = 8'hd4; s[0][1] = 8'he0; s[0][2] = 8'hb8; s[0][3] = 8'h1e;
        s[1][0] = 8'h27; s[1][1] = 8'hbf; s[1][2] = 8'hb4; s[1][3] = 8'h41;
        s[2][0] = 8'h11; s[2][1] = 8'h98; s[2][2] = 8'h5d; s[2][3] = 8'h52;
        s[3][0] = 8'hae; s[3][1] = 8'hf1; s[3][2] = 8'he5; s[3][3] = 8'h30;
        
        expected[0][0] = 8'hd4; expected[0][1] = 8'he0; expected[0][2] = 8'hb8; expected[0][3] = 8'h1e;
        expected[1][0] = 8'hbf; expected[1][1] = 8'hb4; expected[1][2] = 8'h41; expected[1][3] = 8'h27;
        expected[2][0] = 8'h5d; expected[2][1] = 8'h52; expected[2][2] = 8'h11; expected[2][3] = 8'h98;
        expected[3][0] = 8'h30; expected[3][1] = 8'hae; expected[3][2] = 8'hf1; expected[3][3] = 8'he5;
        
        #10;
        if (sPrime !== expected) $display("Error in shiftRows");
        else $display("Testbench completed successfully");
        $stop();
    end
endmodule
