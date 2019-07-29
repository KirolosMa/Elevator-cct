`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  si-vision  
// Engineer: Kirolos magdy
// 
// Create Date:    20:57:46 03/02/2019 
// Design Name: 
// Module Name:    fifo 
// Project Name:  Elevator 
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
////-----------------port Decelartions-----------------------------------------///
module fifo #(parameter fifo_pFLOOR_WIDTH = 4 , fifo_pFIFO_DEPTH = 16 ,
								fifo_pPOINTER_WIDTH = 4 , fifo_pMAX_COUNT = 4'b1111 )// parameters used in module 
	(
    input 									     i_rst_n   ,
    input 									     i_clock   ,
    input      [fifo_pFLOOR_WIDTH-1 : 0] i_wr_data ,
    input 										  i_wr_en   ,
    input 										  i_rd_en   ,
    output wire [fifo_pFLOOR_WIDTH-1 : 0] o_rd_data ,
    output reg 								  o_fifo_full,
    output reg 								  o_fifo_empty
    );
///---------------------------------------------------------------------------///
///--------------------------declarations------------------------------------///
reg [fifo_pPOINTER_WIDTH - 1 : 0 ] rd_pointer ; 
reg [fifo_pPOINTER_WIDTH - 1 : 0 ] wr_pointer ;
reg [fifo_pPOINTER_WIDTH - 1 : 0 ] count ; 
reg read_write_empty_flag ;
reg increment ;
///-------------------------------------------------------------------------///
///--------------------flag operation---------------------------------------//
always@(posedge i_clock or negedge i_rst_n ) 
	begin 
			if (!i_rst_n)
				read_write_empty_flag <= 0 ;
			else if ( i_rd_en == 1 && o_fifo_empty == 1 && i_wr_en == 1 )
				read_write_empty_flag <= 1 ;
			else 
				read_write_empty_flag <= 0 ;
	end
///----------------------Memory Ram instantiation----------------------------------///
Double_port_RAM u1 (	.o_rd_data(o_rd_data),
							.i_wr_data(i_wr_data),
							.i_rd_en(i_rd_en),
							.i_clock(i_clock),
                     .i_wr_en(i_wr_en),
							.wr_pointer(wr_pointer),
							.rd_pointer(rd_pointer) 
							); 
///-------------------------------------------------------------------------------////
//-----------------------------read_operation-----------------------------------////
//always@(posedge i_clock or negedge i_rst_n) 
//	begin
//			if(!i_rst_n)
//				o_rd_data <= 0 ; 
//			else if(i_rd_en == 1 && o_fifo_empty == 0)  
//				o_rd_data <= o_rd_data2 ;
//	end

////-----------------write pointers operation-----------------------////
always@(posedge i_clock or negedge i_rst_n) 
	begin
			if ( !i_rst_n )
				wr_pointer <= 0 ;
			else if ( (i_wr_en == 1 ) && ( o_fifo_full == 0) ) 
				wr_pointer <= wr_pointer + 1 ;
	end 
///-----------------------------------------------------------------////
///-----------------Read pointer operation--------------------------//// 
always@(posedge i_clock or negedge i_rst_n ) 
	begin
			if ( !i_rst_n)
				rd_pointer <= 0 ;
			else if ( (i_rd_en == 1 ) && (o_fifo_empty == 0) ) 
				rd_pointer <= rd_pointer + 1 ;
	end
///-----------------------------------------------------------------///
///------------------counting space between pointers---------------/// 
always@(posedge i_clock or negedge i_rst_n)
	begin
			if ( !i_rst_n ) 
				count <= 0 ;
			else 
			begin
				case({i_rd_en,i_wr_en}) 
					2'b00 : count <= count  ; 
					2'b01 :	
								if (count != fifo_pMAX_COUNT) 
										count <= count + 1 ; 
					2'b10 : 
							begin 
								if ( count != 0 ) 
										count <= count - 1 ;
							end
					2'b11 : 
							begin
								if ( read_write_empty_flag == 1 ) 
										count <= count + 1 ; 
								else 	
										count <= count ;
							end
			
					default : count <= count ;
			endcase
		end //end else of if
 end // end always block 			
///----------------------------------------------------------------////
///----------setting fifo outputs---------------------------------////
always@(*)
begin 
		if(count == 0 ) 
			o_fifo_empty = 1 ;
		else
		   o_fifo_empty = 0;
end
always@(*)
	begin
		if(count == fifo_pMAX_COUNT )
			o_fifo_full = 1 ;	
		else 
			o_fifo_full = 0 ;
	end
endmodule 
