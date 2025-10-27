// Christian Wu
// chrwu@g.hmc.edu
// 10/23/25

/////////////////////////////////////////////
// aes_core
//   top level AES encryption module
//   when load is asserted, takes the current key and plaintext
//   generates cyphertext and asserts done when complete 11 cycles later
// 
//   See FIPS-197 with Nk = 4, Nb = 4, Nr = 10
//
//   The key and message are 128-bit values packed into an array of 16 bytes as
//   shown below
//        [127:120] [95:88] [63:56] [31:24]     S0,0    S0,1    S0,2    S0,3
//        [119:112] [87:80] [55:48] [23:16]     S1,0    S1,1    S1,2    S1,3
//        [111:104] [79:72] [47:40] [15:8]      S2,0    S2,1    S2,2    S2,3
//        [103:96]  [71:64] [39:32] [7:0]       S3,0    S3,1    S3,2    S3,3
//
//   Equivalently, the values are packed into four words as given
//        [127:96]  [95:64] [63:32] [31:0]      w[0]    w[1]    w[2]    w[3]
/////////////////////////////////////////////

typedef logic [0:3][0:3] [7:0] aes_state_t;

module aes_core(input  logic         clk, 
                input  logic         load,
                input  logic [127:0] key, 
                input  logic [127:0] plaintext, 
                output logic         done, 
                output logic [127:0] cyphertext);

    logic [3:0] round;
    aes_state_t subBytesDone;
    aes_state_t shiftRowsDone;
    aes_state_t mixColumnsDone;
    logic [127:0] keyExpansionDone;
    aes_state_t keyState;
    aes_state_t bypassMuxResult;
    aes_state_t addRoundKeyDone;

    aes_state_t plainTextState;

    aes_state_t currentState;
    logic [31:0] rcon;


    typedef enum logic [2:0] {
        s0, s1, s2, s3, s4
    } state_t;

    state_t state, nextState;

    input2State input2State1(.in(plaintext), .aes_state(plainTextState));
    subBytes subBytes1(.clk(clk), .s(currentState), .sPrime(subBytesDone));
    shiftRows shiftRows1(.s(subBytesDone), .sPrime(shiftRowsDone));
    mixcolumns mixcolumns1(.a(shiftRowsDone), .y(mixColumnsDone));
    keyExpansion keyExpansion1(.clk(clk), .key(key), .rcon(rcon), .roundKey(keyExpansionDone));
    input2State input2State2(.in(keyExpansionDone), .aes_state(keyState));
    addRoundKey addRoundKey1(.s(bypassMuxResult), .key(keyState), .sPrime(addRoundKeyDone));
    state2Output state2Output1(.aes_state(currentState), .out(cyphertext));

    always_ff @(posedge clk) begin
        if (load) begin
            state <= s0;
            round <= 0;
            done <= 0;
        end else begin
            state <= nextState;
            if (state == s2) round <= round + 1;
            if (state == s4) done <= 1;
        end
        if (state == s1) 
            currentState <= plainTextState;
        else if (state == s2 || state == s3)
            currentState <= addRoundKeyDone;
    end

    always_comb begin
        nextState = s0;
        bypassMuxResult = currentState;
        
        case (state)
            s0: begin
                if(load) nextState = s1;
                else nextState = s0;
                bypassMuxResult = currentState;
            end
            s1: begin
                nextState = s2;
                bypassMuxResult = currentState;
            end
            s2: begin
                if (round == 9) nextState = s3;
                else nextState = s2;
                bypassMuxResult = mixColumnsDone;
            end
            s3: begin
                nextState = s4;
                bypassMuxResult = shiftRowsDone;
            end
            s4: begin
                nextState = s0;
                bypassMuxResult = currentState;
            end
            default: begin
                nextState = s0;
                bypassMuxResult = currentState;
            end
        endcase
    end

    always_comb begin
        case (round)
            4'd0: rcon = 32'h01000000;
            4'd1: rcon = 32'h02000000;
            4'd2: rcon = 32'h04000000;
            4'd3: rcon = 32'h08000000;
            4'd4: rcon = 32'h10000000;
            4'd5: rcon = 32'h20000000;
            4'd6: rcon = 32'h40000000;
            4'd7: rcon = 32'h80000000;
            4'd8: rcon = 32'h1b000000;
            4'd9: rcon = 32'h36000000;
            default: rcon = 32'h00000000;
        endcase
    end
    
endmodule