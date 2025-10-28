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
    logic [127:0] currentKey;
    aes_state_t subBytesDone;
    aes_state_t shiftRowsDone;
    aes_state_t mixColumnsDone;
    logic [127:0] keyExpansionDone;
    aes_state_t keyState;
    aes_state_t keyMuxOut;
    aes_state_t bypassMuxResult;
    aes_state_t addRoundKeyDone;
    aes_state_t plainTextState;
    aes_state_t currentState;
    aes_state_t initialKeyState;
    logic [31:0] rcon;

    typedef enum logic [3:0] {
        S0, S1, S2, S3, S4, S5, S6, S7, S8
    } state_t;

    state_t state, nextState;

    input2State input2State1(.in(plaintext), .aes_state(plainTextState));
    input2State input2StateKey(.in(key), .aes_state(initialKeyState));
    subBytes subBytes1(.clk(clk), .s(currentState), .sPrime(subBytesDone));
    shiftRows shiftRows1(.s(subBytesDone), .sPrime(shiftRowsDone));
    mixcolumns mixcolumns1(.a(shiftRowsDone), .y(mixColumnsDone));
    keyExpansion keyExpansion1(.clk(clk), .key(currentKey), .rcon(rcon), .roundKey(keyExpansionDone));
    input2State input2State2(.in(keyExpansionDone), .aes_state(keyState));
    addRoundKey addRoundKey1(.s(bypassMuxResult), .key(keyMuxOut), .sPrime(addRoundKeyDone));
    state2Output state2Output1(.aes_state(currentState), .out(cyphertext));

    always_ff @(posedge clk) begin
        if (load) begin
            state <= S0;
            round <= 0;
            done <= 0;
            currentKey <= key;
        end else begin
            state <= nextState;
        end
        
        case (state)
            S0: begin
                // Apply initial AddRoundKey with round 0 key
                currentState <= addRoundKeyDone;
            end
            S1: begin
                // Wait for SubBytes (1 cycle for sbox_sync)
            end
            S2: begin
                // Wait for KeyExpansion (1 cycle for subWord sbox)
            end
            S3: begin
                // Wait for final key expansion register
            end
            S4: begin
                // Capture expanded key and AddRoundKey done, round complete
                currentKey <= keyExpansionDone;
                currentState <= addRoundKeyDone;
                if (round < 9) round <= round + 1;
            end
            S5: begin
                // Final round SubBytes (wait 1 cycle)
            end
            S6: begin
                // Wait for final key expansion (1 cycle for subWord sbox)
            end
            S7: begin
                // Final AddRoundKey with expanded key (before capturing)
                currentState <= addRoundKeyDone;
                currentKey <= keyExpansionDone;  // Capture for consistency
                done <= 1;
            end
            S8: begin
                // Done
            end
        endcase
    end

    always_comb begin
        case (state)
            S0: nextState = S1;
            S1: nextState = S2;
            S2: nextState = S3;
            S3: nextState = S4;
            S4: begin
                if (round < 9) nextState = S1;  // Do another round (rounds 1-9)
                else nextState = S5;  // Go to final round (round 10)
            end
            S5: nextState = S6;
            S6: nextState = S7;
            S7: nextState = S8;
            S8: nextState = S8;  // Stay done
            default: nextState = S0;
        endcase
    end

    always_comb begin
        case (state)
            S0: bypassMuxResult = plainTextState;  // Initial AddRoundKey with plaintext
            S4: bypassMuxResult = mixColumnsDone;  // Normal rounds use MixColumns
            S8: bypassMuxResult = shiftRowsDone;  // Final round no MixColumns
            default: bypassMuxResult = currentState;
        endcase
    end

    always_comb begin
        case (state)
            S0: keyMuxOut = initialKeyState;  // Use original key for initial AddRoundKey
            default: keyMuxOut = keyState;  // Use expanded key
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