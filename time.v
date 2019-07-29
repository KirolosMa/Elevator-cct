`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Si-Vision
// Engineer: Kirolos Magdy
// 
// Create Date:    14:42:08 03/03/2019 
// Design Name: 
// Module Name:    timer 
// Project Name: 	 Elevator project 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
/////-----------------------------Declerations ------------------------------------//
module timer # (parameter pCOUNT_BITS = 5 )(  // number of cycles that timer will count 
    input i_clock,									// pCOUNT_BITS it refers to number of bits 
    input i_rst_n,									// will statsify number of cycles log2(number of cycles== 32) 
    input i_enable,
    output o_done
    );
	 reg [pCOUNT_BITS - 1 : 0 ] count ;
///////------------------------------------------------------------------------------//
///////---------------------------counter implmentation------------------------------//	 
always @ (posedge i_clock or negedge i_rst_n ) 
	begin 
			if ( (!i_rst_n)  )
				count <= 0 ;
			else if (!i_enable) 
				count <= 0 ;
			else if( i_enable )
				count <= count + 1 ; 
	end 
assign o_done = &(count);  
////------------------------------------------------------------------------------///

endmodule
