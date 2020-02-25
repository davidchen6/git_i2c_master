`ifndef WBMASTERTXFRAMESEQ__SVH
`define WBMASTERTXFRAMESEQ__SVH

class wbMasterTxFrameSeq extends wbFrameSeq;
 `uvm_object_utils(wbMasterTxFrameSeq)

 bit[7:0] m_data;

 extern function new(string name = "wbMasterTxFrameSeq");
 extern task body;

endclass

function wbMasterTxFrameSeq::new(string name = "wbMasterTxFrameSeq");
 super.new(name);
endfunction

task wbMasterTxFrameSeq::body;
 super.body;

 wb3_vif.frameType = "Master TX";


 `uvm_info(m_name, $psprintf("START wbMasterTxFrameSeq. Length = ",m_frameLength), UVM_LOW)

 m_byteNumber = 0;

 forever begin

  case (m_frameState) 
   START : begin
    wb3_vif.frameState = "START";
//    sendStart;
    m_frameState = ADDRESS;
   end
   ADDRESS : begin
    wb3_vif.frameState = "ADDRESS";
    sendAddress(.rwb(1'b0)); //WR
    if (m_arbitrationLost) begin
     m_frameState = FINISHED;
    end else if (m_frameLength==1) begin
      m_frameState = STOP;
    end else begin
     m_localSequencer.m_ap.write({1'b1, 8'b0}); 
     m_frameState = ACK;
    end
   end
   DATA : begin
    wb3_vif.frameState = "DATA";
    //m_data  = $urandom_range(255,0);
    m_data  = m_frameData[m_byteNumber];
//    m_wb_seq_item.data[7:0] = m_data;
    value = m_data;
	sendData;
    if (m_arbitrationLost) begin
     m_frameState = FINISHED;
    end else begin
     m_localSequencer.m_ap.write({1'b0, m_data}); 
     m_frameState = ACK; 
    end  
   end
   ACK : begin
    wb3_vif.frameState = "ACK";
    if (m_ack) begin
     m_frameState = STOP;
    end else if (m_byteNumber==m_frameLength-1) begin
     m_frameState = STOP;
    end else begin
     m_frameState = DATA;
     m_byteNumber++;
    end
   end
   STOP : begin
    wb3_vif.frameState = "STOP";
    if (m_relinquishBus) begin
     //Send STOP
     //If the frame is only one byte long and the slave sent
     //an ACK then we MUST send a STOP.
     sendStop;
    end 
    m_frameState = FINISHED;    
   end
   FINISHED : begin
    wb3_vif.frameState = "FINISHED";
    break;
   end
   default : begin
    `uvm_fatal(m_name,"illegal state.")
   end
 
  endcase

 end //forever

 `uvm_info(m_name, $psprintf("FINISHED wbMasterTxFrameSeq. Length = ",m_frameLength), UVM_LOW)
 wb3_vif.comment = "FINISHED";

endtask

`endif
