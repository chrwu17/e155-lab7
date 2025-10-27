// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// rotWord_tb
// Tests the rotWord module with sample case
/////////////////////////////////////////////
module rotWord_tb();
    logic [31:0] a, y, expected;
    
    rotWord dut(a, y);
    
    initial begin
        // Test case: [09cf4f3c] rotates to [cf4f3c09]
        a = 32'h09cf4f3c; expected = 32'hcf4f3c09; #10;
        if (y !== expected) $display("Error: a=%h, y=%h, expected=%h", a, y, expected);
        
        a = 32'h12345678; expected = 32'h34567812; #10;
        if (y !== expected) $display("Error: a=%h, y=%h, expected=%h", a, y, expected);
        
        $display("Testbench completed successfully");
        $stop();
    end
endmodule