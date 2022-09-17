`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yang Zhenhao
// 
// Create Date: 2022/09/15 17:01
// Design Name: 
// Module Name: source_tb
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
module source_tb(
    input  wire         s_m_ready        ,
    output reg          clk        = 0   ,
    output reg          rst        = 0   ,
    output reg [DW-1:0] s_m_data   = 0   ,
    output reg          s_m_valid  = 0
); 

parameter     DW      = 8             ;
parameter     pip_num = 5             ;
integer       n       = 1             ;



wire          p_ready [pip_num-1:0]     ;
wire          p_valid [pip_num-1:0]     ;
wire [DW-1:0] p_data  [pip_num-1:0]     ;


always 
begin
    #5
    clk <= ~clk     ;
end

initial
begin
    #5
    rst     = 1     ;
    #10
    rst     = 0     ;
    #50
    s_m_valid = 1   ; 
    #200
    s_m_valid = 0   ;
    #100
    s_m_valid = 1   ;
    #100
    s_m_valid = 0   ;
end

always@(posedge clk)
begin
    if(rst == 1)
    begin
        s_m_data <= 0      ;
    end
    else if(s_m_valid == 1 && s_m_ready == 1)
    begin
        s_m_data <= 2*n ;
        n        <= n + 1  ;
    end
end




handshake_pip s_handshake_pip(
.clk     (clk)          ,
.rst     (rst)          ,
.s_valid (s_m_valid)    ,
.s_ready (s_m_ready)    ,
.s_data  (s_m_data)     ,
.m_valid (p_valid[0])   ,
.m_ready (p_ready[0])   ,
.m_data  (p_data [0]) 
);



genvar      a                       ;
generate
    for(a=0; a<pip_num-1; a=a+1) begin 
    handshake_pip a_handshake_pip(
    .clk     (clk)          ,
    .rst     (rst)          ,
    .s_valid (p_valid[a])   ,
    .s_ready (p_ready[a])   ,
    .s_data  (p_data [a])   ,
    .m_valid (p_valid[a+1]) ,
    .m_ready (p_ready[a+1]) ,
    .m_data  (p_data [a+1]) 
    );
    end
endgenerate

destination u_destination(
.clk        (clk)                ,
.rst        (rst)                ,
.d_s_valid  (p_valid[pip_num-1]) ,
.d_s_ready  (p_ready[pip_num-1]) ,
.d_s_data   (p_data [pip_num-1])
);

endmodule