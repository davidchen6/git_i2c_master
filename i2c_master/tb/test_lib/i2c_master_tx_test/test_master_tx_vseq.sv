`ifndef TEST_MASTER_TX_VSEQ__SV
`define TEST_MASTER_TX_VSEQ__SV

class iicTest_MasterTx_Vseq extends i2c_test_base_vseq;
 `uvm_object_utils(iicTest_MasterTx_Vseq)

 //// Methods
 //

 extern function new(string name = "iicTest_MasterTx_Vseq");
 extern virtual function void setupMasterSeqList;
 extern virtual function void randomizeSequences;

endclass


function iicTest_MasterTx_Vseq::new(string name = "iicTest_MasterTx_Vseq");
 super.new(name);
 m_name = name;
endfunction



function void iicTest_MasterTx_Vseq::randomizeSequences;

 if (!m_dutTrafficVseq.randomize with {m_numberOfFrames==1;}) 
  `uvm_fatal(m_name, "Failed to randomize the DUT traffic vseq.")

 if (!m_xtTrafficVseq.randomize with {m_numberOfFrames==1;}) 
  `uvm_fatal(m_name, "Failed to randomize the cross traffic vseq.")


 if (!m_iicSlaveTx1FrameSeq.randomize() with {
                                        m_relinquishBus==1;
                                        m_ackProbability==100;
                                        m_clockStretchingProbability==0;
                                            }
 )
 `uvm_fatal(m_name, "Failed to randomize m_iicSlaveTx1FrameSeq.")

 if (!m_iicSlaveTx2FrameSeq.randomize() with {
                                        m_relinquishBus==1;
                                        m_ackProbability==100;
                                        m_clockStretchingProbability==0;
                                            }
 )
 `uvm_fatal(m_name, "Failed to randomize m_iicSlaveTx2FrameSeq.")


 if (!m_iicSlaveRx1FrameSeq.randomize() with {
                                        m_relinquishBus==1;
                                        m_ackProbability==100;
                                        m_clockStretchingProbability==0;
                                            }
 )
 `uvm_fatal(m_name, "Failed to randomize m_iicSlaveRx1FrameSeq.") 

 if (!m_iicSlaveRx2FrameSeq.randomize() with {
                                        m_relinquishBus==1;
                                        m_ackProbability==100;
                                        m_clockStretchingProbability==0;
                                            }
 )
 `uvm_fatal(m_name, "Failed to randomize m_iicSlaveRx2FrameSeq.") 

endfunction



function void iicTest_MasterTx_Vseq::setupMasterSeqList;
 //DUT Master Sequence List
 m_dutMasterSeqsList.push_back(m_wbMasterTxFrameSeq);
 m_dutTrafficVseq.m_masterSeqsList = m_dutMasterSeqsList;

 m_xtMasterSeqsList.push_back(m_iicMasterTxFrameSeq);
 m_xtTrafficVseq.m_masterSeqsList = m_xtMasterSeqsList; 

 
endfunction

`endif

