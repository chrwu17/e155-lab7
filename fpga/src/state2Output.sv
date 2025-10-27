// Christian Wu
// chrwu@g.hmc.edu
// 10/23/25

/////////////////////////////////////////////
// state2Output
// state2Output converts the 4 x 4 array of bytes into a 128 bit output
/////////////////////////////////////////////

typedef logic [0:3][0:3] [7:0] aes_state_t;

module state2Output(input aes_state_t aes_state,
                    output  logic [127:0] out);
    genvar r, c;
    generate
        for (c = 0; c < 4; c++) begin
            for (r = 0; r < 4; r++) begin
                assign out[127 - 8*(4*c + r) -: 8] = aes_state[r][c];
            end
        end
    endgenerate
endmodule
