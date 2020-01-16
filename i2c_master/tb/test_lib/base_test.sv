`ifndef BASE_TEST__SV
`define BASE_TEST__SV

class base_test extends uvm_test;

   i2c_env_cfg env_cfg;
   i2c_env         env;
   i2c_vsqr        v_sqr;
   reg_model       rm;
   wb3_i2c_adapter     reg_sqr_adapter;

   virtual i2c_interface i2c_s_vif;
   virtual wb3_interface wb3_vif;

   i2c_slave_cfg i2c_slv_cfg;
   wb3_agent_cfg wb3_cfg;

   function new(string name = "base_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   `uvm_component_utils(base_test)
endclass


function void base_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if (!uvm_config_db#(virtual i2c_interface)::get(this, "", "i2c_vif", i2c_s_vif))
     `uvm_fatal("base_test", "Could not get i2c interface handel")
   if (!uvm_config_db#(virtual wb3_interface)::get(this, "", "wb3_vif", wb3_vif))
     `uvm_fatal("base_test", "Could not get wb3 interface handel")

   i2c_slv_cfg = i2c_slave_cfg::type_id::create("i2c_slv_cfg");
   i2c_slv_cfg.randomize();
   i2c_slv_cfg.i2c_s_vif = i2c_s_vif;
   wb3_cfg = wb3_agent_cfg::type_id::create("wb3_cfg");
   wb3_cfg.wb3_vif = wb3_vif;
   env_cfg = i2c_env_cfg::type_id::create("env_cfg");
   env_cfg.i2c_slv_cfg = i2c_slv_cfg;
   env_cfg.wb3_cfg = wb3_cfg;
   uvm_config_db#(i2c_env_cfg)::set(this, "env", "env_cfg", env_cfg);

   env  =  i2c_env::type_id::create("env", this); 
   v_sqr =  i2c_vsqr::type_id::create("v_sqr", this);
   rm = reg_model::type_id::create("rm", this);
   rm.configure(null, "");
   rm.build();
   rm.lock_model();
   rm.reset();
   reg_sqr_adapter = new("reg_sqr_adapter");
   env.p_rm = this.rm;
endfunction

function void base_test::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   v_sqr.p_i2c_sqr = env.i2c_slv_agt.sqr;
   v_sqr.p_wb3_sqr = env.wb3_agt.sqr;
   v_sqr.p_rm = this.rm;
   rm.default_map.set_sequencer(env.wb3_agt.sqr, reg_sqr_adapter);
   rm.default_map.set_auto_predict(1);
endfunction

function void base_test::report_phase(uvm_phase phase);
   uvm_report_server server;
   int err_num;
   super.report_phase(phase);

   server = get_report_server();
   err_num = server.get_severity_count(UVM_ERROR);

   if (err_num != 0) begin
      $display("TEST CASE FAILED");
   end
   else begin
      $display("TEST CASE PASSED");
   end
endfunction

`endif
