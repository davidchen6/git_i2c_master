class iicMasterRxFrameSeq extends iicFrameSeq;
 `uvm_object_utils(iicMasterRxFrameSeq)

 string           m_name;

 /// Methods
 //
 
 extern function new(string name = "iicMasterRxFrameSeq");
 extern virtual task body;

 ////Constraints
 //

endclass

function iicMasterRxFrameSeq::new(string name = "iicMasterRxFrameSeq");
 super.new(name);
 m_name = name;
 m_direction_e = I2C_DIR_READ; // read data from slave.
endfunction

task iicMasterRxFrameSeq::body;
 super.body;

endtask



