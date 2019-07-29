`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:26:43 02/28/2019 
// Design Name: 
// Module Name:    elevator_fsm 
// Project Name:   Si_vision training project
// Description: 	 implmenting FSM of an elevator with FIFO memory 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: This File for implmenting FSM of an elevator in MOORE STATE MACHINE 
//
//////////////////////////////////////////////////////////////////////////////////
////------------------------port decleration----------------------------------////
module elevator_fsm(
	 input      i_fsm_clock ,
	 input 		i_fsm_reset ,
    input 		i_ctrl_fsm_move_up,
    input 		i_ctrl_fsm_move_down,
    input 		i_ctrl_fsm_equal,
    input 		i_fsm_error_flag,
    input 		i_fsm_error_clear,
	 input 		i_counter_fsm_done ,
	 input 		i_fifo_fsm_empty ,
	 output reg o_fsm_move_up ,
	 output reg o_fsm_move_down,
    output reg o_fsm_fifo_rd_en,
    output reg o_fsm_alarm,
    output reg o_fsm_open_door
    );
////--------------------------end of port decleration------------------------////
/*******************************************************************************/
///-------------------------- state decelration-----------------------------////
parameter [2:0]
	idle      = 3'b000 , 
	move_up   = 3'b001 ,
	move_down = 3'b010 ,
	open_door = 3'b011 ,
	error     = 3'b100 ;
reg [2:0] current_state , next_state ;
reg [2:0] last_state ; // was used to return to the same state after entering in error state 
///------------------------------------------------------------------------////
////---------------------Sequential Logic----------------------------------////
always@(posedge i_fsm_clock or negedge i_fsm_reset ) 
	begin
			if(!i_fsm_reset)
               begin			// negative edge reset 
						current_state <= idle ;
						last_state <= idle ;
					end
			else
				begin
					current_state <= next_state;
					if(i_fsm_error_flag && (!(current_state==error)))
					last_state <= current_state ;
				end 
	end 

always@(  i_ctrl_fsm_move_up or i_ctrl_fsm_move_down 
			 or i_ctrl_fsm_equal or i_fsm_error_flag or i_counter_fsm_done or i_fifo_fsm_empty 
		    or i_fsm_error_clear or current_state  ) // always here function in inputs and current_state
	begin // always begin
		o_fsm_fifo_rd_en = 0 ; o_fsm_alarm = 0 ; o_fsm_open_door = 0 ; o_fsm_move_up = 0 ;
		o_fsm_move_down = 0 ; // initial values avoiding latches 
		case ( current_state )
			idle : begin
							o_fsm_fifo_rd_en = 0 ;
							o_fsm_alarm = 0 ;
							o_fsm_open_door = 0 ;
							o_fsm_move_up = 0 ;
							o_fsm_move_down = 0 ;
							if( i_fsm_error_flag )      // first check if there is any error then check on states
							begin
//								last_state = idle ;
								next_state = error ;
							end
							else if(i_ctrl_fsm_move_up) 
									begin
									o_fsm_fifo_rd_en = 0 ;
									next_state = move_up ;
									end
							else if(i_ctrl_fsm_move_down)
									begin
									o_fsm_fifo_rd_en = 0 ;
									next_state = move_down ;
									end
							else if(i_ctrl_fsm_equal)
										next_state = idle ;
								else
										next_state = idle ;
							if(i_ctrl_fsm_move_up == 1)
									o_fsm_fifo_rd_en = 0 ;
							else if (i_ctrl_fsm_move_down == 1 )
									o_fsm_fifo_rd_en = 0 ;
							else if (i_fifo_fsm_empty == 0 ) 
									o_fsm_fifo_rd_en = 1 ;								
					 end	
			move_up : begin
								o_fsm_fifo_rd_en = 0 ; // this state to while 
								o_fsm_alarm = 0 ;
								o_fsm_open_door = 0 ;
								o_fsm_move_up = 1 ;
								o_fsm_move_down = 0 ;
								if (i_fsm_error_flag)
								begin
//									last_state = move_up ;
									next_state = error ;
								end
								else if ( i_ctrl_fsm_equal )
									next_state = open_door ;
								else 
								   next_state = move_up ;
						 end
			move_down : begin
								  o_fsm_fifo_rd_en = 0 ;
								  o_fsm_alarm = 0 ;
								  o_fsm_open_door = 0 ;
								  o_fsm_move_up = 0 ;
								  o_fsm_move_down = 1 ;
								  if (i_fsm_error_flag)
								  begin
//										last_state = move_down ;
										next_state = error ;
								  end 								
								  else if ( i_ctrl_fsm_equal )
										next_state = open_door ;
								  else 
										next_state = move_down ;
							end
			open_door : begin 
									o_fsm_fifo_rd_en = 0;
									o_fsm_alarm = 0 ;
									o_fsm_open_door = 1 ;
									o_fsm_move_up = 0 ;
									o_fsm_move_down = 0 ;
									if (i_fsm_error_flag)
									begin
//										last_state = open_door ;
										next_state = error ;
									end	
								  else if ( i_counter_fsm_done ) 
										next_state = idle ;
									else
										next_state = open_door ;
							end
			error     : begin
									o_fsm_fifo_rd_en = 0 ;
									o_fsm_alarm = 1 ;
									o_fsm_open_door= 0;
									if (i_fsm_error_clear && (last_state == idle ) )
										next_state = idle ;
									else if (i_fsm_error_clear && (last_state == move_up ) )
										next_state = move_up ;
									else if (i_fsm_error_clear && (last_state == move_down )) 
										next_state = move_down ;
									else if (i_fsm_error_clear && (last_state == open_door )) 
										next_state = open_door ; 
									else
										next_state = error;
							end
          default   : next_state = idle ; 
		 
		endcase
  end
 // ALWAYS END  
endmodule
