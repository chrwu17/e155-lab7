// Christian Wu
// chrwu@g.hmc.edu
// 10/24/25

/////////////////////////////////////////////
// rotWord
// rotates the 32 bit input for use in KeyExpansion
// FIPS-197 Section 5.2
/////////////////////////////////////////////

module rotWord(input logic [31:0] a,
               output logic [31:0] y);
    logic [7:0] a0, a1, a2, a3;
    
    assign {a0, a1, a2, a3} = a;
    assign y = {a1, a2, a3, a0};
endmodule