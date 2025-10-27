// Christian Wu
// chrwu@g.hmc.edu
// 10/26/25

`timescale 10ns/1ns

/////////////////////////////////////////////
// mixcolumns_tb
// Tests the mixcoumns module with sample case
/////////////////////////////////////////////
module mixcolumns_tb();
    logic [0:3][0:3][7:0] a, y, expected;
    
    mixcolumns dut(a, y);
    
    initial begin
        a[0][0] = 8'hd4; a[0][1] = 8'he0; a[0][2] = 8'hb8; a[0][3] = 8'h1e;
        a[1][0] = 8'hbf; a[1][1] = 8'hb4; a[1][2] = 8'h41; a[1][3] = 8'h27;
        a[2][0] = 8'h5d; a[2][1] = 8'h52; a[2][2] = 8'h11; a[2][3] = 8'h98;
        a[3][0] = 8'h30; a[3][1] = 8'hae; a[3][2] = 8'hf1; a[3][3] = 8'he5;
        
        expected[0][0] = 8'h04; expected[0][1] = 8'he0; expected[0][2] = 8'h48; expected[0][3] = 8'h28;
        expected[1][0] = 8'h66; expected[1][1] = 8'hcb; expected[1][2] = 8'hf8; expected[1][3] = 8'h06;
        expected[2][0] = 8'h81; expected[2][1] = 8'h19; expected[2][2] = 8'hd3; expected[2][3] = 8'h26;
        expected[3][0] = 8'he5; expected[3][1] = 8'h9a; expected[3][2] = 8'h7a; expected[3][3] = 8'h4c;
        
        #10;
        if (y !== expected) $display("Error in mixcolumns");
        else $display("Testbench completed successfully");
        $stop();
    end
endmodule