// Christian Wu
// chrwu@g.hmc.edu
// 10/23/25

/////////////////////////////////////////////
// keyExpansion
// Section 5.2 of FIPS-197
// Generate key for each round
/////////////////////////////////////////////

module keyExpansion(input logic clk,
                    input logic [127:0] key,       
                    input logic [31:0] rcon,   
                    output logic [127:0] roundKey );

    logic [31:0] key0, key1, key2, key3;
    assign {key0, key1, key2, key3} = key;

    logic [31:0] rotKey, subKey;
    rotWord rotWord1(.a(key3),  .y(rotKey));
    subWord subWord1(.clk(clk), .a(rotKey), .y(subKey)); 

    logic [31:0] rcon_d1;
    always_ff @(posedge clk) begin
        rcon_d1 <= rcon;
    end

    logic [31:0] t, nw0, nw1, nw2, nw3;
    always_comb begin
        t   = subKey ^ rcon_d1;
        nw0 = key0 ^ t;
        nw1 = key1 ^ nw0;
        nw2 = key2 ^ nw1;
        nw3 = key3 ^ nw2;
    end

    // Register final next-round key
    always_ff @(posedge clk) begin
        roundKey <= {nw0, nw1, nw2, nw3};
    end
endmodule

