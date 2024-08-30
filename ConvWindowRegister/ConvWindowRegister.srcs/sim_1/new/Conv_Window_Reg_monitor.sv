`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2024 04:33:08 PM
// Design Name: 
// Module Name: Conv_Window_Reg_monitor
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

// monitor before looks at the output of the device and will pass it to the scoreboard
class Conv_Window_Reg_monitor_before extends uvm_monitor;
    `uvm_component_utils(Conv_Window_Reg_monitor_before)// UVM macros to save into UVM factory
    
    uvm_analysis_port#(Conv_Window_Reg_transaction) mon_ap_before;// analysis port declaration with the parameter that passes through it being the transaction
    
    virtual Conv_Window_Reg_if vif; //virtual interface declaration
    
    function new(string name, uvm_component parent);// class constructor with 2 arguments
     // 'name' a string rtepresenting the name of the instance of the class
    //'parent' a reference to the parent component in the UVM hierarchy. Typically the component that cretaes the monitor like a test
        super.new(name, parent);
        //Calls the constructor of the base class(uvm_monitor) using the keyword super. Properly initializes uvm_monitor as the derived class depends on it
    endfunction:new
    
    function void build_phase(uvm_phase phase);
    //void means that the function doesn't return anyhting. This takes an argument of Phase which is of the type uvm_phase.
    //argument represents the current phase of the uvm simulation process
        super.build_phase(phase);
        
        // gets the interface from the factory database. this is the same interface we instantiated earlier in the top block
        void'(uvm_resource_db#(virtual Conv_Window_Reg_if):: read_by_name (.scope("ifs"),.name("Conv_Window_Reg_if"),.val(vif)));
        mon_ap_before = new(.name("mon_ap_before"), .parent(this));
        //'name' sets the name of the analysis port instance
        //'parent' refers to the UVM component that owns this port so the monitor
    endfunction: build_phase
    
    task run_phase(uvm_phase phase);//run phase taking the argument of the current phase in UVM simulation
    
        Conv_Window_Reg_transaction CWR_tx;//declaration of a variable
        CWR_tx= Conv_Window_Reg_transaction:: type_id::create(.name("CWR_tx"),.contxt(get_full_name()));
        //'name'- sets the name of the created transaction
            //'contxt'- specifies the parent context for the object being created. Typically returns the hierarchical name of the current UVM component
        
        forever begin
            @(posedge vif.clk)
            begin
                CWR_tx.out=vif.Q;
                mon_ap_before.write(CWR.tx);
        
            end
        end
    endtask: run_phase
endclass: Conv_Window_Reg_monitor_before


//-----------------------------------------------------------------------------------------------------------------------------

//monitor after looks at both inputs and makes a prediction of the expected results
class Conv_Window_Reg_monitor_after extends uvm_monitor;
    `uvm_component_utils(Conv_Window_Reg_monitor_after)//uvm macro to save into the UVM factory
    
    uvm_analysis_port#(Conv_Window_Reg_transaction) mon_ap_after;//analysis port declaration with one parameter passing through it
    
    virtual Conv_Window_Reg_if vif;// virtual interface declaration
    
    Conv_Window_Reg_transaction CWR_tx;
    Conv_Window_Reg_transaction CWR_tx_cg;
    
    //covergroup is used to store the random values of the inputs and you can generate a report later
    covergroup Conv_Window_Reg_cg;
        D_cp: coverpoint CWR_tx_cg.D;
    endgroup: Conv_Window_Reg_cg
    
    //Class constructor syntax
    function new(string name, uvm_component parent);
        super.new(name,parent);
        Conv_Window_Reg_cg=new;
    endfunction: new
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // gets the interface from the factory database. this is the same interface we instantiated earlier in the top block
        void'(uvm_resource_db#(virtual Conv_Window_Reg_if):: read_by_name (.scope("ifs"),.name("Conv_Window_Reg_if"),.val(vif)));
        mon_ap_after= new(.name("Mon_ap_after"), .parent(this));
    endfunction: build_phase
    
    task run_phase(uvm_phase phase);
        CWR_tx= Conv_Window_Reg_transaction:: type_id::create(.name("CWR_tx"),.contxt(get_full_name()));
        //'name'- sets the name of the created transaction
        //'contxt'- specifies the parent context for the object being created. Typically returns the hierarchical name of the current UVM component
        forever begin 
            @(posedge vif.clk)
            begin
                predictor();
                CWR_tx_cg=CWR_tx;
                
                Conv_Window_Reg_cg.sample();// to check input coverage
                mon_ap_after.write(CWR_tx);
            end
         end
    endtask: run_phase
    
    virtual function void predictor();
        if (vif.reg_en == 1'b1)begin
            CWR_tx.Q =CWR_tx.D;
         end
    endfunction:predictor
    
endclass:Conv_Window_Reg_monitor_after