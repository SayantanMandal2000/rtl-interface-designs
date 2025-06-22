`timescale 1ns / 1ps

module handshake_tb();
    reg clk;
    reg rstn;
    reg [7:0] data_in;
    wire [7:0] data_out;
    
    handshake_top dut(
        .clk(clk),
        .rstn(rstn),
        .data_in(data_in),
        .data_out(data_out)
        );
        
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    
    initial begin
        rstn=0;
        #5 rstn=1;
    end
    
    initial begin
        #10;
        data_in= 8'hA1; 
        #50 data_in= 8'hB2; 
        #50 data_in= 8'hD8;
        #50 data_in= 8'hFF;
        #50 data_in= 8'hC9;
        #100 $finish;
     end
    
endmodule
