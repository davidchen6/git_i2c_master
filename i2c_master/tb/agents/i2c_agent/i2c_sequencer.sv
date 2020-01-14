//------------------------------------------------------------------------------
//Verification Engineer: David Chen 
//Company Name: Personal Project.
//File Description: This file contains sequencer component which "plays" the sequence of transactions
//on the driver
//License: Released under Creative Commons Attribution - BY
//------------------------------------------------------------------------------
`ifndef I2C_SEQUENCER__SV
`define I2C_SEQUENCER__SV

class i2c_sequencer extends uvm_sequencer #(i2c_transaction);

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  `uvm_component_utils(i2c_sequencer)
endclass

`endif
