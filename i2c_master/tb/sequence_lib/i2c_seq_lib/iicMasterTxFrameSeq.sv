class iicMasterTxFrameSeq extends iicFrameSeq;
 `uvm_object_utils(iicMasterTxFrameSeq)

 string           m_name;

 /// Methods
 //
 
 extern function new(string name = "iicMasterTxFrameSeq");
 extern virtual task body;

 ////Constraints
 //

endclass

function iicMasterTxFrameSeq::new(string name = "iicMasterTxFrameSeq");
 super.new(name);
 m_name = name;
 m_direction_e = I2C_DIR_WRITE; // write data to slave.
endfunction

task iicMasterTxFrameSeq::body;
 super.body;

endtask



