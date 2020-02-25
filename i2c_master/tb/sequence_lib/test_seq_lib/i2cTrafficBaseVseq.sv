`ifndef I2C_TRAFFIC_BASE_VSEQ__SV
`define I2C_TRAFFIC_BASE_VSEQ__SV

class frameData extends uvm_object;
 `uvm_object_utils(frameData)

  rand bit[7:0] m_data[MAXFRAMELENGTH];

endclass

//virtual class iicTrafficBaseVseq extends i2c_base_vseq;
class iicTrafficBaseVseq extends i2c_base_vseq;

 `uvm_object_utils(iicTrafficBaseVseq)

 //// Data
 //
 // Random data
 rand ui  m_numberOfFrames;

 // Non - randomised data

 ui          m_frameNumber;
 
 //// Methods
 //
 extern function new(string name = "iicTrafficBaseVseq");
 extern virtual task body;
 extern function void printSettings;


 //// Constraints
 //
 constraint c_numberOfFrames {m_numberOfFrames inside {[1:100]};}

endclass


function iicTrafficBaseVseq::new(string name = "iicTrafficBaseVseq");
 super.new(name);
 m_name = name;
endfunction

task iicTrafficBaseVseq::body;
 super.body;

 printSettings;

endtask


function void iicTrafficBaseVseq::printSettings;
 $display(""); 
 $display("**** RANDOMISED SETTINGS %s",m_name);
 $display("m_numberOfFrames      = %d",m_numberOfFrames);
 $display(""); 
endfunction

`endif
