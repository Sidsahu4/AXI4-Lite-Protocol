// For Demonstration purposes only
// Code has not been fully verified or tested 
// User assumes risk
`timescale 1ns / 1ps

module t_axil_slave;

reg          s_axi_aclk;
reg          s_axi_aresetn;
reg          s_axi_awvalid;
wire         s_axi_awready;
reg  [23: 0] s_axi_awaddr;
reg  [1: 0]  s_axi_awprot;
reg          s_axi_wvalid;
wire         s_axi_wready;
reg  [31: 0] s_axi_wdata;
reg  [3: 0]  s_axi_wstrb;
wire         s_axi_bvalid;
reg          s_axi_bready;
wire [1: 0]  s_axi_bresp;
reg          s_axi_arvalid;
wire         s_axi_arready;
reg  [23: 0] s_axi_araddr;
reg  [1: 0]  s_axi_arprot;
wire         s_axi_rvalid;
reg          s_axi_rready;
wire [31: 0] s_axi_rdata;
wire  [1: 0] s_axi_rresp;

initial
begin
  s_axi_aclk = 1'b0;
end

always
  #50 s_axi_aclk = ~s_axi_aclk;

axil_slave uut (
 .s_axi_aclk(s_axi_aclk),
 .s_axi_aresetn(s_axi_aresetn),
 .s_axi_awvalid(s_axi_awvalid),
 .s_axi_awready(s_axi_awready),
 .s_axi_awaddr(s_axi_awaddr),
 .s_axi_awprot(s_axi_awprot),
 .s_axi_wvalid(s_axi_wvalid),
 .s_axi_wready(s_axi_wready),
 .s_axi_wdata(s_axi_wdata),
 .s_axi_wstrobe(s_axi_wstrb),
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
  s_axi_awvalid	= 0;
  s_axi_awaddr	= 0;
  s_axi_awprot	= 0;
  s_axi_wvalid	= 0;
  s_axi_wdata 	= 0;
  s_axi_wstrb 	= 0;
  s_axi_bready	= 0;
  s_axi_arvalid	= 0;
  s_axi_araddr	= 0;
  s_axi_arprot	= 0;
  s_axi_rready	= 0;
  @(posedge s_axi_aclk)
  s_axi_aresetn = 1;
  repeat(10) @(posedge s_axi_aclk);
  s_axi_wstrb 	= 15;
  s_axi_awvalid	= 1;
  s_axi_awaddr	= 4;
  s_axi_awprot	= 0;
  s_axi_wdata 	= 32'h55555555;
  s_axi_wvalid	= 1;
  if (s_axi_awready) @(posedge s_axi_aclk); else @(posedge s_axi_awready);
  @(posedge s_axi_aclk)
  s_axi_awvalid	= 0;
  if (s_axi_wready) @(posedge s_axi_aclk); else @(posedge s_axi_wready);
  @(posedge s_axi_aclk)
  s_axi_wvalid	= 0;
  s_axi_awaddr	= 0;
  s_axi_awprot	= 0;
  s_axi_wdata 	= 0;
  s_axi_wvalid	= 0;
  s_axi_bready	= 1;
  if (s_axi_bvalid) @(posedge s_axi_aclk); else @(posedge s_axi_bvalid);
  @(posedge s_axi_aclk)
  s_axi_bready  = 0;
  @(posedge s_axi_aclk);
  s_axi_arvalid	= 1;
  s_axi_araddr	= 4;
  s_axi_arprot	= 0;
  s_axi_rready	= 1;
  if (s_axi_arready) @(posedge s_axi_aclk); else @(posedge s_axi_arready);
  @(posedge s_axi_aclk)
  s_axi_arvalid	= 0;
  if (s_axi_rvalid) @(posedge s_axi_aclk); else @(posedge s_axi_rvalid);
  @(posedge s_axi_aclk)
  s_axi_rready	= 0;
  repeat(10) @(posedge s_axi_aclk);
  s_axi_awvalid	= 1;
  s_axi_awaddr	= 24'h100;
  s_axi_awprot	= 0;
  s_axi_wdata 	= 32'h12345678;
  s_axi_wvalid	= 1;
  if (s_axi_awready) @(posedge s_axi_aclk); else @(posedge s_axi_awready);
  @(posedge s_axi_aclk)
  s_axi_awvalid	= 0;
  if (s_axi_wready) @(posedge s_axi_aclk); else @(posedge s_axi_wready);
  @(posedge s_axi_aclk)
  s_axi_wvalid	= 0;
  s_axi_awaddr	= 0;
  s_axi_awprot	= 0;
  s_axi_wdata 	= 0;
  s_axi_wvalid	= 0;
  s_axi_bready	= 1;
  if (s_axi_bvalid) @(posedge s_axi_aclk); else @(posedge s_axi_bvalid);
  @(posedge s_axi_aclk)
  s_axi_bready  = 0;
  @(posedge s_axi_aclk);
  s_axi_arvalid	= 1;
  s_axi_araddr	= 24'h100;
  s_axi_arprot	= 0;
  s_axi_rready	= 1;
  if (s_axi_arready) @(posedge s_axi_aclk); else @(posedge s_axi_arready);
  @(posedge s_axi_aclk)
  s_axi_arvalid	= 0;
  if (s_axi_rvalid) @(posedge s_axi_aclk); else @(posedge s_axi_rvalid);
  @(posedge s_axi_aclk)
  s_axi_rready	= 0; 
end

endmodule
