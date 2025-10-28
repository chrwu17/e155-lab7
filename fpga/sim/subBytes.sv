// Christian Wu
// chrwu@g.hmc.edu
// 10/23/25

/////////////////////////////////////////////
// subBytes
// SUBBYTES() is an invertible, non-linear transformation of the state in which a substitution table,
// called an S-box, is applied independently to each byte in the state. The AES S-box is denoted by
// SBOX(). 
// FIPS-197 Section 5.1.1
/////////////////////////////////////////////

typedef logic [0:3][0:3] [7:0] aes_state_t;

module subBytes(input logic clk,
                input aes_state_t s,
                output aes_state_t sPrime);
    genvar r, c;
    generate
        for (r = 0; r < 4; r++) begin
            for (c = 0; c < 4; c++) begin
                sbox_sync sboxRun(.a(s[r][c]), .clk(clk), .y(sPrime[r][c]));
            end
        end
    endgenerate
endmodule