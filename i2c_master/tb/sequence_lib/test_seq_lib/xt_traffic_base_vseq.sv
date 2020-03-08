class xt_traffic_base_vseq extends iicTrafficBaseVseq;
 `uvm_object_utils(xt_traffic_base_vseq)

 //// Data
 //

  //Set by calling sequence
  iicFrameSeq           m_masterSeqsList[$];


  // Randomized data
 
  // Non - randomized data

  iicFrameSeq           m_iicMasterTxFrameSeq;
  iicFrameSeq           m_iicMasterRxFrameSeq;
  iicFrameSeq           m_masterSeq;
  ui                    m_interFrameDelay;

  bit                   m_relinquishBus=1;


 //// Methods
 //
 extern function new(string name = "xt_traffic_base_vseq");
 extern virtual task body;
 extern virtual function void randomizeSequences;

endclass

function xt_traffic_base_vseq::new(string name = "xt_traffic_base_vseq");
 super.new(name);
 m_name = name;
endfunction


task xt_traffic_base_vseq::body;
 super.body;

 for (m_frameNumber=0; m_frameNumber<m_numberOfFrames; m_frameNumber++) begin

  //Randomly select master sequence to run.
  m_masterSeq = m_masterSeqsList[$urandom_range(m_masterSeqsList.size()-1)];

  //Randomize the m_masterSeq sequence.
  randomizeSequences;
  m_masterSeq.print();
  m_masterSeq.start(m_mstr_sequencer);

  m_interFrameDelay = $urandom_range(P_MAXINTERFRAMEDELAY_XT,P_MINTERFRAMEDELAY_XT);
  #(m_interFrameDelay*m_i2c_mstr_cfg.vif.m_sclClockPeriod);
   

 end 
 
endtask


function void xt_traffic_base_vseq::randomizeSequences;

  //Randomize sequences and send.
  if (m_masterSeq==null)
   `uvm_fatal(m_name, "Null handle for master sequence.")
  if (m_frameNumber==m_numberOfFrames-1) begin
   if (!m_masterSeq.randomize() with {
                                    m_relinquishBus == 1;
                                    m_forceArbitrationEvent == 0;
                                     }
   )
   `uvm_fatal(m_name,"Failed to randomize master frame sequence.")
  end else begin
   if (!m_relinquishBus) begin
    //xT still owns the bus. Can't therfore wait for a DUT
    //frame to start in order to force arbitration.
    if (!m_masterSeq.randomize() with {
                                  m_forceArbitrationEvent == 0;
                                      }
    )
     `uvm_fatal(m_name,"Failed to randomize master frame sequence.")
   end else begin
    if (!m_masterSeq.randomize())
     `uvm_fatal(m_name,"Failed to randomize master frame sequence.")
   end
  end
  m_relinquishBus = m_masterSeq.m_relinquishBus;
endfunction
