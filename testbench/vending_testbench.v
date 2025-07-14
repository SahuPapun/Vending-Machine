`timescale 1ns/1ps

module tb_vending_fsm;

    logic clk, reset, cancel;
    logic [2:0] coin;
    logic dispense;
    logic [3:0] balance;

    vending_fsm dut (
        .clk(clk),
        .reset(reset),
        .coin(coin),
        .cancel(cancel),
        .dispense(dispense),
        .balance(balance)
    );

    // Clock generator
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Simulation with waveform dump
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_vending_fsm);

        $display("Starting Vending Machine Simulation...");
        reset = 1; coin = 3'd0; cancel = 0;
        #10 reset = 0;

        // Insert coins: 2 + 2 + 3 → should reach >= 7 and dispense
        #10 coin = 3'd2;
        #10 coin = 3'd2;
        #10 coin = 3'd3;
        #10 coin = 3'd0;

        // Wait and try cancel
        #20 cancel = 1;
        #10 cancel = 0;

        // Try another valid sequence
        #10 coin = 3'd5;
        #10 coin = 3'd2;
        #10 coin = 3'd0;

        #50 $finish;
    end

endmodule
