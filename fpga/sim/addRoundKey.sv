// Christian Wu
// chrwu@g.hmc.edu
// 10/23/25

/////////////////////////////////////////////
// addRoundKey
// ADDROUNDKEY() is a transformation of the state in which a round key is combined with the
// state by applying the bitwise XOR operation.
// FIPS-197 Section 5.1.4
/////////////////////////////////////////////

typedef logic [0:3][0:3] [7:0] aes_state_t;

module addRoundKey(input aes_state_t s,
                    input aes_state_t key,
                    output aes_state_t sPrime);
    genvar r,c;
    generate
        for (r = 0; r < 4; r++) begin
            for (c = 0; c < 4; c++) begin
                assign sPrime[r][c] = s[r][c] ^ key[r][c];
            end
        end
    endgenerate

endmodule