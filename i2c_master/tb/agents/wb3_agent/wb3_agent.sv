`ifndef WB3_AGENT__SV
`define WB3_AGENT__SV

class wb3_agent extends uvm_agent ;
   wb3_agent_cfg wb3_cfg;
   wb3_sequencer  sqr;
   wb3_driver     drv;
//   wb3_monitor    mon;
   
   uvm_analysis_port #(bit[8:0])  ap;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(wb3_agent)
endclass 


function void wb3_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if (is_active == UVM_ACTIVE) begin
      sqr = wb3_sequencer::type_id::create("sqr", this);
      drv = wb3_driver::type_id::create("drv", this);
   end
  // mon = wb3_monitor::type_id::create("mon", this);
endfunction 

function void wb3_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   if (is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(sqr.seq_item_export);
   end
   ap = sqr.m_ap;
   $display("connect phase for: ", get_full_name());
endfunction

`endif

