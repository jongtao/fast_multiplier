module mplier8x8( 
	output [15:0] product, 
	input [7:0] mplier, mcand
	);
	
	wire [2:0] rec0, rec1, rec2, rec3;
	wire [9:0] pp0, pp1, pp2, pp3;
	
	recode4 REC0	({mplier[1:0],1'b0},		rec0);
	recode4 REC1	(mplier[3:1],				rec1);
	recode4 REC2	(mplier[5:3],				rec2);
	recode4 REC3	(mplier[7:5],				rec3);
	
	
	pps16 PP0 	(mcand, rec0, 	pp0);
	pps16 PP1 	(mcand, rec1, 	pp1);
	pps16 PP2 	(mcand, rec2, 	pp2);
	pps16 PP3 	(mcand, rec3, 	pp3);
	
	
	assign product = { {6{pp0[9]}}, pp0 } + { {4{pp1[9]}},pp1,2'd0} + { {2{pp2[9]}},pp2,4'd0} +  {pp3,6'd0};
	
	
endmodule // mplier32


module pps16(mcand, recoding, partprod);
	localparam 
		MCAND_LEN = 8, 
		RADIX_LEN = 3;

	input [MCAND_LEN-1:0] mcand;
	input [RADIX_LEN-1:0] recoding;
	output reg [MCAND_LEN+1:0] partprod;
	
	
	always @(*) begin
		case (recoding)
			0:		partprod = 10'd0;
			1:		partprod = { {2{mcand[MCAND_LEN-1]}}, mcand};
			2: begin 
					partprod = { {2{mcand[MCAND_LEN-1]}}, mcand};
					partprod = partprod << 1;
			end
			3'b111:	begin
					partprod = { {2{mcand[MCAND_LEN-1]}}, mcand};
					partprod = ~(partprod) + 1;
			end
			3'b110:	begin 
					partprod = { {2{mcand[MCAND_LEN-1]}}, mcand};
					partprod = partprod << 1;
					partprod = ~(partprod) + 1;
			end
			default: partprod = 10'd0;
		endcase
	end
	
endmodule

