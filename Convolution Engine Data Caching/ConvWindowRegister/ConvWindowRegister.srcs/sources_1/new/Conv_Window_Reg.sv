`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2024 03:25:06 PM
// Design Name: 
// Module Name: Conv_Window_Reg
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
// interface for UVM design verification


//Design of a nnegative edge triggered flip flop
module Conv_Window_Reg
#(DATA_WIDTH=8
)// parameterization to make for easier editing further along the line

//port declaration
(input wire clk,
input wire reset,
input wire reg_en,
input reg [DATA_WIDTH-1:0]D,
output reg [DATA_WIDTH-1:0]Q
    );  
//behaviour declaration of the flip before
//synchronous reset    
always @ (negedge clk)begin
if (reset)
    Q <=0;
else if (reg_en)
    Q <= D;
end

endmodule
