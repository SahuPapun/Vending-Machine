module vending_fsm (
    input logic clk,
    input logic reset,
    input logic [2:0] coin,     // Accepts coin: 1, 2, or 5
    input logic cancel,         // Cancel operation
    output logic dispense,      // High for 1 cycle when item is dispensed
    output logic [3:0] balance  // Current coin balance
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE      = 2'b00,
        COLLECT   = 2'b01,
        DISPENSE  = 2'b10
    } state_t;

    state_t state, next_state;
    logic [3:0] curr_balance;

    // Sequential logic for state and balance update
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            curr_balance <= 4'd0;
        end else begin
            state <= next_state;

            // Coin collection logic
            if (state == COLLECT)
                curr_balance <= curr_balance + coin;

            // Cancel or dispense resets balance
            if (cancel || next_state == DISPENSE)
                curr_balance <= 4'd0;
        end
    end

    // Next state and output logic
    always_comb begin
        next_state = state;
        dispense = 1'b0;

        case (state)
            IDLE: begin
                if (coin != 3'd0)
                    next_state = COLLECT;
            end

            COLLECT: begin
                if ((curr_balance + coin) >= 4'd7)
                    next_state = DISPENSE;
                else if (cancel)
                    next_state = IDLE;
            end

            DISPENSE: begin
                dispense = 1'b1;
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    assign balance = curr_balance;

endmodule
