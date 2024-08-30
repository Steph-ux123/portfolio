`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/29/2024 08:13:03 PM
// Design Name: 
// Module Name: LineBuffer
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


module LineBuffer // Declaration using new ANSI style
#(parameter DATA_WIDTH=8,
parameter DEPTH=10,
parameter PTR_SIZE=4 )

(input wire clk,
input wire reset,
input wire write_en,
input wire read_en, 
input reg [DATA_WIDTH-1:0]data_in,
output reg [DATA_WIDTH-1:0]data_out,
output reg empty_reg,
output reg full_reg
);
localparam MSB = $clog2(DEPTH);

reg[DATA_WIDTH-1:0]memory[DEPTH-1:0];// memory array
reg[MSB-1:0]wr_ptr;
reg[MSB-1:0]rd_ptr;
reg[6:0] fifo_counter;  
 

 
always @(fifo_counter)begin
empty_reg <=(fifo_counter==0);
full_reg <=(fifo_counter==10);
end

always @(posedge clk or posedge reset) begin
if(reset)
fifo_counter <= 0;
else if ((!full_reg&& write_en)&&(!empty_reg&& read_en))
fifo_counter <=fifo_counter;
else if (!full_reg&& write_en)
fifo_counter <=fifo_counter+1;
else if (!empty_reg&& read_en)
fifo_counter <= fifo_counter-1;
else
fifo_counter <=fifo_counter;

end

always @(posedge clk or posedge reset) begin
if (reset)
data_out <=0;
else begin
if(read_en && !empty_reg)
data_out <= memory[rd_ptr];
else
data_out <=data_out;
end
end

always @(posedge clk) begin
if(write_en && !full_reg)
memory[wr_ptr] <= data_in;
else
memory[wr_ptr] <= memory[wr_ptr];
end

always @(posedge clk or posedge reset)
if (reset) begin
wr_ptr <=0;
rd_ptr <=0;
end
else begin
if(!full_reg &&write_en)
 if(wr_ptr[MSB-1:0] == DEPTH-1) 
    begin
        wr_ptr <= '0;      
    end
else begin
wr_ptr <=wr_ptr+1;
end

if(!empty_reg && read_en)
 if (rd_ptr[MSB-1:0] == DEPTH-1)
    begin
        rd_ptr <= '0;
    end
  else begin
  rd_ptr <=rd_ptr+1;
  end
end

endmodule
