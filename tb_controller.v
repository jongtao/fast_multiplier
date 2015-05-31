module tb_controller;
	reg clock, reset;
	reg [1:0] mode;
	wire done;
	wire [31:0] product;
	
	controller dut1(clock, reset, mode, done, product);
	
	initial begin
		mode = 0;
		clock = 0; reset = 1;
		#10 reset = 0;
		#10 reset = 1;
	end
	
	always #10 clock = ~clock;
endmodule // tb_controller