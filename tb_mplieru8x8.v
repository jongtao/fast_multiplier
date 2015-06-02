module tb_mplieru8x8;
	integer test_vector;
	wire [15:0] raw_product;
	integer product;

	mplieru8x8 unit(raw_product, test_vector[15:8], test_vector[7:0]);

	initial begin
		$display("begin");
		for(test_vector = 16'h0000; test_vector[16] != 1;
			test_vector = test_vector + 1) begin
			product = test_vector[15:8] * test_vector[7:0];
			#10;
			if(product != raw_product && product < 17'h10000)
				$display("%dx%d != %d, %d",
					test_vector[15:8], test_vector[7:0], raw_product, product);
			$display("%dx%d=%d",test_vector[15:8], test_vector[7:0], raw_product);
		end
		$display("end");
	end
endmodule
