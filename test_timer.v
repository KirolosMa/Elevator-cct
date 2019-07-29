`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:40:29 03/03/2019
// Design Name:   timer
// Module Name:   D:/Lift_project/test_timer.v
// Project Name:  Lift_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: timer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_timer;

	// Inputs
	reg i_clock;
	reg i_rst_n;
	reg i_enable;

	// Outputs
	wire o_done;

	// Instantiate the Unit Under Test (UUT)
	timer uut (
		.i_clock(i_clock), 
		.i_rst_n(i_rst_n), 
		.i_enable(i_enable), 
		.o_done(o_done)
	);

	initial begin
		// Initialize Inputs
		i_clock = 0;
		i_rst_n = 1;
		i_enable = 0;
		@(posedge i_clock)
			i_rst_n = 0 ;
		@(posedge i_clock) 
			begin
				i_rst_n = 1 ;
				i_enable = 1 ;
			end
		repeat(10)
			@(posedge i_clock)
		@(posedge i_clock)
				i_enable = 0 ; // reset using enable
		@(posedge i_clock)
				i_enable = 1 ;
		repeat(31) 
				@(posedge i_clock);
		

	end
			always #50 i_clock = ~ i_clock ;
endmodule

