`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2024 06:47:43 PM
// Design Name: 
// Module Name: Conv_Window_Reg_driver
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

class Conv_Window_Reg_driver extends uvm_driver#(Conv_Window_Reg_transaction);//derives a class from the UVM class UVM_driver.
//the transaction is a parameter and represents the data type that will be retrieved from the sequencer
    `uvm_component_utils(Conv_Window_Reg_driver)// register in the UVM factory
    
    protected virtual Conv_Window_Reg_if vif;// protected virtual interface. interface can only be accessed by the class it is defined in and by any classes that inherit from it. Helps with encapsulation
    
//normal class constructor structure   
    function new(string name, uvm_component parent);// declares constructor from the class taking 2 arguments.
    // 'name' a string rtepresenting the name of the instance of the class
    //'parent' a reference to the parent component in the UVM hierarchy. Typically the component that cretaes the driver like a test
        super.new(name,parent);
        //Calls the constructor of the base class(uvm_driver) using the keyword super. Properly initializes uvm_driver as the derived class depends on it
    endfunction: new
    
 
 // starts the build phase of the class. This occurs before the run phase. All classes have simulation phases and are ordered steps of execution implemented as methods.
 // when we derive a new class, the simulation of our testbench will go thriough thses different phases  
    function void build_phase(uvm_phase phase);
    //void means that the function doesn't return anyhting. This takes an argument of Phase which is of the type uvm_phase.
    //argument represents the current phase of the uvm simulation process
        super.build_phase(phase);
    void'(uvm_resource_db#(virtual Conv_Window_Reg_if)::read_by_name(.scope("ifs"),.name("Conv_Window_Reg_if"),.val(vif)));// gets the interface from the factory database. this is the same interface we instantiated earlier in the top block
    endfunction: build_phase
    
    task run_phase(uvm_phase phase);// run phase where the code of the driver will be executed
        Conv_Window_Reg_transaction CWR_tx;// Declaration of Conv_Window_reg_transaction under the handle CWR_tx. 
        // means we can call it under the handle

        forever begin
        // initializing base values for each interface input
            integer counter =0;
            vif.D = 8'b0;
            vif.reg_en=1'b0;
            seq_item_port.get_next_item(CWR_tx);// special variable from the UVM to communicate with the sequencer. Calls new transaction
            drive();
            seq_item_port.item_done();// when finished with the transaction calls this sequence
        end
    endtask: run_phase
    
    virtual task drive();
        @(posedge vif.clk);
        vif.D <= CWR_tx.D;
        counter <=counter+1;
        if(counter==4)  begin
            vif.reg_en=1'b1;
        end
    endtask: drive

endclass:Conv_Window_Reg_driver