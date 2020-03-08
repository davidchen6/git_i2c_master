`ifndef DUT_TRAFFIC_BASE_VSEQ__SV
`define DUT_TRAFFIC_BASE_VSEQ__SV

class dut_traffic_base_vseq extends iicTrafficBaseVseq;
 `uvm_object_utils(dut_traffic_base_vseq)

 //// Data
 //

  //Set by calling sequence
  wbFrameSeq           m_masterSeqsList[$];


  // Randomized data
 
  // Non - randomized data

  wbFrameSeq           m_wbMasterTxFrameSeq;
  wbFrameSeq           m_wbMasterRxFrameSeq;
  wbFrameSeq           m_masterSeq;
  ui                   m_interFrameDelay;


 //// Methods
 //
 extern function new(string name = "dut_traffic_base_vseq");
 extern virtual task body;
 extern virtual function void randomizeSequences;

endclass

function dut_traffic_base_vseq::new(string name = "dut_traffic_base_vseq");
 super.new(name);
 m_name = name;
endfunction


task dut_traffic_base_vseq::body;
 super.body;

 for (m_frameNumber=0; m_frameNumber<m_numberOfFrames; m_frameNumber++) begin

  //Randomly select master sequence to run.
  m_masterSeq = m_masterSeqsList[$urandom_range(m_masterSeqsList.size()-1)];

  //Randomize the m_masterSeq sequence.
  randomizeSequences;
  m_masterSeq.print();
  m_masterSeq.start(m_dut_sequencer);

  m_interFrameDelay = $urandom_range(P_MAXINTERFRAMEDELAY_DUT,P_MININTERFRAMEDELAY_DUT);
  #(m_interFrameDelay*m_i2c_slv1_cfg.vif.m_sclClockPeriod);

 end 
 
endtask


function void dut_traffic_base_vseq::randomizeSequences;

  //Randomize sequences and send.
  if (m_masterSeq==null)
   `uvm_fatal(m_name, "Null handle for master sequence.")
  if (m_frameNumber==m_numberOfFrames-1) begin
   if (!m_masterSeq.randomize() with {
                                    m_relinquishBus == 1;
                                     }
   )
    `uvm_fatal(m_name,"Failed to randomize master frame sequence.")
  end else begin
   if (!m_masterSeq.randomize())
    `uvm_fatal(m_name,"Failed to randomize master frame sequence.")
  end
endfunction

`endif
