module main(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
	input [3:0] KEY;
	input [17:0] SW;
	output [17:0] LEDR;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;

	wire [31:0] product;

	controller mul1(~KEY[3], KEY[2], SW[1:0], LEDR[0], product);

	segment disp0(product[3:0], HEX0);
	segment disp1(product[7:4], HEX1);
	segment disp2(product[11:8], HEX2);
	segment disp3(product[15:12], HEX3);
	segment disp4(product[19:16], HEX4);
	segment disp5(product[23:20], HEX5);
	segment disp6(product[27:24], HEX6);
	segment disp7(product[31:28], HEX7);
endmodule
