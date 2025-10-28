// Christian Wu
// chrwu@g.hmc.edu
// 10/23/25

/////////////////////////////////////////////
// shiftRows
// SHIFTROWS() is a transformation of the state in which the bytes in the last three rows of the state
// are cyclically shifted. The number of positions by which the bytes are shifted depends on the row
// index r
// FIPS-197 Section 5.1.2
/////////////////////////////////////////////

typedef logic [0:3][0:3] [7:0] aes_state_t;

module shiftRows(input aes_state_t s,
                 output aes_state_t sPrime);
    genvar r, c;
    generate
        for (r = 0; r < 4; r++) begin
            for (c = 0; c < 4; c++) begin
                assign sPrime[r][c] = s[r][(c + r) % 4];
            end
        end       
    endgenerate
endmodule