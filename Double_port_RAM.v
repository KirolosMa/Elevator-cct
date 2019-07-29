`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:26:41 03/03/2019 
// Design Name: 
// Module Name:    Double_port_RAM 
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
///-----------------------------Double Port RAM implmentation--------------------------------------////
module Double_port_RAM #(parameter fifo_pFLOOR_WIDTH = 4 ,
							fifo_pFIFO_DEPTH = 16 ,fifo_pPOINTER_WIDTH = 4)
					( 	output wire [fifo_pFLOOR_WIDTH-1:0] o_rd_data, 
						input [fifo_pFLOOR_WIDTH-1 :0] i_wr_data,
						input i_rd_en, 
						input i_clock,
						input i_wr_en, 
						input [fifo_pPOINTER_WIDTH-1:0] wr_pointer,
						input [fifo_pPOINTER_WIDTH-1:0] rd_pointer);  
  reg[fifo_pFLOOR_WIDTH-1:0] o_rd_data2[0:fifo_pFIFO_DEPTH-1];  
  always @(posedge i_clock)  
  begin  
   if(i_wr_en)   
      o_rd_data2[wr_pointer[fifo_pPOINTER_WIDTH-1:0]] <=i_wr_data ;  
  end 
  assign o_rd_data =  o_rd_data2[rd_pointer[fifo_pPOINTER_WIDTH-1:0]] ;  
 endmodule  
 //////////-----------------------------------------------------------------------------------------///
