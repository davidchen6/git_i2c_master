`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class case0_sequence extends uvm_sequence #(wb3_transaction);
   wb3_transaction m_trans;

   function  new(string name= "case0_sequence");
      super.new(name);
   endfunction 
   
   virtual task body();
      $display({"case0_seq for: ", get_full_name()});
      repeat (10) begin
         `uvm_do(m_trans)
      end
   endtask

   `uvm_object_utils(case0_sequence)
endclass

class case0_cfg_vseq extends uvm_sequence;

   `uvm_object_utils(case0_cfg_vseq)
   `uvm_declare_p_sequencer(i2c_vsqr)
   
   function  new(string name= "case0_cfg_vseq");
      super.new(name);
   endfunction 
   
   virtual task body();
      uvm_status_e   status;
      uvm_reg_data_t value;

      $display({"case0_cfg_vseq for: ", get_full_name()});
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      p_sequencer.p_rm.rPRERlo.read(status, value, UVM_FRONTDOOR);
      `uvm_info("case0_cfg_vseq", $sformatf("rPRERlo's initial value is %0h", value), UVM_LOW)
      p_sequencer.p_rm.rPRERlo.write(status, 8'h3f, UVM_FRONTDOOR);
      p_sequencer.p_rm.rPRERlo.read(status, value, UVM_FRONTDOOR);
      `uvm_info("case0_cfg_vseq", $sformatf("after set, rPRERlo's value is %0h", value), UVM_LOW)
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

endclass

class case0_vseq extends uvm_sequence;

   `uvm_object_utils(case0_vseq)
   `uvm_declare_p_sequencer(i2c_vsqr)
   
   function  new(string name= "case0_vseq");
      super.new(name);
   endfunction 
   
   virtual task body();
      case0_sequence dseq;
      uvm_status_e   status;
      uvm_reg_data_t value;
      if(starting_phase != null) 
      $display({"case0_vseq for: ", get_full_name()});
         starting_phase.raise_objection(this);
      #10000;
      dseq = case0_sequence::type_id::create("dseq");
      dseq.start(p_sequencer.p_i2c_sqr);
      
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

endclass


class i2c_case0 extends base_test;

   function new(string name = "i2c_case0", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   `uvm_component_utils(i2c_case0)
endclass


function void i2c_case0::build_phase(uvm_phase phase);
   super.build_phase(phase);

   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "v_sqr.configure_phase", 
                                           "default_sequence", 
                                           case0_cfg_vseq::type_id::get());
   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "v_sqr.main_phase", 
                                           "default_sequence", 
                                           case0_vseq::type_id::get());
endfunction

`endif
