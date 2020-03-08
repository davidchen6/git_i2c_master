
class iicXtTraffic_MasterTx_Vseq extends xt_traffic_base_vseq;
 `uvm_object_utils(iicXtTraffic_MasterTx_Vseq)

 //// Methods
 //
 extern function new(string name = "iicXtTraffic_MasterTx_Vseq");
 extern virtual function void randomizeSequences;

endclass

function iicXtTraffic_MasterTx_Vseq::new(string name = "iicXtTraffic_MasterTx_Vseq");
 super.new(name);
 m_name = name;
endfunction


function void iicXtTraffic_MasterTx_Vseq::randomizeSequences;
  //Randomize sequences and send.
  if (m_masterSeq==null)
   `uvm_fatal(m_name, "Null handle for master sequence.")
  if (!m_masterSeq.randomize() with {
                                  m_frameLength==3;
                                  m_relinquishBus==1;
                                    }
  )
  `uvm_fatal(m_name,"Failed to randomize master frame sequence.")
endfunction



