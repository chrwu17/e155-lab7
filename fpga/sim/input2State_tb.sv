// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// input2State_tb
// Test the input2State module with sample test cases
/////////////////////////////////////////////
module input2State_tb();
    logic [127:0] in;
    logic [0:3][0:3][7:0] aes_state;
    
    input2State dut(in, aes_state);
    
    initial begin
        // Test case 1: FIPS-197 plaintext
        in = 128'h3243f6a8885a308d313198a2e0370734;
        #10;
        
        // Check column 0 (bits [127:96] = 3243f6a8)
        assert(aes_state[0][0] == 8'h32) else $error("aes_state[0][0]=%h, expected 32", aes_state[0][0]);
        assert(aes_state[1][0] == 8'h43) else $error("aes_state[1][0]=%h, expected 43", aes_state[1][0]);
        assert(aes_state[2][0] == 8'hf6) else $error("aes_state[2][0]=%h, expected f6", aes_state[2][0]);
        assert(aes_state[3][0] == 8'ha8) else $error("aes_state[3][0]=%h, expected a8", aes_state[3][0]);
        
        // Check column 1 (bits [95:64] = 885a308d)
        assert(aes_state[0][1] == 8'h88) else $error("aes_state[0][1]=%h, expected 88", aes_state[0][1]);
        assert(aes_state[1][1] == 8'h5a) else $error("aes_state[1][1]=%h, expected 5a", aes_state[1][1]);
        assert(aes_state[2][1] == 8'h30) else $error("aes_state[2][1]=%h, expected 30", aes_state[2][1]);
        assert(aes_state[3][1] == 8'h8d) else $error("aes_state[3][1]=%h, expected 8d", aes_state[3][1]);
        
        // Check column 2 (bits [63:32] = 313198a2)
        assert(aes_state[0][2] == 8'h31) else $error("aes_state[0][2]=%h, expected 31", aes_state[0][2]);
        assert(aes_state[1][2] == 8'h31) else $error("aes_state[1][2]=%h, expected 31", aes_state[1][2]);
        assert(aes_state[2][2] == 8'h98) else $error("aes_state[2][2]=%h, expected 98", aes_state[2][2]);
        assert(aes_state[3][2] == 8'ha2) else $error("aes_state[3][2]=%h, expected a2", aes_state[3][2]);
        
        // Check column 3 (bits [31:0] = e0370734)
        assert(aes_state[0][3] == 8'he0) else $error("aes_state[0][3]=%h, expected e0", aes_state[0][3]);
        assert(aes_state[1][3] == 8'h37) else $error("aes_state[1][3]=%h, expected 37", aes_state[1][3]);
        assert(aes_state[2][3] == 8'h07) else $error("aes_state[2][3]=%h, expected 07", aes_state[2][3]);
        assert(aes_state[3][3] == 8'h34) else $error("aes_state[3][3]=%h, expected 34", aes_state[3][3]);
        
        // Test case 2: All zeros
        in = 128'h0;
        #10;
        assert(aes_state == '0) else $error("All zeros test failed");
        
        // Test case 3: All ones
        in = 128'hffffffffffffffffffffffffffffffff;
        #10;
        assert(aes_state == '1) else $error("All ones test failed");
        
        $display("input2State_tb completed successfully");
        $stop();
    end
endmodule