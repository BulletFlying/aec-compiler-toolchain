module tb2;
  localparam CYCLE_COUNT = 48;

  reg clk = 1'b0;
  reg rst;
  reg s_eth_hdr_valid;
  reg [47:0] s_eth_dest_mac;
  reg [47:0] s_eth_src_mac;
  reg [15:0] s_eth_type;
  reg [7:0] s_eth_payload_axis_tdata;
  reg s_eth_payload_axis_tvalid;
  reg s_eth_payload_axis_tlast;
  reg s_eth_payload_axis_tuser;
  reg m_eth_hdr_ready;
  reg m_eth_payload_axis_tready;
  reg arp_request_ready;
  reg arp_response_valid;
  reg arp_response_error;
  reg [47:0] arp_response_mac;
  reg s_ip_hdr_valid;
  reg [5:0] s_ip_dscp;
  reg [1:0] s_ip_ecn;
  reg [15:0] s_ip_length;
  reg [7:0] s_ip_ttl;
  reg [7:0] s_ip_protocol;
  reg [31:0] s_ip_source_ip;
  reg [31:0] s_ip_dest_ip;
  reg [7:0] s_ip_payload_axis_tdata;
  reg s_ip_payload_axis_tvalid;
  reg s_ip_payload_axis_tlast;
  reg s_ip_payload_axis_tuser;
  reg m_ip_hdr_ready;
  reg m_ip_payload_axis_tready;
  reg [47:0] local_mac;
  reg [31:0] local_ip;
  wire s_eth_hdr_ready;
  wire s_eth_payload_axis_tready;
  wire m_eth_hdr_valid;
  wire [47:0] m_eth_dest_mac;
  wire [47:0] m_eth_src_mac;
  wire [15:0] m_eth_type;
  wire [7:0] m_eth_payload_axis_tdata;
  wire m_eth_payload_axis_tvalid;
  wire m_eth_payload_axis_tlast;
  wire m_eth_payload_axis_tuser;
  wire arp_request_valid;
  wire [31:0] arp_request_ip;
  wire arp_response_ready;
  wire s_ip_hdr_ready;
  wire s_ip_payload_axis_tready;
  wire m_ip_hdr_valid;
  wire [47:0] m_ip_eth_dest_mac;
  wire [47:0] m_ip_eth_src_mac;
  wire [15:0] m_ip_eth_type;
  wire [3:0] m_ip_version;
  wire [3:0] m_ip_ihl;
  wire [5:0] m_ip_dscp;
  wire [1:0] m_ip_ecn;
  wire [15:0] m_ip_length;
  wire [15:0] m_ip_identification;
  wire [2:0] m_ip_flags;
  wire [12:0] m_ip_fragment_offset;
  wire [7:0] m_ip_ttl;
  wire [7:0] m_ip_protocol;
  wire [15:0] m_ip_header_checksum;
  wire [31:0] m_ip_source_ip;
  wire [31:0] m_ip_dest_ip;
  wire [7:0] m_ip_payload_axis_tdata;
  wire m_ip_payload_axis_tvalid;
  wire m_ip_payload_axis_tlast;
  wire m_ip_payload_axis_tuser;
  wire rx_busy;
  wire tx_busy;
  wire rx_error_header_early_termination;
  wire rx_error_payload_early_termination;
  wire rx_error_invalid_header;
  wire rx_error_invalid_checksum;
  wire tx_error_payload_early_termination;
  wire tx_error_arp_failed;

  reg read_rst;
  reg read_s_eth_hdr_valid;
  reg [47:0] read_s_eth_dest_mac;
  reg [47:0] read_s_eth_src_mac;
  reg [15:0] read_s_eth_type;
  reg [7:0] read_s_eth_payload_axis_tdata;
  reg read_s_eth_payload_axis_tvalid;
  reg read_s_eth_payload_axis_tlast;
  reg read_s_eth_payload_axis_tuser;
  reg read_m_eth_hdr_ready;
  reg read_m_eth_payload_axis_tready;
  reg read_arp_request_ready;
  reg read_arp_response_valid;
  reg read_arp_response_error;
  reg [47:0] read_arp_response_mac;
  reg read_s_ip_hdr_valid;
  reg [5:0] read_s_ip_dscp;
  reg [1:0] read_s_ip_ecn;
  reg [15:0] read_s_ip_length;
  reg [7:0] read_s_ip_ttl;
  reg [7:0] read_s_ip_protocol;
  reg [31:0] read_s_ip_source_ip;
  reg [31:0] read_s_ip_dest_ip;
  reg [7:0] read_s_ip_payload_axis_tdata;
  reg read_s_ip_payload_axis_tvalid;
  reg read_s_ip_payload_axis_tlast;
  reg read_s_ip_payload_axis_tuser;
  reg read_m_ip_hdr_ready;
  reg read_m_ip_payload_axis_tready;
  reg [47:0] read_local_mac;
  reg [31:0] read_local_ip;
  reg want_s_eth_hdr_ready;
  reg want_s_eth_payload_axis_tready;
  reg want_m_eth_hdr_valid;
  reg [47:0] want_m_eth_dest_mac;
  reg [47:0] want_m_eth_src_mac;
  reg [15:0] want_m_eth_type;
  reg [7:0] want_m_eth_payload_axis_tdata;
  reg want_m_eth_payload_axis_tvalid;
  reg want_m_eth_payload_axis_tlast;
  reg want_m_eth_payload_axis_tuser;
  reg want_arp_request_valid;
  reg [31:0] want_arp_request_ip;
  reg want_arp_response_ready;
  reg want_s_ip_hdr_ready;
  reg want_s_ip_payload_axis_tready;
  reg want_m_ip_hdr_valid;
  reg [47:0] want_m_ip_eth_dest_mac;
  reg [47:0] want_m_ip_eth_src_mac;
  reg [15:0] want_m_ip_eth_type;
  reg [3:0] want_m_ip_version;
  reg [3:0] want_m_ip_ihl;
  reg [5:0] want_m_ip_dscp;
  reg [1:0] want_m_ip_ecn;
  reg [15:0] want_m_ip_length;
  reg [15:0] want_m_ip_identification;
  reg [2:0] want_m_ip_flags;
  reg [12:0] want_m_ip_fragment_offset;
  reg [7:0] want_m_ip_ttl;
  reg [7:0] want_m_ip_protocol;
  reg [15:0] want_m_ip_header_checksum;
  reg [31:0] want_m_ip_source_ip;
  reg [31:0] want_m_ip_dest_ip;
  reg [7:0] want_m_ip_payload_axis_tdata;
  reg want_m_ip_payload_axis_tvalid;
  reg want_m_ip_payload_axis_tlast;
  reg want_m_ip_payload_axis_tuser;
  reg want_rx_busy;
  reg want_tx_busy;
  reg want_rx_error_header_early_termination;
  reg want_rx_error_payload_early_termination;
  reg want_rx_error_invalid_header;
  reg want_rx_error_invalid_checksum;
  reg want_tx_error_payload_early_termination;
  reg want_tx_error_arp_failed;
  reg [8191:0] in_head;
  reg [8191:0] out_head;

  integer in_fd;
  integer out_fd;
  integer scan_count;
  integer cycle;

  always #5 clk = ~clk;

  ip dut (
    .clk(clk),
    .rst(rst),
    .s_eth_hdr_valid(s_eth_hdr_valid),
    .s_eth_dest_mac(s_eth_dest_mac),
    .s_eth_src_mac(s_eth_src_mac),
    .s_eth_type(s_eth_type),
    .s_eth_payload_axis_tdata(s_eth_payload_axis_tdata),
    .s_eth_payload_axis_tvalid(s_eth_payload_axis_tvalid),
    .s_eth_payload_axis_tlast(s_eth_payload_axis_tlast),
    .s_eth_payload_axis_tuser(s_eth_payload_axis_tuser),
    .m_eth_hdr_ready(m_eth_hdr_ready),
    .m_eth_payload_axis_tready(m_eth_payload_axis_tready),
    .arp_request_ready(arp_request_ready),
    .arp_response_valid(arp_response_valid),
    .arp_response_error(arp_response_error),
    .arp_response_mac(arp_response_mac),
    .s_ip_hdr_valid(s_ip_hdr_valid),
    .s_ip_dscp(s_ip_dscp),
    .s_ip_ecn(s_ip_ecn),
    .s_ip_length(s_ip_length),
    .s_ip_ttl(s_ip_ttl),
    .s_ip_protocol(s_ip_protocol),
    .s_ip_source_ip(s_ip_source_ip),
    .s_ip_dest_ip(s_ip_dest_ip),
    .s_ip_payload_axis_tdata(s_ip_payload_axis_tdata),
    .s_ip_payload_axis_tvalid(s_ip_payload_axis_tvalid),
    .s_ip_payload_axis_tlast(s_ip_payload_axis_tlast),
    .s_ip_payload_axis_tuser(s_ip_payload_axis_tuser),
    .m_ip_hdr_ready(m_ip_hdr_ready),
    .m_ip_payload_axis_tready(m_ip_payload_axis_tready),
    .local_mac(local_mac),
    .local_ip(local_ip),
    .s_eth_hdr_ready(s_eth_hdr_ready),
    .s_eth_payload_axis_tready(s_eth_payload_axis_tready),
    .m_eth_hdr_valid(m_eth_hdr_valid),
    .m_eth_dest_mac(m_eth_dest_mac),
    .m_eth_src_mac(m_eth_src_mac),
    .m_eth_type(m_eth_type),
    .m_eth_payload_axis_tdata(m_eth_payload_axis_tdata),
    .m_eth_payload_axis_tvalid(m_eth_payload_axis_tvalid),
    .m_eth_payload_axis_tlast(m_eth_payload_axis_tlast),
    .m_eth_payload_axis_tuser(m_eth_payload_axis_tuser),
    .arp_request_valid(arp_request_valid),
    .arp_request_ip(arp_request_ip),
    .arp_response_ready(arp_response_ready),
    .s_ip_hdr_ready(s_ip_hdr_ready),
    .s_ip_payload_axis_tready(s_ip_payload_axis_tready),
    .m_ip_hdr_valid(m_ip_hdr_valid),
    .m_ip_eth_dest_mac(m_ip_eth_dest_mac),
    .m_ip_eth_src_mac(m_ip_eth_src_mac),
    .m_ip_eth_type(m_ip_eth_type),
    .m_ip_version(m_ip_version),
    .m_ip_ihl(m_ip_ihl),
    .m_ip_dscp(m_ip_dscp),
    .m_ip_ecn(m_ip_ecn),
    .m_ip_length(m_ip_length),
    .m_ip_identification(m_ip_identification),
    .m_ip_flags(m_ip_flags),
    .m_ip_fragment_offset(m_ip_fragment_offset),
    .m_ip_ttl(m_ip_ttl),
    .m_ip_protocol(m_ip_protocol),
    .m_ip_header_checksum(m_ip_header_checksum),
    .m_ip_source_ip(m_ip_source_ip),
    .m_ip_dest_ip(m_ip_dest_ip),
    .m_ip_payload_axis_tdata(m_ip_payload_axis_tdata),
    .m_ip_payload_axis_tvalid(m_ip_payload_axis_tvalid),
    .m_ip_payload_axis_tlast(m_ip_payload_axis_tlast),
    .m_ip_payload_axis_tuser(m_ip_payload_axis_tuser),
    .rx_busy(rx_busy),
    .tx_busy(tx_busy),
    .rx_error_header_early_termination(rx_error_header_early_termination),
    .rx_error_payload_early_termination(rx_error_payload_early_termination),
    .rx_error_invalid_header(rx_error_invalid_header),
    .rx_error_invalid_checksum(rx_error_invalid_checksum),
    .tx_error_payload_early_termination(tx_error_payload_early_termination),
    .tx_error_arp_failed(tx_error_arp_failed)
  );

  initial begin
    rst = 0;
    s_eth_hdr_valid = 0;
    s_eth_dest_mac = 0;
    s_eth_src_mac = 0;
    s_eth_type = 0;
    s_eth_payload_axis_tdata = 0;
    s_eth_payload_axis_tvalid = 0;
    s_eth_payload_axis_tlast = 0;
    s_eth_payload_axis_tuser = 0;
    m_eth_hdr_ready = 0;
    m_eth_payload_axis_tready = 0;
    arp_request_ready = 0;
    arp_response_valid = 0;
    arp_response_error = 0;
    arp_response_mac = 0;
    s_ip_hdr_valid = 0;
    s_ip_dscp = 0;
    s_ip_ecn = 0;
    s_ip_length = 0;
    s_ip_ttl = 0;
    s_ip_protocol = 0;
    s_ip_source_ip = 0;
    s_ip_dest_ip = 0;
    s_ip_payload_axis_tdata = 0;
    s_ip_payload_axis_tvalid = 0;
    s_ip_payload_axis_tlast = 0;
    s_ip_payload_axis_tuser = 0;
    m_ip_hdr_ready = 0;
    m_ip_payload_axis_tready = 0;
    local_mac = 0;
    local_ip = 0;

    in_fd = $fopen("tb/input.mem", "r");
    out_fd = $fopen("tb/output.mem", "w");
    if (in_fd == 0 || out_fd == 0) begin
      $display("FAIL cannot open pair files");
      $finish;
    end

    scan_count = $fgets(in_head, in_fd);
    $fdisplay(out_fd, "s_eth_hdr_ready,s_eth_payload_axis_tready,m_eth_hdr_valid,m_eth_dest_mac[47:0],m_eth_src_mac[47:0],m_eth_type[15:0],m_eth_payload_axis_tdata[7:0],m_eth_payload_axis_tvalid,m_eth_payload_axis_tlast,m_eth_payload_axis_tuser,arp_request_valid,arp_request_ip[31:0],arp_response_ready,s_ip_hdr_ready,s_ip_payload_axis_tready,m_ip_hdr_valid,m_ip_eth_dest_mac[47:0],m_ip_eth_src_mac[47:0],m_ip_eth_type[15:0],m_ip_version[3:0],m_ip_ihl[3:0],m_ip_dscp[5:0],m_ip_ecn[1:0],m_ip_length[15:0],m_ip_identification[15:0],m_ip_flags[2:0],m_ip_fragment_offset[12:0],m_ip_ttl[7:0],m_ip_protocol[7:0],m_ip_header_checksum[15:0],m_ip_source_ip[31:0],m_ip_dest_ip[31:0],m_ip_payload_axis_tdata[7:0],m_ip_payload_axis_tvalid,m_ip_payload_axis_tlast,m_ip_payload_axis_tuser,rx_busy,tx_busy,rx_error_header_early_termination,rx_error_payload_early_termination,rx_error_invalid_header,rx_error_invalid_checksum,tx_error_payload_early_termination,tx_error_arp_failed");

    for (cycle = 0; cycle < CYCLE_COUNT; cycle = cycle + 1) begin
      scan_count = $fscanf(in_fd, "%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h\n", read_rst, read_s_eth_hdr_valid, read_s_eth_dest_mac, read_s_eth_src_mac, read_s_eth_type, read_s_eth_payload_axis_tdata, read_s_eth_payload_axis_tvalid, read_s_eth_payload_axis_tlast, read_s_eth_payload_axis_tuser, read_m_eth_hdr_ready, read_m_eth_payload_axis_tready, read_arp_request_ready, read_arp_response_valid, read_arp_response_error, read_arp_response_mac, read_s_ip_hdr_valid, read_s_ip_dscp, read_s_ip_ecn, read_s_ip_length, read_s_ip_ttl, read_s_ip_protocol, read_s_ip_source_ip, read_s_ip_dest_ip, read_s_ip_payload_axis_tdata, read_s_ip_payload_axis_tvalid, read_s_ip_payload_axis_tlast, read_s_ip_payload_axis_tuser, read_m_ip_hdr_ready, read_m_ip_payload_axis_tready, read_local_mac, read_local_ip);
      if (scan_count != 31) begin
        $display("FAIL read input row cycle=%0d count=%0d", cycle, scan_count);
        $finish;
      end
      rst = read_rst;
      s_eth_hdr_valid = read_s_eth_hdr_valid;
      s_eth_dest_mac = read_s_eth_dest_mac;
      s_eth_src_mac = read_s_eth_src_mac;
      s_eth_type = read_s_eth_type;
      s_eth_payload_axis_tdata = read_s_eth_payload_axis_tdata;
      s_eth_payload_axis_tvalid = read_s_eth_payload_axis_tvalid;
      s_eth_payload_axis_tlast = read_s_eth_payload_axis_tlast;
      s_eth_payload_axis_tuser = read_s_eth_payload_axis_tuser;
      m_eth_hdr_ready = read_m_eth_hdr_ready;
      m_eth_payload_axis_tready = read_m_eth_payload_axis_tready;
      arp_request_ready = read_arp_request_ready;
      arp_response_valid = read_arp_response_valid;
      arp_response_error = read_arp_response_error;
      arp_response_mac = read_arp_response_mac;
      s_ip_hdr_valid = read_s_ip_hdr_valid;
      s_ip_dscp = read_s_ip_dscp;
      s_ip_ecn = read_s_ip_ecn;
      s_ip_length = read_s_ip_length;
      s_ip_ttl = read_s_ip_ttl;
      s_ip_protocol = read_s_ip_protocol;
      s_ip_source_ip = read_s_ip_source_ip;
      s_ip_dest_ip = read_s_ip_dest_ip;
      s_ip_payload_axis_tdata = read_s_ip_payload_axis_tdata;
      s_ip_payload_axis_tvalid = read_s_ip_payload_axis_tvalid;
      s_ip_payload_axis_tlast = read_s_ip_payload_axis_tlast;
      s_ip_payload_axis_tuser = read_s_ip_payload_axis_tuser;
      m_ip_hdr_ready = read_m_ip_hdr_ready;
      m_ip_payload_axis_tready = read_m_ip_payload_axis_tready;
      local_mac = read_local_mac;
      local_ip = read_local_ip;
      @(posedge clk);
      #1;

      $fdisplay(out_fd, "%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h,%h",
          s_eth_hdr_ready,
          s_eth_payload_axis_tready,
          m_eth_hdr_valid,
          m_eth_dest_mac,
          m_eth_src_mac,
          m_eth_type,
          m_eth_payload_axis_tdata,
          m_eth_payload_axis_tvalid,
          m_eth_payload_axis_tlast,
          m_eth_payload_axis_tuser,
          arp_request_valid,
          arp_request_ip,
          arp_response_ready,
          s_ip_hdr_ready,
          s_ip_payload_axis_tready,
          m_ip_hdr_valid,
          m_ip_eth_dest_mac,
          m_ip_eth_src_mac,
          m_ip_eth_type,
          m_ip_version,
          m_ip_ihl,
          m_ip_dscp,
          m_ip_ecn,
          m_ip_length,
          m_ip_identification,
          m_ip_flags,
          m_ip_fragment_offset,
          m_ip_ttl,
          m_ip_protocol,
          m_ip_header_checksum,
          m_ip_source_ip,
          m_ip_dest_ip,
          m_ip_payload_axis_tdata,
          m_ip_payload_axis_tvalid,
          m_ip_payload_axis_tlast,
          m_ip_payload_axis_tuser,
          rx_busy,
          tx_busy,
          rx_error_header_early_termination,
          rx_error_payload_early_termination,
          rx_error_invalid_header,
          rx_error_invalid_checksum,
          tx_error_payload_early_termination,
          tx_error_arp_failed);
    end

    $display("PASS cycles=%0d", CYCLE_COUNT);
    $finish;
  end
endmodule
