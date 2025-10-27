// Christian Wu
// chrwu@g.hmc.edu
// 10/23/25

/////////////////////////////////////////////
// input2State
// input2State converts the 128 bit input into a 4 x 4 array of bytes
/////////////////////////////////////////////

typedef logic [0:3][0:3] [7:0] aes_state_t;

module input2State(input  logic [127:0] in,
                   output aes_state_t   aes_state);
    genvar r, c;
    generate
        for (c = 0; c < 4; c++) begin
            for (r = 0; r < 4; r++) begin
                assign aes_state[r][c] = in[127 - 8*(4*c + r) -: 8];
            end
        end
    endgenerate
endmodule
