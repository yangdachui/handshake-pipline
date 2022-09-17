`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yang Zhenhao
// 
// Create Date: 2022/09/15 17:01
// Design Name: 
// Module Name: destination_tb
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
module destination(
    input  wire          clk              ,
    input  wire          rst              ,
    input  wire          d_s_valid        ,
    output reg           d_s_ready  = 0   ,
    input  wire [DW-1:0] d_s_data             
); 

parameter           DW   = 8 ;
reg        [DW-1:0] data = 0 ;


initial
begin
    #75
    d_s_ready = 1 ;
    #50
    d_s_ready = 0 ;
    #50
    d_s_ready = 1 ;
end

always@(posedge clk)
begin
    if(rst == 1)
    begin
        data <= 0            ;
    end
    else if(d_s_valid && d_s_ready)
    begin
        data <= d_s_data + 1 ;
    end

end

endmodule