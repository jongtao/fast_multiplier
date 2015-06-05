module tb_cla_32;
	reg [32:0] a, b;
	wire [31:0] raw_sum;
	reg [31:0] sum;


	CLA_32 unit(raw_sum, G, P, a[31:0], b[31:0], 1'b0);


	initial begin
		$display("begin");
		for(a = 33'b0; a[32] != 1'b1; a = a + 1) begin
			for(b = 33'b0; b[32] != 1'b1; b = b + 1) begin
				sum = a[31:0] + b[31:0];
				#10;
				if(sum != raw_sum && sum < 33'h100000000)
					$display("%d+%d != %d, %d", a[31:0], b[31:0], raw_sum, sum);
				//$display("%d+%d=%d", a[31:0], b[31:0], raw_sum);
			end // for b
		end // for a
		$display("end");
	end
endmodule
