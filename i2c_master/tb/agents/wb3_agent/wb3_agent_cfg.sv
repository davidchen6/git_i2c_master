`ifndef WB3_AGENT_CFG__SV
`define WB3_AGENT_CFG__SV

`include "tb_defines.sv"

// Class: wb3_agent_cfg
// Wishbone master agent configuration class. 
class wb3_agent_cfg extends uvm_object;
  
  // Variables: is_active
  // Agent can be defined passive or active.
  rand uvm_active_passive_enum is_active;
  virtual wb3_interface    m_wbIf;
  int unsigned m_wbFrequency;   //kHz
  int unsigned m_sclFrequency;   //kHz
  
  `uvm_object_utils_begin(wb3_agent_cfg)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_object_utils_end
	    
  extern function new(string name = "wb3_agent_cfg");

  extern constraint agent_is_active_c;
		    
endclass: wb3_agent_cfg

//------------------------------------------------------------------------//
// Function: new
// constructor
function wb3_agent_cfg::new(string name = "wb3_agent_cfg");
  super.new(name);

endfunction: new

//------------------------------------------------------------------------//
// constraint: agent_is_active_c
// constraints variable <is_active>. Default: is_active == UVM_ACTIVE.
constraint wb3_agent_cfg::agent_is_active_c { is_active == UVM_ACTIVE; }

`endif //WB3_AGENT_CFG__SV
