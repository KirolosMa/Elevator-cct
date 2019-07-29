`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:31:10 03/03/2019
// Design Name:   elevator_fsm
// Module Name:   D:/Lift_project/test_elevator_fsm.v
// Project Name:  Lift_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: elevator_fsm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_elevator_fsm;

	// Inputs
	reg i_fsm_clock;
	reg i_fsm_reset;
	reg i_ctrl_fsm_move_ip;
	reg i_ctrl_fsm_move_down;
	reg i_ctrl_fsm_equal;
	reg i_fsm_error_flag;
	reg i_fsm_error_clear;
	reg i_counter_fsm_done;

	// Outputs
	wire o_fsm_move_up;
	wire o_fsm_move_down;
	wire o_fsm_fifo_rd_en;
	wire o_fsm_alarm;
	wire o_fsm_open_door;

	// Instantiate the Unit Under Test (UUT)
	elevator_fsm uut (
		.i_fsm_clock(i_fsm_clock), 
		.i_fsm_reset(i_fsm_reset), 
		.i_ctrl_fsm_move_up(i_ctrl_fsm_move_up), 
		.i_ctrl_fsm_move_down(i_ctrl_fsm_move_down), 
		.i_ctrl_fsm_equal(i_ctrl_fsm_equal), 
		.i_fsm_error_flag(i_fsm_error_flag), 
		.i_fsm_error_clear(i_fsm_error_clear), 
		.i_counter_fsm_done(i_counter_fsm_done), 
		.o_fsm_move_up(o_fsm_move_up), 
		.o_fsm_move_down(o_fsm_move_down), 
		.o_fsm_fifo_rd_en(o_fsm_fifo_rd_en), 
		.o_fsm_alarm(o_fsm_alarm), 
		.o_fsm_open_door(o_fsm_open_door)
	);
	

	initial begin
		// Initialize Inputs
		i_fsm_clock = 0;
		i_fsm_reset = 1;
		i_ctrl_fsm_move_up = 0;
		i_ctrl_fsm_move_down = 0;
		i_ctrl_fsm_equal = 0;
		i_fsm_error_flag = 0;
		i_fsm_error_clear = 0;
		i_counter_fsm_done = 0;

		//procedure to test the fsm 
		@(posedge i_fsm_clock)
			i_fsm_reset = 0 ;
		@(posedge i_fsm_clock) 
			i_fsm_reset = 1 ;
		@(posedge i_ctrl_fsm_clock)
		   i_ctrl_fsm_move_up = 1;
		@(posedge i_ctrl_fsm_clock)// wait 4 cycles for random
		@(posedge i_ctrl_fsm_clock)
		@(posedge i_ctrl_fsm_clock)
		@(posedge i_ctrl_fsm_clock)
		@(posedge i_ctrl_fsm_clock)
			i_fsm_error_flag = 1 ;
		@(posedge i_ctrl_fsm_clock)
		@(posedge i_ctrl_fsm_clock)
		@(posedge i_ctrl_fsm_clock)
			i_fsm_error_flag = 0 ;
			i_fsm_error_clear = 1 ;
		@(posedge i_ctrl_fsm_clock)
		@(posedge i_ctrl_fsm_clock)
		@(posedge i_ctrl_fsm_clock)
			i_fsm_error_clear = 0 ;
		@(posedge i_ctrl_fsm_clock)
			i_ctrl_fsm_equal = 1 ;
		@(posedge i_ctrl_fsm_clock)
		@(posedge i_ctrl_fsm_clock)
		@(posedge i_ctrl_fsm_clock)
			i_ctrl_fsm_equal = 0 ;
			i_counter_fsm_done = 1 ; 
		
			
			
        
		// Add stimulus here

	end
	always #50 i_ctrl_fsm_clock = ~ i_ctrl_fsm_clock ;
	
      
endmodule

