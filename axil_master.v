// For Demonstration purposes only
// Code has not been fully verified or tested 
// User assumes risk
`timescale 1ns / 1ps
module axil_master
(
    input  wire        m_axi_aclk,
    input  wire        m_axi_aresetn,

    output reg         m_axi_awvalid,
    input wire         m_axi_awready,
    output reg [23: 0] m_axi_awaddr,
    output reg [1: 0]  m_axi_awprot,

    output reg         m_axi_wvalid,
    input wire         m_axi_wready,
    output reg [31: 0] m_axi_wdata,
    output reg [3: 0]  m_axi_wstrb,

    input wire         m_axi_bvalid,
    output reg         m_axi_bready,
    input wire  [1: 0] m_axi_bresp,

    output reg         m_axi_arvalid,
    input wire         m_axi_arready,
    output reg [23: 0] m_axi_araddr,
    output reg [1: 0]  m_axi_arprot,

    input wire         m_axi_rvalid,
    output reg         m_axi_rready,
    input wire [31: 0] m_axi_rdata,
    input wire  [1: 0] m_axi_rresp,
 
    input wire         write,
    input wire [23: 0] write_address,
    input wire [31: 0] write_data ,
    input wire         read,
    input wire [23: 0] read_address,
    output reg [31: 0] read_data
);

reg [3:0] timer;
localparam TIMEOUT = 4'd15;

localparam INIT = 0,STANDBY = 1,WADDR_VALID = 2,WADDR_ACCEPT = 3,WADDR_ERROR = 4,
           WDATA_ACCEPT = 5,WDATA_ERROR = 6,WAIT_RESPONSE = 7,ACCEPT_RESPONSE = 8,
           RESPONSE_ERROR = 9,RADDR_VALID = 10,RADDR_ACCEPT = 11,RDATA_VALID = 12,
           RDATA_ERROR = 13;
reg [3:0] state,next_state;

reg m_axis_aresetn_reg;

always @(*) begin
  next_state = state;
  case (state)
    INIT: begin
      next_state = STANDBY;
    end
    STANDBY: begin
      if (write == 1)
        next_state = WADDR_VALID;
      else if (read == 1)
        next_state = RADDR_VALID;
    end
    WADDR_VALID: begin
      if ((m_axi_awready == 1) && (m_axi_wready == 1))
        next_state = WDATA_ACCEPT;
      else if (m_axi_awready == 1)
        next_state = WADDR_ACCEPT;
      else if (timer == TIMEOUT)
        next_state = WADDR_ERROR;
   end
    WADDR_ACCEPT: begin
      if (m_axi_wready == 1)
        next_state = WDATA_ACCEPT;
      else if (timer == TIMEOUT)
        next_state = WDATA_ERROR;
    end
    WADDR_ERROR: begin
      next_state = WAIT_RESPONSE;
    end
    WDATA_ACCEPT: begin
      if (m_axi_bvalid == 1)
        next_state = ACCEPT_RESPONSE;
      else
        next_state = WAIT_RESPONSE;
    end
    WAIT_RESPONSE: begin
      if (m_axi_bvalid == 1)
        next_state = ACCEPT_RESPONSE;
      else if (timer == TIMEOUT)
        next_state = RESPONSE_ERROR;
    end
    ACCEPT_RESPONSE: begin
      next_state = INIT;
    end
    RESPONSE_ERROR: begin
      next_state = INIT;
    end
    RADDR_VALID: begin
      if (m_axi_arready == 1)
        next_state = RADDR_ACCEPT;
      else if (timer == TIMEOUT)
        next_state = RESPONSE_ERROR;
    end
    RADDR_ACCEPT: begin
      if (m_axi_rvalid == 1)
        next_state = INIT;
      else
        next_state = RDATA_VALID;
    end
    RDATA_VALID: begin
      if (m_axi_rvalid == 1)
        next_state = INIT;
       else if (timer == TIMEOUT)
        next_state = RDATA_ERROR;
    end
    RDATA_ERROR: begin
      next_state = INIT;
    end
    default: begin
      next_state = INIT;
    end
    endcase
end

always @(posedge m_axi_aclk)
begin
  m_axis_aresetn_reg <= m_axi_aresetn;
  if (m_axi_aresetn == 0)
    state <= INIT;
  else
    state <= next_state;
end

always @(posedge m_axi_aclk)
begin
  case (next_state)
    INIT: begin
      m_axi_awvalid <= 0;
      m_axi_awaddr  <= 0;
      m_axi_awprot  <= 0;
      m_axi_wvalid  <= 0;
      m_axi_wdata   <= 0;
      m_axi_wstrb   <= 4'b1111;
      m_axi_bready  <= 0;
      m_axi_arvalid <= 0;
      m_axi_araddr  <= 0;
      m_axi_arprot  <= 0;
      m_axi_rready  <= 0;
    end
    STANDBY: begin
    end
    WADDR_VALID: begin
      m_axi_wstrb   <=4'b1111;
      m_axi_awvalid <=1;
      m_axi_wvalid  <=1;
      m_axi_awaddr  <= write_address;
      m_axi_wdata   <= write_data;
    end
    WADDR_ACCEPT: begin
      m_axi_awvalid <= 0;
    end
    WADDR_ERROR: begin
    end
    WDATA_ACCEPT: begin
      m_axi_awvalid <= 0;
      m_axi_wvalid  <= 0;
      m_axi_wdata   <= 0;
      m_axi_bready  <= 1;
    end
    WDATA_ERROR: begin
    end
    WAIT_RESPONSE: begin
      m_axi_bready  <= 1;
    end
    ACCEPT_RESPONSE: begin
      m_axi_bready  <= 0;
    end
    RESPONSE_ERROR: begin
    end
    RADDR_VALID: begin
      m_axi_araddr  <= read_address;
      m_axi_arvalid <= 1;
      m_axi_rready  <= 1;
   end
    RADDR_ACCEPT: begin
      m_axi_arvalid <= 0;
    end
    RDATA_VALID: begin
      m_axi_rready  <= 1;
    end
    RDATA_ERROR: begin
    end
    default : begin
    end    
    endcase
end


endmodule
