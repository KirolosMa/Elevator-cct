`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: si-vision
// Engineer: Kirolos Magdy
// 
// Create Date:    17:50:41 03/03/2019 
// Design Name: 
// Module Name:    elevator 
// Project Name: 	 Elevator Project " Assignment 3 " 
// Target Devices: 
// Tool versions: 
// Description: this file contains the top modul assemble of the elevator blocks
// it contains the main parameters which can be editedd to have a full generic Design
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
///---------------------------DECLERATIONS------------------------------------////
module elevator #(parameter pFLOOR_WIDTH = 4 ,
									 pFIFO_DEPTH = 16 ,
									 fifo_pPOINTER_WIDTH = 4 , 
									 fifo_pMAX_COUNT = 4'b1111 ,
									 pCOUNT_BITS = 5           )
	(
    input 							 i_clock,
    input 							 i_reset_n,
    input 							 i_wr_en,
    input [pFLOOR_WIDTH-1 : 0] i_floor_no,
    input							 i_error_flag,
    input							 i_error_clear,
    input [pFLOOR_WIDTH-1 : 0] i_current_floor,
    output							 o_move_up,
    output							 o_move_down,
    output 							 o_open_door,
    output							 o_alarm,
    output							 o_fifo_full
    );
/////-----------------------------------------------------------------------////
////----------------------connection wires----------------------------------////
wire [2:0] ctrl_fsm ;
wire counter_fsm ;
wire i_rd_en ;
wire [pFLOOR_WIDTH-1 : 0] fifo_ctrl ;
wire fifo_fsm ;
////------------------------------------------------------------------------////
///-----------------------elevator controler--------------------------------////
elevator_ctrl  #(.ctrl_PFLOOR_WIDTH(pFLOOR_WIDTH)  ) u1
	(
	 .i_clock(i_clock),
	 .i_rd_en(i_rd_en),
    .i_ctrl_floor_no(fifo_ctrl)           ,
    .i_ctrl_current_floor(i_current_floor) ,
    .o_ctrl_fsm_move_up(ctrl_fsm[0]),
    .o_ctrl_fsm_move_down(ctrl_fsm[1]),
	 .o_ctrl_fsm_equal(ctrl_fsm[2])
    );
///-------------------------------------------------------------------------///
///------------------------elevator fsm-------------------------------------///
elevator_fsm u2(
	 .i_fsm_clock(i_clock) ,
	 .i_fsm_reset(i_reset_n) ,
    .i_ctrl_fsm_move_up(ctrl_fsm[0]),
    .i_ctrl_fsm_move_down(ctrl_fsm[1]),
    .i_ctrl_fsm_equal(ctrl_fsm[2]),
    .i_fsm_error_flag(i_error_flag),
    .i_fsm_error_clear(i_error_clear),
	 .i_fifo_fsm_empty(fifo_fsm),
	 .i_counter_fsm_done(counter_fsm) ,
	 .o_fsm_move_up(o_move_up),
	 .o_fsm_move_down(o_move_down) ,
    .o_fsm_fifo_rd_en(i_rd_en) ,
    .o_fsm_alarm(o_alarm),
    .o_fsm_open_door(o_open_door)
    );
//-------------------------------------------------------------------------///
//----------------------elevator fifo--------------------------------------///
fifo #(.fifo_pFLOOR_WIDTH(pFLOOR_WIDTH) , 
				  .fifo_pFIFO_DEPTH(pFIFO_DEPTH) ,
				  .fifo_pPOINTER_WIDTH(fifo_pPOINTER_WIDTH) , 
				  .fifo_pMAX_COUNT(fifo_pMAX_COUNT))// parameters used in module 
	u3(
    .i_rst_n(i_reset_n)  ,
    .i_clock(i_clock)   ,
    .i_wr_data(i_floor_no) ,
    .i_wr_en(i_wr_en)   ,
    .i_rd_en(i_rd_en)   ,
    .o_rd_data(fifo_ctrl) ,
    .o_fifo_full(o_fifo_full),
    .o_fifo_empty(fifo_fsm)
    );
//---------------------------------------------------------------------------//
///----------------------elvator timer--------------------------------------///
 timer # (.pCOUNT_BITS(pCOUNT_BITS)  )
	u4(  														// number of cycles that timer will count 
    .i_clock(i_clock),									// pCOUNT_BITS it refers to number of bits 
    .i_rst_n(i_reset_n),								// will statsify number of cycles log2(number of cycles== 32) 
	 .i_enable(o_open_door),
	 .o_done(counter_fsm)
    );
///------------------------------------------------------------------------////

endmodule
