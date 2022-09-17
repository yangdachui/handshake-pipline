`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yang Zhenhao
// 
// Create Date: 2022/09/15 14:58
// Design Name: 
// Module Name: handshake_pip
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// Wechat: Yangshen_0001
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module handshake_pip#(
    parameter                 DW = 8
)
(
    input  wire               clk      ,
    input  wire               rst      ,
    input  wire               s_valid  ,
    output wire               s_ready  , 
    input  wire [DW-1 :0]     s_data   ,
    output reg                m_valid  ,
    input  wire               m_ready  ,    
    output reg  [DW-1 :0]     m_data   
);

assign s_ready = ~m_valid || m_ready  ;

always@(posedge clk)
begin
    if(rst == 1)
    begin
        m_valid <= 0       ;
    end
    else if(s_ready == 1)
    begin
        m_valid <= s_valid ;
    end
end

always@(posedge clk)
begin
    if(rst == 1)
    begin
        m_data <= 0          ;
    end
    else if(s_valid == 1 && s_ready == 1)
    begin
        m_data <= s_data + 1 ;
    end
end

endmodule






