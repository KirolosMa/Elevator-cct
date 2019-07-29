`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:51:15 03/02/2019
// Design Name:   elevator_ctrl
// Module Name:   D:/Lift_project/ctrl_test.v
// Project Name:  Lift_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: elevator_ctrl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ctrl_test;

	// Inputs
	reg [3:0] i_ctrl_floor_no;
	reg [3:0] i_ctrl_current_floor;

	// Outputs
	wire o_ctrl_fsm_move_up;
	wire o_ctrl_fsm_move_down;
	wire o_ctrl_fsm_equal;

	// Instantiate the Unit Under Test (UUT)
	elevator_ctrl uut (
		.i_ctrl_floor_no(i_ctrl_floor_no), 
		.i_ctrl_current_floor(i_ctrl_current_floor), 
		.o_ctrl_fsm_move_up(o_ctrl_fsm_move_up), 
		.o_ctrl_fsm_move_down(o_ctrl_fsm_move_down), 
		.o_ctrl_fsm_equal(o_ctrl_fsm_equal)
	);

	initial begin
		// Initialize Inputs
		i_ctrl_floor_no = 0;
		i_ctrl_current_floor = 0;

		// Wait 100 ns for global reset to finish
		#100;
		i_ctrl_floor_no = 4'b0001;
		i_ctrl_current_floor = 4'b0100;
		#100
      i_ctrl_floor_no = 4'b0001;
		i_ctrl_current_floor = 4'b0001;		
		
		
        
		// Add stimulus here

	end
      
endmodule

