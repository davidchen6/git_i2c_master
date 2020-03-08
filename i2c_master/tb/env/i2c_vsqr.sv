`ifndef I2C_VSQR__SV
`define I2C_VSQR__SV

class i2c_vsqr extends uvm_sequencer;
  
   i2c_sequencer p_i2c_mstr_sqr;
   i2c_sequencer p_i2c_slv1_sqr;
   i2c_sequencer p_i2c_slv2_sqr;
   i2c_sequencer p_i2c_slv3_sqr;
   i2c_sequencer p_i2c_slv4_sqr;
   wb3_sequencer p_wb3_sqr;
   reg_model     p_rm;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(i2c_vsqr)
endclass

`endif
