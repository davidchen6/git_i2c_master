`ifndef I2C_TEST_BASE_VSEQ__SV
`define I2C_TEST_BASE_VSEQ__SV

class i2c_test_base_vseq extends i2c_base_vseq;

 //// Methods
 //

 extern function new(string name = "i2c_test_base_vseq");
 extern virtual task body;
 extern virtual function void pairAddress;
 extern virtual function void printSettings;
 extern virtual function void printSeq;
 extern virtual function void createSequences;
 extern virtual function void setupMasterSeqList;
 extern virtual function void pairSequences;
 extern virtual function void randomizeSequences;
 extern virtual task startSequences;


 //// Data
 //

 //Randomised data
 rand e_i2c_frequency_mode m_iicBusSpeed;
 rand ui  m_sclFrequencyXt;       //kHz
 rand ui  m_sclFrequencyDut;      //kHz
 rand ui  m_sclFrequencyDutSlave; //kHz

 rand iicSlaveAddress m_iicAddress1;
 rand iicSlaveAddress m_iicAddress2;
 rand iicSlaveAddress m_iicAddress3;
 rand iicSlaveAddress m_iicAddress4;
 /*
 rand iicSlaveAddress m_iicSlave1Address;
 rand iicSlaveAddress m_iicSlave2Address;
 rand iicSlaveAddress m_iicSlave3Address;
 rand iicSlaveAddress m_iicSlave4Address;

 rand iicSlaveAddress m_dutTxAddress;
 rand iicSlaveAddress m_dutRxAddress;

 rand iicSlaveAddress m_xtTxAddress;
 rand iicSlaveAddress m_xtRxAddress;
 */

 // Non - randomized data
 iicSlaveAddress m_iicSlave1Address;
 iicSlaveAddress m_iicSlave2Address;
 iicSlaveAddress m_iicSlave3Address;
 iicSlaveAddress m_iicSlave4Address;

 iicSlaveAddress m_dutTxAddress;
 iicSlaveAddress m_dutRxAddress;

 iicSlaveAddress m_xtTxAddress;
 iicSlaveAddress m_xtRxAddress;
 
 wbFrameSeq m_dutMasterSeqsList[$];
 iicFrameSeq m_xtMasterSeqsList[$];
 
 //Virtual traffic sequences
 dut_traffic_base_vseq m_dutTrafficVseq;
 xt_traffic_base_vseq m_xtTrafficVseq;

 //Agent sequences availabe for creating traffic.
 iicMasterTxFrameSeq m_iicMasterTxFrameSeq; 
 iicMasterRxFrameSeq m_iicMasterRxFrameSeq; 
 iicSlaveFrameSeq  m_iicSlaveTx1FrameSeq;  
 iicSlaveFrameSeq  m_iicSlaveRx1FrameSeq;  
 iicSlaveFrameSeq  m_iicSlaveTx2FrameSeq;  
 iicSlaveFrameSeq  m_iicSlaveRx2FrameSeq;  
 
 wbFrameSeq          m_wbMasterTxFrameSeq;
 wbFrameSeq          m_wbMasterRxFrameSeq;


 `uvm_object_utils_begin(i2c_test_base_vseq)
	`uvm_field_int(m_iicAddress1.m_slaveAddress, UVM_ALL_ON)
	`uvm_field_int(m_iicAddress2.m_slaveAddress, UVM_ALL_ON)
	`uvm_field_int(m_iicAddress3.m_slaveAddress, UVM_ALL_ON)
	`uvm_field_int(m_iicAddress4.m_slaveAddress, UVM_ALL_ON)
 `uvm_object_utils_end

 //// Constraints
 // 

 constraint c_slaveAddress {
  m_iicAddress1.m_slaveAddress != m_iicAddress2.m_slaveAddress;
  m_iicAddress1.m_slaveAddress != m_iicAddress3.m_slaveAddress;
  m_iicAddress1.m_slaveAddress != m_iicAddress4.m_slaveAddress;
  m_iicAddress2.m_slaveAddress != m_iicAddress3.m_slaveAddress;
  m_iicAddress2.m_slaveAddress != m_iicAddress4.m_slaveAddress;
  m_iicAddress3.m_slaveAddress != m_iicAddress4.m_slaveAddress;  
  solve m_iicAddress1.m_slaveAddress before m_iicAddress2.m_slaveAddress;
  solve m_iicAddress2.m_slaveAddress before m_iicAddress3.m_slaveAddress;
  solve m_iicAddress3.m_slaveAddress before m_iicAddress4.m_slaveAddress;
 }
/*
 constraint c_iicSlave1Address {
  m_iicSlave1Address.m_slaveAddress inside {m_iicAddress1.m_slaveAddress,m_iicAddress2.m_slaveAddress};  //TX1
 }

 constraint c_iicSlave2Address {
  m_iicSlave2Address.m_slaveAddress inside {m_iicAddress1.m_slaveAddress,m_iicAddress2.m_slaveAddress};  //RX1
 }

 constraint c_iicSlave3Address {
  m_iicSlave3Address.m_slaveAddress inside {m_iicAddress3.m_slaveAddress,m_iicAddress4.m_slaveAddress};  //TX2
 }

 constraint c_iicSlave4Address {
  m_iicSlave4Address.m_slaveAddress inside {m_iicAddress3.m_slaveAddress,m_iicAddress4.m_slaveAddress};  //RX2
 }

 constraint c_dutTxAddress {
  m_dutTxAddress.m_slaveAddress inside {m_iicSlave2Address.m_slaveAddress,m_iicSlave4Address.m_slaveAddress};
  solve m_iicSlave2Address.m_slaveAddress before m_dutTxAddress.m_slaveAddress;
  solve m_iicSlave4Address.m_slaveAddress before m_dutTxAddress.m_slaveAddress;
 }
 constraint c_dutRxAddress {
  m_dutRxAddress.m_slaveAddress inside {m_iicSlave1Address.m_slaveAddress,m_iicSlave3Address.m_slaveAddress};
  solve m_iicSlave1Address.m_slaveAddress before m_dutRxAddress.m_slaveAddress;
  solve m_iicSlave3Address.m_slaveAddress before m_dutRxAddress.m_slaveAddress;
 }

 constraint c_xtTxAddress {
  m_xtTxAddress.m_slaveAddress inside {m_iicSlave2Address.m_slaveAddress,m_iicSlave4Address.m_slaveAddress};
  solve m_iicSlave2Address.m_slaveAddress before m_xtTxAddress.m_slaveAddress;
  solve m_iicSlave4Address.m_slaveAddress before m_xtTxAddress.m_slaveAddress;
 }
 constraint c_xtRxAddress {
  m_xtRxAddress.m_slaveAddress inside {m_iicSlave1Address.m_slaveAddress,m_iicSlave3Address.m_slaveAddress};
  solve m_iicSlave1Address.m_slaveAddress before m_xtRxAddress.m_slaveAddress;
  solve m_iicSlave3Address.m_slaveAddress before m_xtRxAddress.m_slaveAddress;
 }

 constraint c_rxarbitration {
  m_xtRxAddress.m_slaveAddress != m_dutRxAddress.m_slaveAddress;
  solve  m_xtRxAddress.m_slaveAddress before m_dutRxAddress.m_slaveAddress;
 }

*/
 constraint c_sclFrequencyXt {
  if (m_iicBusSpeed==I2C_STANDARD_MODE) {
   m_sclFrequencyXt inside {[10:100]};
  } else {
   m_sclFrequencyXt inside {[101:400]};
  }
  solve m_iicBusSpeed before m_sclFrequencyXt;
 }

 constraint c_sclFrequencyDut {
  if (m_iicBusSpeed==I2C_STANDARD_MODE) {
   m_sclFrequencyDut inside {[10:100]};
  } else {
   m_sclFrequencyDut inside {[101:400]};
  }
  solve m_iicBusSpeed before m_sclFrequencyDut;
 }

 constraint c_sclFrequencyDutSlave {
  if (m_iicBusSpeed==I2C_STANDARD_MODE) {
   m_sclFrequencyDutSlave inside {[10:100]};
  } else {
   m_sclFrequencyDutSlave inside {[101:400]};
  }
  solve m_iicBusSpeed before m_sclFrequencyDutSlave;
 }


endclass


function i2c_test_base_vseq::new(string name = "i2c_test_base_vseq");
 super.new(name);
 m_name = name;
 m_iicAddress1 = iicSlaveAddress::type_id::create("m_iicAddress1");
 m_iicAddress2 = iicSlaveAddress::type_id::create("m_iicAddress2");
 m_iicAddress3 = iicSlaveAddress::type_id::create("m_iicAddress3");
 m_iicAddress4 = iicSlaveAddress::type_id::create("m_iicAddress4");

 m_iicSlave1Address = iicSlaveAddress::type_id::create("m_iicSlave1Address");
 m_iicSlave2Address = iicSlaveAddress::type_id::create("m_iicSlave2Address");
 m_iicSlave3Address = iicSlaveAddress::type_id::create("m_iicSlave3Address");
 m_iicSlave4Address = iicSlaveAddress::type_id::create("m_iicSlave4Address");

 m_dutTxAddress = iicSlaveAddress::type_id::create("m_dutTxAddress");
 m_dutRxAddress = iicSlaveAddress::type_id::create("m_dutRxAddress");

 m_xtTxAddress = iicSlaveAddress::type_id::create("m_xtTxAddress");
 m_xtRxAddress = iicSlaveAddress::type_id::create("m_xtRxAddress");

endfunction


task i2c_test_base_vseq::body;

 super.body;

 pairAddress();
 printSettings;

 //Frequencies
 m_wb3_agent_cfg.m_sclFrequency = m_sclFrequencyDut;                //DUT Master
 m_i2c_slv1_cfg.vif.setBusFrequency(m_sclFrequencyDutSlave); //DUT Slave
 m_i2c_mstr_cfg.vif.setBusFrequency(m_sclFrequencyXt);       //xT  Master
 m_i2c_slv3_cfg.vif.setBusFrequency(m_sclFrequencyXt);       //xT  Slave

 createSequences;
 pairSequences;
 setupMasterSeqList;
 randomizeSequences;
 printSeq;
 startSequences;

endtask


function void i2c_test_base_vseq::printSettings;
 $display(""); 
 $display("**** RANDOMISED SETTINGS iicBaseVseq");
 $display(""); 
 $display("m_iicBusSpeed           = %s",m_iicBusSpeed.name());
 $display("m_sclFrequencyXt        = %d",m_sclFrequencyXt);
 $display("m_sclFrequencyDut       = %d",m_sclFrequencyDut);
 $display("m_sclFrequencyDutSlave  = %d",m_sclFrequencyDutSlave);
 $display(""); 
 $display("m_iicSlave1Address      = %h  //TX1",m_iicSlave1Address.m_slaveAddress);
 $display("m_iicSlave2Address      = %h  //RX1",m_iicSlave2Address.m_slaveAddress);
 $display("m_iicSlave3Address      = %h  //TX2",m_iicSlave3Address.m_slaveAddress);
 $display("m_iicSlave4Address      = %h  //RX2",m_iicSlave4Address.m_slaveAddress);
 $display(""); 
 $display("m_dutTxAddress          = %h",m_dutTxAddress.m_slaveAddress);
 $display("m_dutRxAddress          = %h",m_dutRxAddress.m_slaveAddress);
 $display(""); 
 $display("m_xtTxAddress           = %h",m_xtTxAddress.m_slaveAddress);
 $display("m_xtRxAddress           = %h",m_xtRxAddress.m_slaveAddress);
 $display(""); 
endfunction


function void i2c_test_base_vseq::randomizeSequences;

 if (!m_dutTrafficVseq.randomize)
  `uvm_fatal(m_name, "Failed to randomize the DUT traffic vseq.")

 if (!m_xtTrafficVseq.randomize)
  `uvm_fatal(m_name, "Failed to randomize the cross traffic vseq.")

 if (!m_iicSlaveTx1FrameSeq.randomize() with {
                                          m_ackProbability > 90;
                                            }
 )
 `uvm_fatal(m_name, "Failed to randomize m_iicSlaveTx1FrameSeq.")

 if (!m_iicSlaveTx2FrameSeq.randomize() with {
                                          m_ackProbability > 90;
                                            }
 )
 `uvm_fatal(m_name, "Failed to randomize m_iicSlaveTx2FrameSeq.")


 if (!m_iicSlaveRx1FrameSeq.randomize() with {
                                          m_ackProbability > 90;
                                            }
 )
 `uvm_fatal(m_name, "Failed to randomize m_iicSlaveRx1FrameSeq.") 

 if (!m_iicSlaveRx2FrameSeq.randomize() with {
                                          m_ackProbability > 90;
                                            }
 )
 `uvm_fatal(m_name, "Failed to randomize m_iicSlaveRx2FrameSeq.") 


endfunction

function void i2c_test_base_vseq::printSeq();
// m_dutTrafficVseq.print();
// m_xtTrafficVseq.print();
 m_iicSlaveTx1FrameSeq.print();
 m_iicSlaveTx2FrameSeq.print();
 m_iicSlaveRx1FrameSeq.print();
 m_iicSlaveRx2FrameSeq.print();
endfunction

function void i2c_test_base_vseq::createSequences;

 m_dutTrafficVseq =  dut_traffic_base_vseq::type_id::create("m_dutTrafficVseq");
 m_xtTrafficVseq  =  xt_traffic_base_vseq::type_id::create("m_xtTrafficVseq");

 m_iicMasterTxFrameSeq = iicMasterTxFrameSeq::type_id::create("m_iicMasterTxFrameSeq");
 m_iicMasterRxFrameSeq = iicMasterRxFrameSeq::type_id::create("m_iicMasterRxFrameSeq");

 m_iicSlaveTx1FrameSeq  = iicSlaveFrameSeq::type_id::create("m_iicSlaveTx1FrameSeq");
 m_iicSlaveRx1FrameSeq  = iicSlaveFrameSeq::type_id::create("m_iicSlaveRx1FrameSeq");
 m_iicSlaveTx2FrameSeq  = iicSlaveFrameSeq::type_id::create("m_iicSlaveTx2FrameSeq");
 m_iicSlaveRx2FrameSeq  = iicSlaveFrameSeq::type_id::create("m_iicSlaveRx2FrameSeq");

 m_wbMasterTxFrameSeq  = wbMasterTxFrameSeq::type_id::create("m_wbMasterTxFrameSeq");
 m_wbMasterRxFrameSeq  = wbMasterRxFrameSeq::type_id::create("m_wbMasterRxFrameSeq");  

endfunction


//function void i2c_test_base_vseq::pairSequences;
//
// ////Master Seqs.
//
// //DUT
// m_iicMasterTxFrameSeq.m_iicAddress = m_slaveAddressDevice1.m_slaveAddress;
// m_iicMasterRxFrameSeq.m_iicAddress = m_slaveAddressDevice2.m_slaveAddress;
//
// //xT
// m_wbMasterTxFrameSeq.m_iicAddress = m_slaveAddressDevice1.m_slaveAddress;
// m_wbMasterRxFrameSeq.m_iicAddress = m_slaveAddressDevice2.m_slaveAddress; 
//
// /// Slave Seqs.
// m_iicSlaveTxFrameSeq.m_iicAddress = m_slaveAddressDevice2.m_slaveAddress;
// m_iicSlaveRxFrameSeq.m_iicAddress = m_slaveAddressDevice1.m_slaveAddress;
// 
//endfunction

function void i2c_test_base_vseq::pairAddress();

 m_iicSlave1Address.m_slaveAddress = m_iicAddress1.m_slaveAddress;
 m_iicSlave2Address.m_slaveAddress = m_iicAddress2.m_slaveAddress;
 m_iicSlave3Address.m_slaveAddress = m_iicAddress3.m_slaveAddress;
 m_iicSlave4Address.m_slaveAddress = m_iicAddress4.m_slaveAddress;

 m_dutTxAddress.m_slaveAddress = m_iicSlave1Address.m_slaveAddress;
 m_dutRxAddress.m_slaveAddress = m_iicSlave2Address.m_slaveAddress;
 m_xtTxAddress.m_slaveAddress = m_iicSlave3Address.m_slaveAddress;
 m_xtRxAddress.m_slaveAddress = m_iicSlave4Address.m_slaveAddress;
 
endfunction

function void i2c_test_base_vseq::pairSequences;
 //
 m_wbMasterTxFrameSeq.m_iicAddress = m_dutTxAddress.m_slaveAddress;
 m_wbMasterRxFrameSeq.m_iicAddress = m_dutRxAddress.m_slaveAddress;
 //
 m_iicMasterTxFrameSeq.m_iicAddress = m_xtTxAddress.m_slaveAddress;
 m_iicMasterRxFrameSeq.m_iicAddress = m_xtRxAddress.m_slaveAddress;
 //
 m_iicSlaveTx1FrameSeq.m_iicAddress = m_iicSlave1Address.m_slaveAddress;
 m_iicSlaveRx1FrameSeq.m_iicAddress = m_iicSlave2Address.m_slaveAddress;
 m_iicSlaveTx2FrameSeq.m_iicAddress = m_iicSlave3Address.m_slaveAddress; 
 m_iicSlaveRx2FrameSeq.m_iicAddress = m_iicSlave4Address.m_slaveAddress;

endfunction

task i2c_test_base_vseq::startSequences;

 fork 
  m_dutTrafficVseq.start(m_dut_sequencer);
  fork
   m_xtTrafficVseq.start(m_mstr_sequencer);
   m_iicSlaveTx1FrameSeq.start(m_dev1_sequencer);
   m_iicSlaveRx1FrameSeq.start(m_dev2_sequencer);
   m_iicSlaveTx2FrameSeq.start(m_dev3_sequencer);
   m_iicSlaveRx2FrameSeq.start(m_dev4_sequencer);
  join 
 join_any

endtask

function void i2c_test_base_vseq::setupMasterSeqList;

 //DUT Master Sequence List
 m_dutMasterSeqsList.push_back(m_wbMasterTxFrameSeq);
 m_dutMasterSeqsList.push_back(m_wbMasterRxFrameSeq);
 m_dutTrafficVseq.m_masterSeqsList = m_dutMasterSeqsList;
 
 //Cross traffic Master Sequence List 
 m_xtMasterSeqsList.push_back(m_iicMasterTxFrameSeq);
 m_xtMasterSeqsList.push_back(m_iicMasterRxFrameSeq); 
 m_xtTrafficVseq.m_masterSeqsList = m_xtMasterSeqsList;

endfunction

`endif
