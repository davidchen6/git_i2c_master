`ifndef I2C_SCOREBOARD__SV
`define I2C_SCOREBOARD__SV
class i2c_scoreboard extends uvm_scoreboard;
   bit[8:0]  expect_queue[$];
   //reg_model  p_rm;
   uvm_blocking_get_port #(bit[8:0])  exp_port;
   uvm_blocking_get_port #(bit[8:0])  act_port;
   `uvm_component_utils(i2c_scoreboard)

   extern function new(string name, uvm_component parent = null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual task main_phase(uvm_phase phase);
endclass 

function i2c_scoreboard::new(string name, uvm_component parent = null);
   super.new(name, parent);
endfunction 

function void i2c_scoreboard::build_phase(uvm_phase phase);
   super.build_phase(phase);
   exp_port = new("exp_port", this);
   act_port = new("act_port", this);
endfunction 

task i2c_scoreboard::main_phase(uvm_phase phase);
   bit[8:0]  get_expect,  get_actual, tmp_tran;
   bit result;
 
   super.main_phase(phase);
    $display({"main phase for: ", get_full_name()});
   fork 
      while (1) begin
         exp_port.get(get_expect);
         expect_queue.push_back(get_expect);
      end
      while (1) begin
         act_port.get(get_actual);
         if(expect_queue.size() > 0) begin
            tmp_tran = expect_queue.pop_front();
   //         result = get_actual.compare(tmp_tran);
            //if(result) begin 
            if(get_actual == tmp_tran) begin 
               `uvm_info("i2c_scoreboard", "Compare SUCCESSFULLY", UVM_LOW);
            end
            else begin
               `uvm_error("i2c_scoreboard", "Compare FAILED");
               $display("the expect pkt is %h", tmp_tran);
               //tmp_tran.print();
               $display("the actual pkt is %h", get_actual);
               //get_actual.print();
            end
         end
         else begin
            `uvm_error("i2c_scoreboard", "Received from DUT, while Expect Queue is empty");
            $display("the unexpected pkt is %h", get_actual);
            //get_actual.print();
         end 
      end
   join
endtask
`endif
