`timescale 1ns / 1ps

module handshake_top(
    input clk,
    input rstn,
    input [7:0] data_in,
    output [7:0] data_out
    );
    
    wire [7:0]data,data_slave;
    wire ack,valid;
    
    handshake_master m1(clk,rstn,data_in,ack,valid,data);
    
    handshake_slave s1(clk,rstn,data,valid,ack,data_out);
    
endmodule
