`ifndef I2C_MASTER_TX_TEST__SV
`define I2C_MASTER_TX_TEST__SV

//Pipe-cleaner test to bring up the test environment.
class iicMasterTxTest extends base_test;
 `uvm_component_utils(iicMasterTxTest)
 
 extern function new(string name = "iicMasterTxTest", uvm_component parent = null);
 extern task run_phase(uvm_phase phase);
 extern function void build_phase(uvm_phase phase);
 
endclass

function iicMasterTxTest::new(string name = "iicMasterTxTest", uvm_component parent = null);
 super.new(name, parent);
endfunction

function void iicMasterTxTest::build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

task iicMasterTxTest::run_phase(uvm_phase phase);
 i2c_test_base_vseq m_iicTestVseq;

 i2c_test_base_vseq::type_id::set_type_override(iicTest_MasterTx_Vseq::get_type(),1);
 dut_traffic_base_vseq::type_id::set_type_override(iicDutTraffic_MasterTx_Vseq::get_type(),1);
 //iicXtTrafficBaseVseq::type_id::set_type_override(iicXtTraffic_MasterTx_Vseq::get_type(),1);

 m_iicTestVseq = i2c_test_base_vseq::type_id::create("m_i2c_test_base_vseq");

 phase.raise_objection(this,"iicMasterTxTest"); 
  #100;
  wait(wb3_vif.rst);
  #P_TESTRUNIN;
  if (!m_iicTestVseq.randomize())
   `uvm_fatal(m_name, "Unable to randomize test.")
  m_iicTestVseq.start(v_sqr);

  #P_TESTRUNOUT;
  phase.drop_objection(this,"iicMasterTxTest");

endtask

`endif

