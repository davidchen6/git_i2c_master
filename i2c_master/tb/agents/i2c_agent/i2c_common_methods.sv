`ifndef I2C_COMMON_METHODS__SV
`define I2C_COMMON_METHODS__SV

// Class: i2c_common_methods
// Holds all common tasks and functions used by multiple classes in the I2C package.
// Classes requiring these common methods holds an object of this class type. 
class i2c_common_methods extends uvm_object;
  
  virtual i2c_interface vif; // needed to use clocks and set timing limitations
    
  realtime input_clock_period_in_ps; //used to calculate all requests in clock deltas
	  
  `uvm_object_utils_begin(i2c_common_methods)
  `uvm_field_real(input_clock_period_in_ps, UVM_ALL_ON)
  `uvm_object_utils_end
			
			 
  extern function new(string name = "i2c_common_methods");
			     
  extern virtual task         calculate_input_clock_period();
  extern virtual function int calculate_number_of_clocks_for_time( realtime time_value, bit floor_calculation = 1 );
  extern virtual task         drive_x_to_outputs_during_reset();
  extern virtual task         monitor_for_start_condition( ref event start_e );
  extern virtual task         monitor_for_stop_condition( ref event stop_e );
								     
endclass: i2c_common_methods

//------------------------------------------------------------------------//
function i2c_common_methods::new(string name = "i2c_common_methods");
  super.new(name);

endfunction: new

task i2c_common_methods::calculate_input_clock_period();
  realtime before_t = 0;
  realtime after_t = 0;

  @(posedge vif.clk);
  before_t = $realtime;
  @(posedge vif.clk);
  after_t = $realtime;

  input_clock_period_in_ps = (after_t - before_t) / 1ps;

endtask: calculate_input_clock_period

//------------------------------------------------------------------------//
// floor value rounds down the calculation. the floor is useful for calculating 
// a max number of cycles, for a min number of cycles, set this variable to zero 
// and 1 more clock cycle will be added to the calculation.
function int i2c_common_methods::calculate_number_of_clocks_for_time( realtime time_value, bit floor_calculation = 1 );
  int retval;
  if (input_clock_period_in_ps == 0) begin
    `uvm_error(get_type_name(), $sformatf("variable input_clock_period_in_ps = %t", input_clock_period_in_ps) )
  end

  time_value = time_value / 1ps; // normalize to 1ps resolution
  retval = (time_value / input_clock_period_in_ps);
  
  `uvm_info(get_type_name(), $sformatf("requested time = %t, time calculated in clocks = %t", time_value, retval * input_clock_period_in_ps * 1ps), UVM_FULL )
  
  return retval;

endfunction: calculate_number_of_clocks_for_time

//------------------------------------------------------------------------//
// during reset, drive X to outputs to verify there isn't X propagation
// while reset is asserted. 
// This isn't being sent through a clocking block since the
// reset is asynchronous and there is no guarantee the clock is toggling
task i2c_common_methods::drive_x_to_outputs_during_reset();

  wait(vif.rst === 1'b1);
  vif.scl <= 'x;
  vif.sda <= 'x;

  wait(vif.rst === 1'b0);
  vif.scl <= 1'b1;
  vif.sda <= 1'b1;

endtask:drive_x_to_outputs_during_reset

//------------------------------------------------------------------------//
task i2c_common_methods::monitor_for_start_condition( ref event start_e );

  wait(vif.sda !== 1'bx);// don't trigger from an X to 0 transition
  @(negedge vif.sda);
  if(vif.scl === 1'b1) begin
    ->start_e;
  end
endtask: monitor_for_start_condition

//------------------------------------------------------------------------//
task i2c_common_methods::monitor_for_stop_condition( ref event stop_e );

  wait(vif.sda !== 1'bx);// don't trigger from an X to 0 transition
  @(posedge vif.sda);
  if(vif.scl === 1'b1) begin
    ->stop_e;
  end
endtask: monitor_for_stop_condition

`endif
