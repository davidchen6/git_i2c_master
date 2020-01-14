//------------------------------------------------------------------------------
//Verification Engineer: David Chen 
//Company Name: Personal Project.
//File Description: This file contains sequencer component which "plays" the sequence of transactions
//on the driver
//License: Released under Creative Commons Attribution - BY
//------------------------------------------------------------------------------
`ifndef WB3_SEQUENCER__SV
`define WB3_SEQUENCER__SV

class wb3_sequencer extends uvm_sequencer #(wb3_transaction);

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  `uvm_component_utils(wb3_sequencer)
endclass

`endif
