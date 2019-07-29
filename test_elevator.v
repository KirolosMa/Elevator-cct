`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:08:45 03/03/2019
// Design Name:   elevator
// Module Name:   D:/Lift_project/test_elevator.v
// Project Name:  Lift_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: elevator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_elevator;

	// Inputs
	reg i_clock;
	reg i_reset_n;
	reg i_wr_en;
	reg [3:0] i_floor_no;
	reg i_error_flag;
	reg i_error_clear;
	reg [3:0] i_current_floor;

	// Outputs
	wire o_move_up;
	wire o_move_down;
	wire o_open_door;
	wire o_alarm;
	wire o_fifo_full;
	// Instantiate the Unit Under Test (UUT)
	elevator uut (
		.i_clock(i_clock), 
		.i_reset_n(i_reset_n), 
		.i_wr_en(i_wr_en), 
		.i_floor_no(i_floor_no), 
		.i_error_flag(i_error_flag), 
		.i_error_clear(i_error_clear), 
		.i_current_floor(i_current_floor), 
		.o_move_up(o_move_up), 
		.o_move_down(o_move_down), 
		.o_open_door(o_open_door), 
		.o_alarm(o_alarm), 
		.o_fifo_full(o_fifo_full)
	);

	initial begin
		// Initialize Inputs
		i_clock = 0;
		i_reset_n = 1;
		i_wr_en = 0;
		i_floor_no = 0;
		i_error_flag = 0;
		i_error_clear = 0;
		i_current_floor = 0;
//------------------- case---------------/// 
		@(posedge i_clock)
			i_reset_n = 0 ;
		@(posedge i_clock)
			i_reset_n = 1 ;
		@(posedge i_clock) 
				 begin
						i_wr_en = 1 ;
						i_floor_no =4'b00111;
					end
		@(posedge i_clock) 
					i_wr_en = 0 ; 

		repeat(15)
			begin
				@(posedge i_clock)
					begin
						i_wr_en = 1 ;
						i_floor_no = i_floor_no + 1 ;
					end
				@(posedge i_clock) 
					i_wr_en = 0 ; 
			end
		
		@(posedge i_clock) 
				i_current_floor = 4'b0011 ;
		repeat(4)
		@(posedge i_clock) 
		@(posedge i_clock) 
				i_current_floor = 4'b0111 ;
		
   end
	always #50 i_clock=~i_clock ;
		
endmodule

