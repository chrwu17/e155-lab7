// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// galoismult_tb
// Tests the galoismult module with sample cases
/////////////////////////////////////////////
module galoismult_tb();
    logic [7:0] a, y, expected;
    
    galoismult dut(a, y);
    
    initial begin
        // Test case 1: 0x57 * x = 0xAE
        a = 8'h57; expected = 8'hAE; #10;
        if (y !== expected) $display("Error: a=%h, y=%h, expected=%h", a, y, expected);
        
        // Test case 2: 0xAE * x = 0x47 (overflow case)
        a = 8'hAE; expected = 8'h47; #10;
        if (y !== expected) $display("Error: a=%h, y=%h, expected=%h", a, y, expected);
        
        // Test case 3: 0x00 * x = 0x00
        a = 8'h00; expected = 8'h00; #10;
        if (y !== expected) $display("Error: a=%h, y=%h, expected=%h", a, y, expected);
        
        $display("Testbench completed successfully");
        $stop();
    end
endmodule