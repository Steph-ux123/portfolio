`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2024 11:56:14 AM
// Design Name: 
// Module Name: Conv_Window_Reg_Sequencer
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
import uvm_pkg::*;
//definig a simple transaction thaat extends from the uvm_sequence_item
class Conv_Window_Reg_transaction extends uvm_sequence_item;
   
//declares variables for the input.Rand  keyword asks compiler to generate and store random values in these variables
    rand bit [7:0]D;
    bit[7:0]Q;

//typical class constructor setup- initializing the class object
    function new(string name ="");// declares the constructor new for the UVM class
        super.new(name);// calls the constructor of the base class 'uvm_sequence_item'. ensures that the base class is properly initialized
        //inhertance
    endfunction 
    
//uvm macros to register in the UVM factory
    `uvm_object_utils_begin(Conv_Window_Reg_transaction)
    `uvm_field_int(D, UVM_ALL_ON)
    `uvm_field_int(Q, UVM_ALL_ON)
    `uvm_object_utils_end

endclass: Conv_Window_Reg_transaction 

//-------------------------------------------------------------------------------------------


class Conv_Window_Reg_sequence extends uvm_sequence#(Conv_Window_Reg_transaction);
    `uvm_object_utils(Conv_Window_Reg_sequence)// this is to register the class in the UVM factory
    
    function new(string name ="");// declares constructor from the class.Takes one argument- name.
        super.new(name);
         //Calls the constructor of the base class(uvm_sequence) using the keyword super. Properly initializes uvm_sequence as the derived class depends on it
    endfunction:new

//main body of a sequence 
    task body();
        Conv_Window_Reg_transaction CWR_tx;

//generate 8 transactions        
        repeat(8) begin
            CWR_tx = Conv_Window_Reg_transaction::type_id::create(.name("CWR_tx"), .contxt(get_full_name()));//creates an object of a specific type
            //'name'- sets the name of the created transaction
            //'contxt'- specifies the parent context for the object being created. Typically returns the hierarchical name of the current UVM component
            start_item(CWR_tx);// indicates to start a new transaction
                assert(CWR_tx.randomize());// used to randomize field of transaction
            finish_item(CWR_tx);
        end    
    endtask:body
            

endclass:Conv_Window_Reg_sequence

typedef uvm_sequencer#(Conv_Window_Reg_transaction)Conv_Window_Reg_Sequencer;