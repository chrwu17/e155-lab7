// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// addRoundKey_tb
// Tests the addRoundKey module
/////////////////////////////////////////////
module addRoundKey_tb();
    logic [0:3][0:3][7:0] s, key, sPrime, expected;
    
    addRoundKey dut(s, key, sPrime);
    
    initial begin
        // Test case
        s[0][0] = 8'h32; s[0][1] = 8'h88; s[0][2] = 8'h31; s[0][3] = 8'he0;
        s[1][0] = 8'h43; s[1][1] = 8'h5a; s[1][2] = 8'h31; s[1][3] = 8'h37;
        s[2][0] = 8'hf6; s[2][1] = 8'h30; s[2][2] = 8'h98; s[2][3] = 8'h07;
        s[3][0] = 8'ha8; s[3][1] = 8'h8d; s[3][2] = 8'ha2; s[3][3] = 8'h34;
        
        key[0][0] = 8'h2b; key[0][1] = 8'h28; key[0][2] = 8'hab; key[0][3] = 8'h09;
        key[1][0] = 8'h7e; key[1][1] = 8'hae; key[1][2] = 8'hf7; key[1][3] = 8'hcf;
        key[2][0] = 8'h15; key[2][1] = 8'hd2; key[2][2] = 8'h15; key[2][3] = 8'h4f;
        key[3][0] = 8'h16; key[3][1] = 8'ha6; key[3][2] = 8'h88; key[3][3] = 8'h3c;
        
        expected[0][0] = 8'h19; expected[0][1] = 8'ha0; expected[0][2] = 8'h9a; expected[0][3] = 8'he9;
        expected[1][0] = 8'h3d; expected[1][1] = 8'hf4; expected[1][2] = 8'hc6; expected[1][3] = 8'hf8;
        expected[2][0] = 8'he3; expected[2][1] = 8'he2; expected[2][2] = 8'h8d; expected[2][3] = 8'h48;
        expected[3][0] = 8'hbe; expected[3][1] = 8'h2b; expected[3][2] = 8'h2a; expected[3][3] = 8'h08;
        
        #10;
        if (sPrime !== expected) $display("Error in addRoundKey");
        else $display("Test completed successfully");
        $stop();
    end
endmodule