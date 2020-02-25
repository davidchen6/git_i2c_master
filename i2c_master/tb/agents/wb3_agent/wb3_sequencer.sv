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

  uvm_analysis_port #(bit[8:0]) m_ap;
  reg_model     p_rm;

  function new(string name, uvm_component parent);
    super.new(name, parent);
	m_ap = new("m_ap", this);
  endfunction

  `uvm_component_utils(wb3_sequencer)
endclass

`endif
