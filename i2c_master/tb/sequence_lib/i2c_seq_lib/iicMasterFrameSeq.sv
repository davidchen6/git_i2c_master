class iicMasterFrameSeq extends iicFrameSeq;
 `uvm_object_utils(iicMasterFrameSeq)

 string           m_name;

 ui               m_interFrameDelay;



 /// Methods
 //
 
 extern function new(string name = "iicMasterFrameSeq");
 extern virtual task body;

 ////Constraints
 //
 constraint c_interFrameDelay {m_interFrameDelay inside {[0:P_MAXINTERFRAMEDELAY_XT]};}


endclass

function iicMasterFrameSeq::new(string name = "iicMasterFrameSeq");
 super.new(name);
 m_name = name;
endfunction

task iicMasterFrameSeq::body;
 super.body;
/*
 if (m_forceArbitrationEvent) begin
  //Wait for start condition on Bus.
  while(1) begin
   @(negedge m_iicIf.sda_in)
   if (m_iicIf.scl_in) 
    break;
  end
 end else begin
  repeat(m_interFrameDelay)
   @(posedge m_iicIf.scl_in);
 end
*/
endtask



