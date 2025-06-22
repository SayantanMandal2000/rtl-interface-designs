`timescale 1ns / 1ps

module handshake_slave(
    input        clk,
    input        rstn,
    input  [7:0] data,
    input        valid,
    output reg   ack,
    output reg [7:0] data_out
);

    parameter [1:0] S_IDLE=0, S_WAIT=1, S_ACK=2;
    reg [1:0] ps, ns;
    reg [1:0] counter;

    always @(posedge clk or negedge rstn) begin
        if (!rstn)
            ps <= S_IDLE;
        else
            ps <= ns;
    end

    always @(*) begin
        case (ps)
            S_IDLE: ns = (valid) ? S_WAIT : S_IDLE;
            S_WAIT: ns = (counter == 2'd2) ? S_ACK : S_WAIT;
            S_ACK:  ns = S_IDLE;
            default: ns = S_IDLE;
        endcase
    end

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            ack <= 0;
            data_out <= 0;
            counter <= 0;
        end else begin
            case (ps)
                S_IDLE: begin
                            ack <= 0;
                            counter <= 0;
                        end
                S_WAIT: counter <= counter + 1;
                S_ACK: begin
                        ack <= 1;
                        data_out <= data;
                       end
            endcase
        end
    end
endmodule

