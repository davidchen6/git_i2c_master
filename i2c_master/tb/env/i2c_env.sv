`ifndef MY_ENV__SV
`define MY_ENV__SV

class i2c_env extends uvm_env;

   i2c_slave_agent   i_agt;
   i2c_slave_agent   o_agt;
   wb3_agent  wb3_agt;
   i2c_scoreboard scb;

   reg_model  p_rm;
   
   uvm_tlm_analysis_fifo #(i2c_transaction) agt_scb_fifo;
   uvm_tlm_analysis_fifo #(i2c_transaction) agt_mdl_fifo;
   uvm_tlm_analysis_fifo #(i2c_transaction) mdl_scb_fifo;
   
   function new(string name = "i2c_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      i_agt = i2c_slave_agent::type_id::create("i_agt", this);
      o_agt = i2c_slave_agent::type_id::create("o_agt", this);
      i_agt.is_active = UVM_ACTIVE;
      o_agt.is_active = UVM_PASSIVE;
      wb3_agt = wb3_agent::type_id::create("wb3_agt", this);
      wb3_agt.is_active = UVM_ACTIVE;
      scb = i2c_scoreboard::type_id::create("scb", this);
      agt_scb_fifo = new("agt_scb_fifo", this);
      agt_mdl_fifo = new("agt_mdl_fifo", this);
      mdl_scb_fifo = new("mdl_scb_fifo", this);

   endfunction

   extern virtual function void connect_phase(uvm_phase phase);
   
   `uvm_component_utils(i2c_env)
endclass

function void i2c_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
  /* i_agt.ap.connect(agt_mdl_fifo.analysis_export);
   mdl.port.connect(agt_mdl_fifo.blocking_get_export);
   mdl.ap.connect(mdl_scb_fifo.analysis_export);
   scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);
   o_agt.ap.connect(agt_scb_fifo.analysis_export);
   scb.act_port.connect(agt_scb_fifo.blocking_get_export); */
   scb.p_rm = this.p_rm;
endfunction

`endif
