
class iicSlaveFrameSeq extends iicFrameSeq;
 `uvm_object_utils(iicSlaveFrameSeq)

 string           m_name;

 ui               m_interFrameDelay;



 /// Methods
 //
 
 extern function new(string name = "iicSlaveFrameSeq");
 extern virtual task body;

 ////Constraints
 //
 constraint c_interFrameDelay {m_interFrameDelay inside {[0:P_MAXINTERFRAMEDELAY_XT]};}


endclass

function iicSlaveFrameSeq::new(string name = "iicSlaveFrameSeq");
 super.new(name);
 m_name = name;
endfunction

task iicSlaveFrameSeq::body;
 super.body;

 `uvm_info(m_name, "start to send i2c slave frame seq.", UVM_HIGH)
endtask

