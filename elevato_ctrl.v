`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:51:56 03/01/2019 
// Design Name: 
// Module Name:    elevato_ctrl 
// Project Name: 
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
///-------------------Port Declarations-----------------------------------------//
module elevator_ctrl #(parameter ctrl_PFLOOR_WIDTH = 4 )(
	 input i_clock ,
	 input i_rd_en ,
    input [ctrl_PFLOOR_WIDTH-1 : 0] i_ctrl_floor_no,
    input [ctrl_PFLOOR_WIDTH-1 : 0] i_ctrl_current_floor ,
    output reg	o_ctrl_fsm_move_up,
    output reg o_ctrl_fsm_move_down,
    output reg o_ctrl_fsm_equal
    );

///---------------------------------------------------------------------------///
reg [ctrl_PFLOOR_WIDTH-1 : 0] floor_num_save ;
always@(posedge i_clock) 
	begin
		if(i_rd_en == 1)
			floor_num_save <= i_ctrl_floor_no ;
		else 
			floor_num_save <= floor_num_save ;
	end
/////-----------------------controler Logic----------------------------------///
always@(*) 
	begin
			o_ctrl_fsm_move_up = 1'b0 ;                         //intializing outputs 
			o_ctrl_fsm_move_down = 1'b0 ; 
			o_ctrl_fsm_equal = 1'b0 ; // avoiding latches 
			if((floor_num_save > i_ctrl_current_floor)) 
				o_ctrl_fsm_move_up = 1'b1 ;
			else if ( (floor_num_save< i_ctrl_current_floor) ) 
				o_ctrl_fsm_move_down = 1'b1 ;
			else if ( (floor_num_save == i_ctrl_current_floor) ) 
				o_ctrl_fsm_equal = 1'b1 ;
         
					
	end 


endmodule
