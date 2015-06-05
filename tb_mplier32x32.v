module tb_mplier32x32;
	reg signed[64:0] vector;
	wire [63:0] raw_product;
	reg signed [63:0] product;


	mplier32x32 unit(raw_product, vector[63:32], vector[31:0]);


	initial begin
		$display("begin");
		for(vector = -64'd0; vector[64] != 1'b1; vector = vector + 64'd1000000000000000) begin
				product = $signed(vector[63:32]) * $signed(vector[31:0]);
				#10;
				if(product != raw_product)//&& product < 64'h10000000000000000)
					$display("Error: %dx%d != %d, %d",
						$signed(vector[63:32]), $signed(vector[31:0]), $signed(raw_product), product);
				$display("%dx%d = %d, %d",
					$signed(vector[63:32]), $signed(vector[31:0]), $signed(raw_product), product);
		end // for a
		$display("end");
	end
endmodule
