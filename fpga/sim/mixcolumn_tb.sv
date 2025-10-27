// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// mixcolumn_tb
// Tests the mixcolumn module with sample cases
/////////////////////////////////////////////
module mixcolumn_tb();
    logic [31:0] a, y, expected;
    
    mixcolumn dut(a, y);
    
    initial begin
        a = 32'hdb135345; expected = 32'h8e4da1bc; #10;
        if (y !== expected) $display("Error: a=%h, y=%h, expected=%h", a, y, expected);
        
        a = 32'hf20a225c; expected = 32'h9fdc589d; #10;
        if (y !== expected) $display("Error: a=%h, y=%h, expected=%h", a, y, expected);
        
        $display("Testbench completed successfully");
        $stop();
    end
endmodule