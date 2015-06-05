module tb_mplier16x16;
	reg signed[16:0] a, b;
	wire [31:0] raw_product;
	reg signed [31:0] product;


	mplier16x16 unit(raw_product, a[15:0], b[15:0]);


	initial begin
		$display("begin");
		for(a = 17'b0; a[16] != 1'b1; a = a + 1) begin
			for(b = 17'b0; b[16] != 1'b1; b = b + 1) begin
				product = $signed(a[15:0]) * $signed(b[15:0]);
				#10;
				if(product != raw_product && product < 17'h10000)
					$display("%dx%d != %d, %d", a[15:0], b[15:0], raw_product, product);
				//$display("%dx%d=%d", a[7:0], b[7:0], raw_product);
			end // for b
		end // for a
		$display("end");
	end
endmodule
