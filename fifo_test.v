`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:29:20 03/03/2019
// Design Name:   fifo
// Module Name:   D:/Lift_project/fifo_test.v
// Project Name:  Lift_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fifo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fifo_test;

	// Inputs
	reg i_rst_n;
	reg i_clock;
	reg [3:0] i_wr_data;
	reg i_wr_en;
	reg i_rd_en;

	// Outputs
	wire [3:0] o_rd_data;
	wire o_fifo_full;
	wire o_fifo_empty;

	// Instantiate the Unit Under Test (UUT)
	fifo uut (
		.i_rst_n(i_rst_n), 
		.i_clock(i_clock), 
		.i_wr_data(i_wr_data), 
		.i_wr_en(i_wr_en), 
		.i_rd_en(i_rd_en), 
		.o_rd_data(o_rd_data), 
		.o_fifo_full(o_fifo_full), 
		.o_fifo_empty(o_fifo_empty)
	);

	initial begin
		// Initialize Inputs
		i_rst_n = 1;
		i_clock = 0;
		i_wr_data = 0;
		i_wr_en = 0;
		i_rd_en = 0;
		//------------scenario--------------------//
		@(posedge i_clock)
			i_rst_n = 0 ;
		@(posedge i_clock)
			i_rst_n = 1 ;
		@(posedge i_clock)
			begin
				i_wr_en = 1;
				i_wr_data = 0 ;
			end
			
		repeat(14)
			begin
				@(posedge i_clock)
					i_wr_data = i_wr_data + 1 ; 
			end
		@(posedge i_clock)
			i_wr_data = i_wr_data +1; 
		@(posedge i_clock)
			i_wr_en = 0 ;
		repeat(16)
			begin
				@(posedge i_clock)
					i_rd_en = 1 ;
				@(posedge i_clock)
					i_rd_en = 0 ;
			end

	end
	always #50 i_clock = ~ i_clock ;
      
endmodule

