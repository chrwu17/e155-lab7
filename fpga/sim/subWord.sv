// Christian Wu
// chrwu@g.hmc.edu
// 10/24/25

/////////////////////////////////////////////
// subWord
// Does sbox substitution for keyExpansion. Module to be called by keyExpansion
// FIPS-197 Section 5.2
/////////////////////////////////////////////

module subWord(input logic clk,
               input logic [31:0] a,
               output logic [31:0] y);
  genvar i;
  generate
    for (i = 0; i < 4; i++) begin : sb_loop
      sbox_sync sbox_inst (.a(a[31 - 8*i -: 8]), .clk(clk), .y(y[31 - 8*i -: 8]));
    end
  endgenerate
endmodule
