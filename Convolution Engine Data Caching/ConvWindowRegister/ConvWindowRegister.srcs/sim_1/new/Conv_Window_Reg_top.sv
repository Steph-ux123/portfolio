`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2024 07:09:35 PM
// Design Name: 
// Module Name: Conv_Window_Reg_top
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
`include "uvm_macros.svh"


module Conv_Window_Reg_top;
// importing libraries
    import uvm_pkg::*; 

//interface declaration
    Conv_Window_Reg_if vif();

//Connects the Interface to the device under test
    Conv_Window_Reg dut(vif.clk,
                        vif.reset,
                        vif.reg_en,
                        vif.D,
                        vif.Q);
                        
//registers the interface in the configuration block/ library so that other blocks can use it 

    initial begin
        uvm_resource_db#(virtual Conv_Window_Reg_if)::set(.scope("ifs"),.name("Conv_Window_Reg_if"),.val(vif));

//execute the test
        run_test();
    end
    
//variable initialization
    initial begin
        vfig.clk = 1'b1;
    end

//clock generation
    always
        #5 vfig.clk =~vfig.clk;

endmodule