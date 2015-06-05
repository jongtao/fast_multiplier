module tb_mplier8x8;
	reg signed[8:0] a, b;
	wire [15:0] raw_product;
	reg signed [15:0] product;


	mplier8x8 unit(raw_product, a[7:0], b[7:0]);


	initial begin
		$display("begin");
		for(a = 9'b0; a[8] != 1'b1; a = a + 1) begin
			for(b = 9'b0; b[8] != 1'b1; b = b + 1) begin
				product = $signed(a[7:0]) * $signed(b[7:0]);
				#10;
				if(product != raw_product && product < 17'h10000)
					$display("%dx%d != %d, %d", $signed(a[7:0]), $signed(b[7:0]), $signed(raw_product), product);
				$display("%dx%d = %d, %d", $signed(a[7:0]), $signed(b[7:0]), $signed(raw_product), product);
			end // for b
		end // for a
		$display("end");
	end
endmodule
