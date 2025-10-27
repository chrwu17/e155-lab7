// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// subWord_tb
// Tests the subWord module with a sample test case
/////////////////////////////////////////////
module subWord_tb();
    logic clk;
    logic [31:0] a, y;
    
    subWord dut(clk, a, y);
    
    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    
    initial begin
        // Test case 1: After rotWord from key expansion
        // Input: cf4f3c09 -> Expected: 8a84eb01 (each byte through S-box)
        a = 32'hcf4f3c09; 
        #10; // Wait for one clock cycle (synchronous S-box)
        assert(y == 32'h8a84eb01) 
            else $error("Test 1 failed: a=%h, y=%h, expected=8a84eb01", a, y);
        
        // Test case 2: Another word
        a = 32'h00112233;
        #10;
        assert(y == 32'h637c777b)
            else $error("Test 2 failed: a=%h, y=%h, expected=637c777b", a, y);
        
        // Test case 3: All zeros
        a = 32'h00000000;
        #10;
        assert(y == 32'h63636363)
            else $error("Test 3 failed: a=%h, y=%h, expected=63636363", a, y);
        
        $display("Testbench completed successfully");
        $stop();
    end
endmodule