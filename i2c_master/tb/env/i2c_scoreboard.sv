`ifndef I2C_SCOREBOARD__SV
`define I2C_SCOREBOARD__SV

`uvm_analysis_imp_decl(_dut)
`uvm_analysis_imp_decl(_master)
`uvm_analysis_imp_decl(_slv1)
`uvm_analysis_imp_decl(_slv2)
`uvm_analysis_imp_decl(_slv3)
`uvm_analysis_imp_decl(_slv4)

class i2c_scoreboard extends uvm_scoreboard;
   bit[8:0]  dut_data_queue[$];
   bit[8:0]  master_data_queue[$];
   bit[8:0]  dut_slv_data_queue[$];
   bit[8:0]  master_slv_data_queue[$];
   
   bit[8:0]  m_dut_data;
   bit[8:0]  m_master_data;
   bit[8:0]  m_dut_slv_data;
   bit[8:0]  m_master_slv_data;
   
   typedef enum {waitforMasterData, compareData} scbdState_e;
   scbdState_e dut_scbdState;
   scbdState_e master_scbdState;
   //reg_model  p_rm;
   uvm_analysis_imp_dut #(bit[8:0], i2c_scoreboard)  dut_data_port;
   uvm_analysis_imp_master #(bit[8:0], i2c_scoreboard)  master_data_port;
   uvm_analysis_imp_slv1#(bit[8:0], i2c_scoreboard)  slv1_data_port;
   uvm_analysis_imp_slv2#(bit[8:0], i2c_scoreboard)  slv2_data_port;
   uvm_analysis_imp_slv3#(bit[8:0], i2c_scoreboard)  slv3_data_port;
   uvm_analysis_imp_slv4#(bit[8:0], i2c_scoreboard)  slv4_data_port;
   
   string m_name;

   bit resetDutscb;
   bit resetMasterscb;

   `uvm_component_utils(i2c_scoreboard)

   extern function new(string name, uvm_component parent = null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void write_dut(bit[8:0] dut_data);
   extern virtual function void write_master(bit[8:0] master_data);
   extern virtual function void write_slv1(bit[8:0] slv1_data);
   extern virtual function void write_slv2(bit[8:0] slv2_data);
   extern virtual function void write_slv3(bit[8:0] slv3_data);
   extern virtual function void write_slv4(bit[8:0] slv4_data);
   extern virtual task compareDutData();
   extern virtual task compareMasterData();
   extern virtual task run_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
endclass 

function i2c_scoreboard::new(string name, uvm_component parent = null);
   super.new(name, parent);
   m_name = name;
endfunction 

function void i2c_scoreboard::build_phase(uvm_phase phase);
   super.build_phase(phase);
   dut_data_port = new("dut_data_port", this);
   master_data_port = new("master_data_port", this);
   slv1_data_port = new("slv1_data_port", this);
   slv2_data_port = new("slv2_data_port", this);
   slv3_data_port = new("slv3_data_port", this);
   slv4_data_port = new("slv4_data_port", this);
endfunction 

function void i2c_scoreboard::write_dut(bit[8:0] dut_data);

   `uvm_info(m_name, $psprintf("Dut data received = %h", dut_data), UVM_LOW)
   dut_data_queue.push_back(dut_data);
//   `uvm_info(m_name, $psprintf("dut_data_queue size is : %h", dut_data_queue.size()), UVM_LOW);
endfunction

function void i2c_scoreboard::write_master(bit[8:0] master_data);

   `uvm_info(m_name, $psprintf("Master data received = %h", master_data), UVM_LOW)
   master_data_queue.push_back(master_data);
endfunction

function void i2c_scoreboard::write_slv1(bit[8:0] slv1_data);

   `uvm_info(m_name, $psprintf("Slv1 data received = %h", slv1_data), UVM_LOW)
   dut_slv_data_queue.push_back(slv1_data);
   master_slv_data_queue.push_back(slv1_data);
//   `uvm_info(m_name, $psprintf("dut_slv_data_queue size is : %h", dut_slv_data_queue.size()), UVM_LOW);
endfunction

function void i2c_scoreboard::write_slv2(bit[8:0] slv2_data);

   `uvm_info(m_name, $psprintf("Slv2 data received = %h", slv2_data), UVM_LOW)
   dut_slv_data_queue.push_back(slv2_data);
   master_slv_data_queue.push_back(slv2_data);
endfunction

function void i2c_scoreboard::write_slv3(bit[8:0] slv3_data);

   `uvm_info(m_name, $psprintf("Slv3 data received = %h", slv3_data), UVM_LOW)
   dut_slv_data_queue.push_back(slv3_data);
   master_slv_data_queue.push_back(slv3_data);
endfunction

function void i2c_scoreboard::write_slv4(bit[8:0] slv4_data);

   `uvm_info(m_name, $psprintf("Slv4 data received = %h", slv4_data), UVM_LOW)
   dut_slv_data_queue.push_back(slv4_data);
   master_slv_data_queue.push_back(slv4_data);
endfunction

task i2c_scoreboard::compareDutData();

   dut_scbdState = waitforMasterData;

   forever begin
     case (dut_scbdState)
	   waitforMasterData: begin
  //       `uvm_info(m_name,  "DUT data compare started ", UVM_LOW);
	     wait(dut_data_queue.size());
		 resetDutscb = dut_data_queue[0][8];
		 m_dut_data = dut_data_queue[0][7:0];
		 dut_data_queue.pop_front();

		 if (resetDutscb) begin
		   wait(dut_slv_data_queue.size());
		   dut_slv_data_queue.delete();
		   if (dut_data_queue.size()) begin
		     `uvm_fatal(m_name, "Error. Attempt to reset SCB before all master data has been checked.")
		   end
		 end

		 else begin
		   dut_scbdState = compareData;
		 end
	   end

       compareData: begin
	     $display("dut_slv_data_queue size is : %h", dut_slv_data_queue.size());
		 wait(dut_slv_data_queue.size());
		 m_dut_slv_data = dut_slv_data_queue[0][7:0];
	     dut_slv_data_queue.pop_front();

		 if (m_dut_slv_data != m_dut_data) begin
		   `uvm_fatal(m_name, $psprintf("Dut : Data mismatch. Master Data = %h, Slave Data = %h",m_dut_data,m_dut_slv_data ))
		   //`uvm_info(m_name,  $psprintf("Dut : Data dismatch. Master Data = %h, Slave Data = %h",m_dut_data,m_dut_slv_data ), UVM_LOW)
		 end

		 else begin
		   `uvm_info(m_name,  $psprintf("Dut : Successful match. Master Data = %h, Slave Data = %h",m_dut_data,m_dut_slv_data ), UVM_LOW)
		 end
		 dut_scbdState = waitforMasterData;
	   end
	 //
	 endcase
	 //
   end
endtask

task i2c_scoreboard::compareMasterData();

   master_scbdState = waitforMasterData;

   forever begin
     case (master_scbdState)
	   waitforMasterData: begin
	     wait(master_data_queue.size());
		 resetMasterscb = master_data_queue[0][8];
		 m_master_data = master_data_queue[0][7:0];
		 master_data_queue.pop_front();

		 if (resetMasterscb) begin
		   wait(master_slv_data_queue.size());
		   master_slv_data_queue.delete();
		   if (master_data_queue.size()) begin
		     `uvm_fatal(m_name, "Error. Attempt to reset SCB before all master data has been checked.")
		   end
		 end

		 else begin
		   master_scbdState = compareData;
		 end
	   end

       compareData: begin
	     wait(master_slv_data_queue.size());
		 m_master_slv_data = master_slv_data_queue[0][7:0];
		 master_slv_data_queue.pop_front();
		 if (m_master_slv_data != m_master_data) begin
		   `uvm_fatal(m_name, $psprintf("Master : Data mismatch. Master Data = %h, Slave Data = %h",m_master_data,m_master_slv_data ))
		 end

		 else begin
		   `uvm_info(m_name,  $psprintf("Master : Successful match. Master Data = %h, Slave Data = %h",m_master_data,m_master_slv_data ), UVM_LOW)
		 end
		 master_scbdState = waitforMasterData;
	   end
	 //
	 endcase
	 //
   end
endtask

task i2c_scoreboard::run_phase(uvm_phase phase);
   bit[8:0]  get_expect,  get_actual, tmp_tran;
   bit result;
 
   super.run_phase(phase);
    `uvm_info(m_name,  "run phase started ", UVM_LOW);
   fork 
      compareDutData();
      compareMasterData();
   join
endtask

function void i2c_scoreboard::report_phase(uvm_phase phase);
 if (dut_data_queue.size()) begin
  `uvm_error(m_name, "Unchecked data from dut.")
  foreach (dut_data_queue[i]) begin
   $display("Unchecked dut data = %h",dut_data_queue[i][7:0]);
  end
 end

 if (master_data_queue.size()) begin
  `uvm_error(m_name, "Unchecked data from master.")
  foreach (master_data_queue[i]) begin
   $display("Unchecked master data = %h",master_data_queue[i][7:0]);
  end
 end

endfunction

`endif
