`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2024 01:53:44 PM
// Design Name: 
// Module Name: convreg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Conv_Window_Reg_tb();
parameter DATA_WIDTH =8;
// setting up driving registers and wires to put in inputs
reg clk;
reg reset;
reg reg_en;
reg [DATA_WIDTH-1:0]D;
wire [DATA_WIDTH-1:0] Q;


Conv_Window_Reg dut(
.clk(clk),
.reset(reset),
.reg_en(reg_en),
.D(D),
.Q(Q)
);

//CLOCK GENERATION- clock with 10 ns period
always
    begin
    clk <=1;
    #5
    clk <=0;
    #5;
    end

//test vectors

initial
    begin
    
    reset <=1;
    reg_en <=0;
    #10;
    reset <=0;
    #10;
    D <= 'hff;
    #20;
    reg_en <=1;
    D <= 2'h00;
    #20;
    D <= 'h10;
    #20;
    D <= 'hff;
end 
  
endmodule
