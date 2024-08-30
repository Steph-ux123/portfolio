`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2024 06:38:08 PM
// Design Name: 
// Module Name: Conv_Window_Reg_agent
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

class Conv_Window_Reg_agent extends uvm_agent;
    `uvm_component_utils(Conv_Window_Reg_agent)
    
    uvm_analysis_port#(Conv_Window_Reg_transaction) agent_ap_before;
    uvm_analysis_port#(Conv_Window_Reg_transaction) agent_ap_after;
    
    Conv_Window_Reg_Sequencer CWR_seqr;
    Conv_Window_Reg_driver CWR_drvr;
    Conv_Window_Reg_monitor_before CWR_mon_before;
    Conv_Window_Reg_monitor_after CWR_mon_after;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction:new
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        agent_ap_before=new(.name("agent_ap_before"),.parent(this));
        agent_ap_after=new(.name("agent_ap_after"),.parent(this));
        
        CWR_seqr= Conv_Window_Reg_Sequencer::type_id::create(.name("CWR_seqr"), .parent(this));
        CWR_drvr= Conv_Window_Reg_driver::type_id::create(.name("CWR_drvr"), .parent(this));
        CWR_mon_before= Conv_Window_Reg_monitor_before::type_id::create(.name("CWR_mon_before"), .parent(this));
        CWR_mon_after= Conv_Window_Reg_monitor_after::type_id::create(.name("CWR_mon_after"), .parent(this));
        
    endfunction:build_phase
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        CWR_drvr.seq_item_port.connect(CWR_seqr.seq_item_export);
        CWR_mon_before.mon_ap_before.connect(agent_ap_before);
        CWR_mon_after.mon_ap_after.connect(agent_ap_after);
    endfunction: connect_phase

endclass:Conv_Window_Reg_agent
