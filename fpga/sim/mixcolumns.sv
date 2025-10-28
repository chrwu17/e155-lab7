// Christian Wu
// chrwu@g.hmc.edu
// 10/23/25

/////////////////////////////////////////////
// mixcolumns
//   Even funkier action on columns
//   Section 5.1.3, Figure 9
//   Same operation performed on each of four columns
/////////////////////////////////////////////

typedef logic [0:3][0:3][7:0] aes_state_t;

module mixcolumns (input aes_state_t a,
                   output aes_state_t y);
    logic [31:0] col_y [0:3];

    genvar c;
    generate
        for (c = 0; c < 4; c++) begin : G_COL
            mixcolumn mc (.a({ a[0][c], a[1][c], a[2][c], a[3][c] }), .y(col_y[c]));
        assign { y[0][c], y[1][c], y[2][c], y[3][c] } = col_y[c];
        end
    endgenerate
endmodule
