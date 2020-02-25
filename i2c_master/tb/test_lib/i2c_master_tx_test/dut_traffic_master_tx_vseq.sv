`ifndef DUT_TRAFFIC_MASTER_TX_VSEQ__SV
`define DUT_TRAFFIC_MASTER_TX_VSEQ__SV

class iicDutTraffic_MasterTx_Vseq extends dut_traffic_base_vseq;
 `uvm_object_utils(iicDutTraffic_MasterTx_Vseq)



 //// Methods
 //
 extern function new(string name = "iicDutTraffic_MasterTx_Vseq");
 extern virtual function void randomizeSequences;

endclass

function iicDutTraffic_MasterTx_Vseq::new(string name = "iicDutTraffic_MasterTx_Vseq");
 super.new(name);
 m_name = name;
endfunction


function void iicDutTraffic_MasterTx_Vseq::randomizeSequences;
  //Randomize sequences and send.
  if (m_masterSeq==null)
   `uvm_fatal(m_name, "Null handle for master sequence.")
  if (!m_masterSeq.randomize() with {
                                m_frameLength==2;
                                m_relinquishBus==1;
                                    }
   )
   `uvm_fatal(m_name,"Failed to randomize master frame sequence.")
endfunction

`endif

