// For Demonstration purposes only
// Code has not been fully verified or tested 
// User assumes risk
`timescale 1ns / 1ps

module t_axil_master;

reg           s_axi_aclk;
reg           s_axi_aresetn;
wire          s_axi_awvalid;
wire          s_axi_awready;
wire  [23: 0] s_axi_awaddr;
wire  [1: 0]  s_axi_awprot;
wire          s_axi_wvalid;
wire          s_axi_wready;
wire  [31: 0] s_axi_wdata;
wire  [3: 0]  s_axi_wstrb;
wire          s_axi_bvalid;
wire          s_axi_bready;
wire [1: 0]   s_axi_bresp;
wire          s_axi_arvalid;
wire          s_axi_arready;
wire  [23: 0] s_axi_araddr;
wire  [1: 0]  s_axi_arprot;
wire          s_axi_rvalid;
wire          s_axi_rready;
wire [31: 0]  s_axi_rdata;
wire  [1: 0]  s_axi_rresp;
reg           write;
reg  [23: 0]  write_address;
reg  [31: 0]  write_data;
reg           read;
reg  [23: 0]  read_address;
wire [31: 0]  read_data;
initial
begin
  s_axi_aclk = 1'b0;
end

always
  #50 s_axi_aclk = ~s_axi_aclk;

axil_master uut (
 .m_axi_aclk(s_axi_aclk),
 .m_axi_aresetn(s_axi_aresetn),
 .m_axi_awvalid(s_axi_awvalid),
 .m_axi_awready(s_axi_awready),
 .m_axi_awaddr(s_axi_awaddr),
 .m_axi_awprot(s_axi_awprot),
 .m_axi_wvalid(s_axi_wvalid),
 .m_axi_wready(s_axi_wready),
 .m_axi_wdata(s_axi_wdata),
 .m_axi_wstrb(s_axi_wstrb),
 .m_axi_bvalid(s_axi_bvalid),
 .m_axi_bready(s_axi_bready),
 .m_axi_bresp(s_axi_bresp),
 .m_axi_arvalid(s_axi_arvalid),
 .m_axi_arready(s_axi_arready),
 .m_axi_araddr(s_axi_araddr),
 .m_axi_arprot(s_axi_arprot),
 .m_axi_rvalid(s_axi_rvalid),
 .m_axi_rready(s_axi_rready),
 .m_axi_rdata(s_axi_rdata),
 .m_axi_rresp(s_axi_rresp),
 .write(write),
 .write_address(write_address),
 .write_data(write_data),
 .read(read),
 .read_address(read_address),
 .read_data(read_data)
);

axil_slave slavertl (
 .s_axi_aclk(s_axi_aclk),
 .s_axi_aresetn(s_axi_aresetn),
 .s_axi_awvalid(s_axi_awvalid),
 .s_axi_awready(s_axi_awready),
 .s_axi_awaddr(s_axi_awaddr),
 .s_axi_awprot(s_axi_awprot),
 .s_axi_wvalid(s_axi_wvalid),
 .s_axi_wready(s_axi_wready),
 .s_axi_wdata(s_axi_wdata),
 .s_axi_wstrb(s_axi_wstrb),
 .s_axi_bvalid(s_axi_bvalid),
 .s_axi_bready(s_axi_bready),
 .s_axi_bresp(s_axi_bresp),
 .s_axi_arvalid(s_axi_arvalid),
 .s_axi_arready(s_axi_arready),
 .s_axi_araddr(s_axi_araddr),
 .s_axi_arprot(s_axi_arprot),
 .s_axi_rvalid(s_axi_rvalid),
 .s_axi_rready(s_axi_rready),
 .s_axi_rdata(s_axi_rdata),
 .s_axi_rresp(s_axi_rresp)
);


initial
begin
  s_axi_aresetn = 0;
  write	= 0;
  write_address	= 0;
  write_data	= 0;
  read_address	= 0;
  read 	= 0;
  @(posedge s_axi_aclk)
  s_axi_aresetn = 1;
  repeat(10) @(posedge s_axi_aclk);
  write	= 1;
  write_address	= 24'h4;
  write_data 	= 32'h55555555;
  @(posedge s_axi_aclk)
  write = 0;
  repeat(20) @(posedge s_axi_aclk);
  read	= 1;
  read_address	= 24'h000004;
  @(posedge s_axi_aclk);
  read = 0;
  repeat(20) @(posedge s_axi_aclk);
  write	= 1;
  write_address	= 24'h000100;
  write_data 	= 32'h12345678;
  @(posedge s_axi_aclk);
  write = 0;
  repeat(20) @(posedge s_axi_aclk);
  read	= 1;
  read_address	= 24'h00100;
  @(posedge s_axi_aclk);
  read = 0;
  repeat(20) @(posedge s_axi_aclk);
  $finish;
end

endmodule
