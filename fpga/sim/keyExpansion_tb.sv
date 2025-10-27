// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// keyExpansion_tb
// Tests keyExpansion with sample test case
/////////////////////////////////////////////
module keyExpansion_tb();
    logic clk;
    logic [127:0] key, roundKey;
    logic [31:0] rcon;
    
    keyExpansion dut(clk, key, rcon, roundKey);
    
    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    
    initial begin
        // Test case from FIPS-197 Appendix A.1
        // Key: 2b7e151628aed2a6abf7158809cf4f3c
        // Round 1 key should be: a0fafe1788542cb123a339392a6c7605
        
        key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
        rcon = 32'h01000000;
        
        #30; 
        
        assert(roundKey == 128'ha0fafe1788542cb123a339392a6c7605)
            else $error("Round 1 key failed: roundKey=%h, expected=a0fafe1788542cb123a339392a6c7605", roundKey);
        
        // Test round 2
        key = 128'ha0fafe1788542cb123a339392a6c7605;
        rcon = 32'h02000000;
        
        #30;
        assert(roundKey == 128'hf2c295f27a96b9435935807a7359f67f)
            else $error("Round 2 key failed: roundKey=%h, expected=f2c295f27a96b9435935807a7359f67f", roundKey);
        
        $display("Testbench completed successfully");
        $stop();
    end
endmodule