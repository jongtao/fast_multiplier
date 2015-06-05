module main(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
	input [3:0] KEY;
	input [17:0] SW;
	output [17:0] LEDR;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;

	wire [63:0] product;
	reg [31:0] show_product;

	controller mul1(~KEY[3], KEY[2], SW[1:0], LEDR[0], product);
	
	always@(SW[2], product) begin
		show_product <= SW[2] ? product[63:32]: product[31:0];
	end // always switch 2 and product

	segment disp0(show_product[3:0], HEX0);
	segment disp1(show_product[7:4], HEX1);
	segment disp2(show_product[11:8], HEX2);
	segment disp3(show_product[15:12], HEX3);
	segment disp4(show_product[19:16], HEX4);
	segment disp5(show_product[23:20], HEX5);
	segment disp6(show_product[27:24], HEX6);
	segment disp7(show_product[31:28], HEX7);
endmodule
