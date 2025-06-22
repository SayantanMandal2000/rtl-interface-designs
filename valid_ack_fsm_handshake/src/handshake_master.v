`timescale 1ns / 1ps

module handshake_master(
    input        clk,
    input        rstn,
    input  [7:0] data_in,
    input        ack,
    output reg   valid,
    output reg [7:0] data
);

    parameter [1:0] IDLE=0, SEND=1, WAIT_ACK=2;
    reg [1:0] ps, ns;

    always @(posedge clk or negedge rstn) begin
        if (!rstn)
            ps <= IDLE;
        else
            ps <= ns;
    end

    always @(*) begin
        case (ps)
            IDLE:      ns = SEND;
            SEND:      ns = WAIT_ACK;
            WAIT_ACK:  ns = (ack) ? IDLE : WAIT_ACK;
            default:   ns = IDLE;
        endcase
    end

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            valid <= 0;
            data  <= 8'h00;
        end else begin
            case (ps)
                IDLE: valid <= 0;
                SEND: begin
                        data  <= data_in;
                        valid <= 1;
                      end
                WAIT_ACK: begin
                            if (ack)
                                valid <= 0;
                          end
            endcase
        end
    end
endmodule
