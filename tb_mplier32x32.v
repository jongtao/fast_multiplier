module tb_mplier32x32;
	reg signed[64:0] vector;
	wire [31:0] raw_product;
	reg signed [63:0] product;


	mplier16x16 unit(raw_product, vector[63:32], vector[31:0]);


	initial begin
		$display("begin");
		for(vector = 64'b0; vector[64] != 1'b1; vector = vector + 1) begin
				product = $signed(vector[63:32]) * $signed(vector[31:0]);
				#10;
				if(product != raw_product && product < 64'h10000000000000000)
					$display("%dx%d != %d, %d",
						vector[63:32], b[31:0], raw_product, product);
				//$display("%dx%d=%d", a[7:0], b[7:0], raw_product);
		end // for a
		$display("end");
	end
endmodule
