`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:07:13 03/03/2019
// Design Name:   elevator_fsm
// Module Name:   D:/Lift_project/test_fsm_elevator.v
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

module test_fsm_elevator;

	// Inputs
	reg i_fsm_clock;
	reg i_fsm_reset;
	reg i_ctrl_fsm_move_up;
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
		//-----------scenario to be tested--------//
		@(posedge i_fsm_clock)
			i_fsm_reset = 0 ;							// scenario is moving up instruction then recieving 
		@(posedge i_fsm_clock)						// error flag then continue opening door 
			i_fsm_reset = 1 ;							// then finish counting 
		@(posedge i_fsm_clock)
			i_ctrl_fsm_move_up = 1 ;
		repeat(5) 
			@(posedge i_fsm_clock)
		@(posedge i_fsm_clock)
			i_fsm_error_flag = 1 ;
		repeat(3)
			@(posedge i_fsm_clock)
		@(posedge i_fsm_clock)
			begin
				i_fsm_error_clear = 1 ;
				i_fsm_error_flag = 0 ;
			end
		repeat(2)
			@(posedge i_fsm_clock)
		@(posedge i_fsm_clock)
			i_ctrl_fsm_move_up = 0 ;
			i_ctrl_fsm_equal = 1 ;
		repeat(3)
			@(posedge i_fsm_clock)
		@(posedge i_fsm_clock)
			i_counter_fsm_done = 1; 
		@(posedge i_fsm_clock)
			i_counter_fsm_done = 0; 
	end
	always #50 i_fsm_clock  =~ i_fsm_clock ;
	//--------------------------------------------//
      
endmodule

