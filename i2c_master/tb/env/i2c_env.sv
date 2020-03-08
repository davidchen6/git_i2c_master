`ifndef MY_ENV__SV
`define MY_ENV__SV

class i2c_env extends uvm_env;

   i2c_master_agent   i2c_mstr_agt;
   i2c_slave_agent   i2c_slv1_agt;
   i2c_slave_agent   i2c_slv2_agt;
   i2c_slave_agent   i2c_slv3_agt;
   i2c_slave_agent   i2c_slv4_agt;
   wb3_agent  wb3_agt;
   i2c_scoreboard scb;

   reg_model  p_rm;
   i2c_env_cfg env_cfg;
   wb3_agent_cfg wb3_cfg;
   i2c_master_cfg i2c_mstr_cfg;
   i2c_slave_cfg i2c_slv1_cfg;
   i2c_slave_cfg i2c_slv2_cfg;
   i2c_slave_cfg i2c_slv3_cfg;
   i2c_slave_cfg i2c_slv4_cfg;

//   uvm_tlm_analysis_fifo #(bit[8:0]) wb3_sqr_scb_fifo;
//   uvm_tlm_analysis_fifo #(bit[8:0]) i2c_drv_scb_fifo;

   function new(string name = "i2c_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db#(i2c_env_cfg)::get(this, "", "env_cfg", env_cfg))
	    `uvm_fatal("i2c_env","Could not get handle to i2c_env_cfg.")
	  wb3_cfg = env_cfg.wb3_cfg;
      uvm_config_db#(wb3_agent_cfg)::set(this, "wb3_agt*", "wb3_agent_cfg", wb3_cfg);
	  
	  i2c_mstr_cfg = env_cfg.i2c_mstr_cfg;
      uvm_config_db#(i2c_master_cfg)::set(this, "i2c_mstr_agt*", "i2c_master_cfg", i2c_mstr_cfg);

	  i2c_slv1_cfg = env_cfg.i2c_slv1_cfg;
      uvm_config_db#(i2c_slave_cfg)::set(this, "i2c_slv1_agt*", "i2c_slave_cfg", i2c_slv1_cfg);

	  i2c_slv2_cfg = env_cfg.i2c_slv2_cfg;
      uvm_config_db#(i2c_slave_cfg)::set(this, "i2c_slv2_agt*", "i2c_slave_cfg", i2c_slv2_cfg);

	  i2c_slv3_cfg = env_cfg.i2c_slv3_cfg;
      uvm_config_db#(i2c_slave_cfg)::set(this, "i2c_slv3_agt*", "i2c_slave_cfg", i2c_slv3_cfg);

	  i2c_slv4_cfg = env_cfg.i2c_slv4_cfg;
      uvm_config_db#(i2c_slave_cfg)::set(this, "i2c_slv4_agt*", "i2c_slave_cfg", i2c_slv4_cfg);

	  i2c_mstr_agt = i2c_master_agent::type_id::create("i2c_mstr_agt", this);
	  i2c_slv1_agt = i2c_slave_agent::type_id::create("i2c_slv1_agt", this);
//      o_agt = i2c_slave_agent::type_id::create("o_agt", this);
	  //i2c_slv1_agt.i2c_slv_cfg = i2c_slv1_cfg;
      //i2c_slv1_agt.is_active = UVM_ACTIVE;
	  i2c_slv2_agt = i2c_slave_agent::type_id::create("i2c_slv2_agt", this);
	  i2c_slv3_agt = i2c_slave_agent::type_id::create("i2c_slv3_agt", this);
	  i2c_slv4_agt = i2c_slave_agent::type_id::create("i2c_slv4_agt", this);
      wb3_agt = wb3_agent::type_id::create("wb3_agt", this);
	  //wb3_agt.wb3_cfg = wb3_cfg;
      //wb3_agt.is_active = UVM_ACTIVE;
      scb = i2c_scoreboard::type_id::create("scb", this);

   endfunction

   extern virtual function void connect_phase(uvm_phase phase);
   
   `uvm_component_utils(i2c_env)
endclass

function void i2c_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //i2c_slv1_agt.ap.connect(agt_mdl_fifo.analysis_export);
   //mdl.port.connect(agt_mdl_fifo.blocking_get_export);
   wb3_agt.ap.connect(scb.dut_data_port);
   i2c_mstr_agt.ap.connect(scb.master_data_port);
   i2c_slv1_agt.ap.connect(scb.slv1_data_port);
   i2c_slv2_agt.ap.connect(scb.slv2_data_port);
   i2c_slv3_agt.ap.connect(scb.slv3_data_port);
   i2c_slv4_agt.ap.connect(scb.slv4_data_port);
//   scb.p_rm = this.p_rm;
   wb3_agt.sqr.p_rm = this.p_rm;
endfunction

`endif
