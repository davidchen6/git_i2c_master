`ifndef MY_ENV__SV
`define MY_ENV__SV

class i2c_env extends uvm_env;

   i2c_slave_agent   i2c_slv_agt;
   //i2c_slave_agent   o_agt;
   wb3_agent  wb3_agt;
   i2c_scoreboard scb;

   reg_model  p_rm;
   i2c_env_cfg env_cfg;
   wb3_agent_cfg wb3_cfg;
   i2c_slave_cfg i2c_slv_cfg;

   uvm_tlm_analysis_fifo #(bit[8:0]) wb3_sqr_scb_fifo;
   uvm_tlm_analysis_fifo #(bit[8:0]) i2c_drv_scb_fifo;

   function new(string name = "i2c_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db#(i2c_env_cfg)::get(this, "", "env_cfg", env_cfg))
	    `uvm_fatal("i2c_env","Could not get handle to i2c_env_cfg.")
	  wb3_cfg = env_cfg.wb3_cfg;
	  i2c_slv_cfg = env_cfg.i2c_slv_cfg;

	  i2c_slv_agt = i2c_slave_agent::type_id::create("i2c_slv_agt", this);
//      o_agt = i2c_slave_agent::type_id::create("o_agt", this);
	  i2c_slv_agt.i2c_slv_cfg = i2c_slv_cfg;
      i2c_slv_agt.is_active = UVM_ACTIVE;
  //    o_agt.is_active = UVM_PASSIVE;
      wb3_agt = wb3_agent::type_id::create("wb3_agt", this);
	  wb3_agt.wb3_cfg = wb3_cfg;
      wb3_agt.is_active = UVM_ACTIVE;
      scb = i2c_scoreboard::type_id::create("scb", this);

	  wb3_sqr_scb_fifo = new("wb3_sqr_scb_fifo", this);
	  i2c_drv_scb_fifo = new("i2c_drv_scb_fifo", this);
   endfunction

   extern virtual function void connect_phase(uvm_phase phase);
   
   `uvm_component_utils(i2c_env)
endclass

function void i2c_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //i2c_slv_agt.ap.connect(agt_mdl_fifo.analysis_export);
   //mdl.port.connect(agt_mdl_fifo.blocking_get_export);
   wb3_agt.ap.connect(wb3_sqr_scb_fifo.analysis_export);
   scb.exp_port.connect(wb3_sqr_scb_fifo.blocking_get_export);
   i2c_slv_agt.ap.connect(i2c_drv_scb_fifo.analysis_export);
   scb.act_port.connect(i2c_drv_scb_fifo.blocking_get_export); 
//   scb.p_rm = this.p_rm;
   wb3_agt.sqr.p_rm = this.p_rm;
endfunction

`endif
