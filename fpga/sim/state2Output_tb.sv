// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// state2Output_tb
// Tests the state2Output module with a sample test case
/////////////////////////////////////////////
module state2Output_tb();
    logic [0:3][0:3][7:0] aes_state;
    logic [127:0] out, expected;
    
    state2Output dut(aes_state, out);
    
    initial begin
        aes_state[0][0] = 8'h32; aes_state[0][1] = 8'h88; aes_state[0][2] = 8'h31; aes_state[0][3] = 8'he0;
        aes_state[1][0] = 8'h43; aes_state[1][1] = 8'h5a; aes_state[1][2] = 8'h31; aes_state[1][3] = 8'h37;
        aes_state[2][0] = 8'hf6; aes_state[2][1] = 8'h30; aes_state[2][2] = 8'h98; aes_state[2][3] = 8'h07;
        aes_state[3][0] = 8'ha8; aes_state[3][1] = 8'h8d; aes_state[3][2] = 8'ha2; aes_state[3][3] = 8'h34;
        
        expected = 128'h3243f6a8885a308d313198a2e0370734;
        
        #10;
        if (out !== expected) $display("Error: out=%h, expected=%h", out, expected);
        else $display("Testbench completed successfully");
        $stop();
    end
endmodule