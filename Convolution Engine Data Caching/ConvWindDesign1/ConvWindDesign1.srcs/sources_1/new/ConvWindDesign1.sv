`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2024 09:27:45 PM
// Design Name: 
// Module Name: ConvWindDesign1
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


module ConvWindDesign1
#(DATA_WIDTH=8
)
(input wire clk,
input wire reset,
input wire read_en1,
input wire write_en1,
input wire read_en2,
input wire write_en2,
input wire read_en3,
input wire write_en3,
input wire reg_en,
input reg [DATA_WIDTH-1:0] data_in,
output reg [DATA_WIDTH-1:0] w1,
output reg [DATA_WIDTH-1:0] w2,
output reg [DATA_WIDTH-1:0] w3,
output reg [DATA_WIDTH-1:0] w4,
output reg [DATA_WIDTH-1:0] w5,
output reg [DATA_WIDTH-1:0] w6,
output reg [DATA_WIDTH-1:0] w7,
output reg [DATA_WIDTH-1:0] w8,
output reg [DATA_WIDTH-1:0] w9
    );
    
reg [DATA_WIDTH-1:0] g0;
reg [DATA_WIDTH-1:0] g1;
reg [DATA_WIDTH-1:0] g2;


LineBuffer L1 (.clk(clk), 
               .reset(reset),
               .read_en(read_en1), 
               .write_en(write_en1), 
               .data_out(g0), 
               .data_in(data_in)
               );
               
LineBuffer L2 (.clk(clk), 
               .reset(reset),
               .read_en(read_en2), 
               .write_en(write_en2), 
               .data_out(g1), 
               .data_in(g0)
               );
               
LineBuffer L3 (.clk(clk), 
               .reset(reset),
               .read_en(read_en3), 
               .write_en(write_en3), 
               .data_out(g2), 
               .data_in(g1)
               );
              
Conv_Window_Reg W1(.clk(clk),
                .reset(reset),
                .reg_en(reg_en),
                .D(g0),
                .Q(w1)
                );
                     
Conv_Window_Reg W2(.clk(clk),
                .reset(reset),
                .reg_en(reg_en),
                .D(w1),
                .Q(w2)
                );
                
Conv_Window_Reg W3(.clk(clk),
                .reset(reset),
                .reg_en(reg_en),
                .D(w2),
                .Q(w3)
                );
                
Conv_Window_Reg W4(.clk(clk),
                .reset(reset),
                .reg_en(reg_en),
                .D(g1),
                .Q(w4)
                );
                
Conv_Window_Reg W5(.clk(clk),
                .reset(reset),
                .reg_en(reg_en),
                .D(w4),
                .Q(w5)
                );
                
Conv_Window_Reg W6(.clk(clk),
                .reset(reset),
                .reg_en(reg_en),
                .D(w5),
                .Q(w6)
                );
                
Conv_Window_Reg W7(.clk(clk),
                .reset(reset),
                .reg_en(reg_en),
                .D(g2),
                .Q(w7)
                );
                
Conv_Window_Reg W8(.clk(clk),
                .reset(reset),
                .reg_en(reg_en),
                .D(w7),
                .Q(w8)
                );
                
Conv_Window_Reg W9(.clk(clk),
                .reset(reset),
                .reg_en(reg_en),
                .D(w8),
                .Q(w9)
                );
                
endmodule
