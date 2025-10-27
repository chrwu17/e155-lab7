// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// sbox_tb
// Tests the sbox module with sample case
/////////////////////////////////////////////
module sbox_tb();
    logic [7:0] a, y, expected;
    
    sbox dut(a, y);
    
    initial begin
        a = 8'h00; expected = 8'h63; #10;
        if (y !== expected) $display("Error: a=%h, y=%h, expected=%h", a, y, expected);
        
        a = 8'h53; expected = 8'hed; #10;
        if (y !== expected) $display("Error: a=%h, y=%h, expected=%h", a, y, expected);
        
        a = 8'hFF; expected = 8'h16; #10;
        if (y !== expected) $display("Error: a=%h, y=%h, expected=%h", a, y, expected);
        
        $display("Testbench completed successfully");
        $stop();
    end
endmodule