module mplier16x16(
	output [33:0] product, 
	input [15:0] mplier, mcand
	);
	
	wire [3:0] rec0, rec1, rec2, rec3, rec4, rec5;
	wire [18:0] pp0, pp1, pp2, pp3, pp4, pp5;
	wire [31:0] a, b;
	
	recode8 REC0	({mplier[2:0],1'b0},							rec0);
	recode8 REC1	(mplier[5:2],									rec1);
	recode8 REC2	(mplier[8:5],									rec2);
	recode8 REC3	(mplier[11:8],									rec3);
	recode8 REC4	(mplier[14:11],								rec4);
	recode8 REC5	({{2{mplier[15]}},mplier[15:14]},		rec5);
	
	pps16x16 PP0 	(mcand, rec0, 	pp0);
	pps16x16 PP1 	(mcand, rec1, 	pp1);
	pps16x16 PP2 	(mcand, rec2, 	pp2);
	pps16x16 PP3 	(mcand, rec3, 	pp3);
	pps16x16 PP4 	(mcand, rec4, 	pp4);
	pps16x16 PP5 	(mcand, rec5, 	pp5);
	

	wallace16x16  WAL16X16( a, b, pp0, pp1, pp2, pp3, pp4, pp5);
	
	
	assign product = { {15{pp0[18]}}, pp0 } + { {12{pp1[18]}},pp1,3'd0} + { {9{pp2[18]}},pp2,6'd0} 
		+ { {6{pp3[18]}},pp3,9'd0} + { {3{pp4[18]}},pp4,12'd0} + {pp5,15'd0};
						
						
endmodule // mplier16x16

//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================

module recode8(grouping, recoded);

	input [3:0] grouping;
	output reg [3:0] recoded;

always @(*) begin

case (grouping)
	0,15: 	recoded = 4'd0;
	1,2:		recoded = 4'd1;
	3,4: 		recoded = 4'd2;
	5,6: 		recoded = 4'd3;
	7:			recoded = 4'd4;
	8: 		recoded = -4'd4;
	9,10:		recoded = -4'd3;
	11,12:	recoded = -4'd2;
	13,14:	recoded = -4'd1;
	default:	recoded = 4'd0;
	
endcase
end
	
endmodule // recode8

//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================

module pps16x16(mcand, recoding, partprod);

	localparam 
		MCAND_LEN = 16, 
		RADIX_LEN = 4;

	input [MCAND_LEN-1:0] mcand;
	input [RADIX_LEN-1:0] recoding;
	output reg [MCAND_LEN+2:0] partprod;
	
	
always @(*) begin
		case (recoding)
		0:		partprod = 19'd0;
		1:		partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
		2:		begin 
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = partprod << 1;
				end
		3:		begin
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = (partprod << 1) + {{3{mcand[MCAND_LEN-1]}}, mcand};
				end
		4:		begin 
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = partprod << 2;
				end
	4'b1100:	begin 
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = partprod << 2;
				partprod = ~(partprod) + 1;
				end
	4'b1101:	begin 
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = (partprod << 1) + {{3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = ~(partprod) + 1;
				end
	4'b1110:	begin
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = partprod << 1;
				partprod = ~(partprod) + 1;
				end
	4'b1111:	begin
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = ~(partprod) + 1;
				end
		default:
				partprod = 19'd0;
		endcase
end
	
endmodule	//pps16x16

//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================


module wallace16x16( a, b, pp0, pp1, pp2, pp3, pp4, pp5);

	input [18:0] pp0, pp1, pp2, pp3, pp4, pp5;
	output reg [31:0] a, b;

	wire [31:0] a_w, b_w;
	
	wire w6cout, w7cout, w8cout;
	wire [1:0] w9cout, w10cout, w11cout;
	wire [2:0] w12cout, w13cout, w14cout;
	wire [3:0] w15cout, w16cout, w17cout,
				  w18cout, w19cout, w20cout,
				  w21cout, w22cout, w23cout,
				  w24cout, w25cout, w26cout,
				  w27cout, w28cout, w29cout,
				  w30cout, w31cout;
	
	
	assign a_w[0] = pp0[0];
	assign b_w[0] = 1'b0;
	
	assign a_w[1] = pp0[1];
	assign b_w[1] = 1'b0;
	
	
	assign a_w[2] = pp0[2];
	assign b_w[2] = 1'b0;
	
	
	
	assign a_w[3] = pp0[3];
	assign b_w[3] = pp1[0];
	
	assign a_w[4] = pp0[4];
	assign b_w[4] = pp1[1];
	
	assign a_w[5] = pp0[5];
	assign b_w[5] = pp1[2];
	
	
	
	fa W6 ( a_w[6], w6cout, pp0[6], pp1[3], pp2[0] );
	assign b_w[6] = 1'b0;
	
	fa W7	( a_w[7], w7cout, pp0[7], pp1[4], pp2[1] );
	assign b_w[7] = w6cout;
	
	fa W8	( a_w[8], w8cout, pp0[8], pp1[5], pp2[2] );
	assign b_w[8] = w7cout;
	
	
	
	fas2 W9 	( a_w[9], w9cout, {w8cout, pp0[9], pp1[6], pp2[3], pp3[0]} );
	assign b_w[9] = 1'b0;
	
	fas2 W10 	( a_w[10], w10cout, {w9cout[0], pp0[10], pp1[7], pp2[4], pp3[1]} );
	assign b_w[10] = w9cout[1];
	
	fas2 W11 	( a_w[11], w11cout, {w10cout[0], pp0[11], pp1[8], pp2[5], pp3[2]} );
	assign b_w[11] = w10cout[1];
	
	
	
	fas3 W12 	( a_w[12], w12cout, {w11cout, pp0[12], pp1[9], pp2[6], pp3[3], pp4[0]} );
	assign b_w[12] = 1'b0;	
	
	fas3 W13 	( a_w[13], w13cout, {w12cout[1:0], pp0[13], pp1[10], pp2[7], pp3[4], pp4[1]} );
	assign b_w[13] = w12cout[2];
	
	fas3 W14 	( a_w[14], w14cout, {w13cout[1:0], pp0[14], pp1[11], pp2[8], pp3[5], pp4[2]} );
	assign b_w[14] = w13cout[2];


	
	fas4 W15 	( a_w[15], w15cout, {w14cout, pp0[15], pp1[12], pp2[9], pp3[6], pp4[3], pp5[0]} );
	assign b_w[15] = 1'b0;
	
	fas4 W16 	( a_w[16], w16cout, {w15cout[2:0], pp0[16], pp1[13], pp2[10], pp3[7], pp4[4], pp5[1]} );
	assign b_w[16] = w15cout[3];
	
	fas4 W17 	( a_w[17], w17cout, {w16cout[2:0], pp0[17], pp1[14], pp2[11], pp3[8], pp4[5], pp5[2]} );
	assign b_w[17] = w16cout[3];

	fas4 W18 	( a_w[18], w18cout, {w17cout[2:0], pp0[18], pp1[15], pp2[12], pp3[9], pp4[6], pp5[3]} );
	assign b_w[18] = w17cout[3];

	fas4 W19 	( a_w[19], w19cout, {w18cout[2:0], pp0[18], pp1[16], pp2[13], pp3[10], pp4[7], pp5[4]} );
	assign b_w[19] = w18cout[3];

	fas4 W20 	( a_w[20], w20cout, {w19cout[2:0], pp0[18], pp1[17], pp2[14], pp3[11], pp4[8], pp5[5]} );
	assign b_w[20] = w19cout[3];
	
	fas4 W21 	( a_w[21], w21cout, {w20cout[2:0], pp0[18], pp1[18], pp2[15], pp3[12], pp4[9], pp5[6]} );
	assign b_w[21] = w20cout[3];
	
	fas4 W22 	( a_w[22], w22cout, {w21cout[2:0], pp0[18], pp1[18], pp2[16], pp3[13], pp4[10], pp5[7]} );
	assign b_w[22] = w21cout[3];
	
	fas4 W23 	( a_w[23], w23cout, {w22cout[2:0], pp0[18], pp1[18], pp2[17], pp3[14], pp4[11], pp5[8]} );
	assign b_w[23] = w22cout[3];
	
	fas4 W24 	( a_w[24], w24cout, {w23cout[2:0], pp0[18], pp1[18], pp2[18], pp3[15], pp4[12], pp5[9]} );
	assign b_w[24] = w23cout[3];
	
	fas4 W25 	( a_w[25], w25cout, {w24cout[2:0], pp0[18], pp1[18], pp2[18], pp3[16], pp4[13], pp5[10]} );
	assign b_w[25] = w24cout[3];
	
	fas4 W26 	( a_w[26], w26cout, {w25cout[2:0], pp0[18], pp1[18], pp2[18], pp3[17], pp4[14], pp5[11]} );
	assign b_w[26] = w25cout[3];
	
	fas4 W27 	( a_w[27], w27cout, {w26cout[2:0], pp0[18], pp1[18], pp2[18], pp3[18], pp4[15], pp5[12]} );
	assign b_w[27] = w26cout[3];
	
	fas4 W28 	( a_w[28], w28cout, {w27cout[2:0], pp0[18], pp1[18], pp2[18], pp3[18], pp4[16], pp5[13]} );
	assign b_w[28] = w27cout[3];
	
	fas4 W29 	( a_w[29], w29cout, {w28cout[2:0], pp0[18], pp1[18], pp2[18], pp3[18], pp4[17], pp5[14]} );
	assign b_w[29] = w28cout[3];
	
	fas4 W30 	( a_w[30], w30cout, {w29cout[2:0], pp0[18], pp1[18], pp2[18], pp3[18], pp4[18], pp5[15]} );
	assign b_w[30] = w29cout[3];
	
	fas4 W31 	( a_w[31], w31cout, {w30cout[2:0], pp0[18], pp1[18], pp2[18], pp3[18], pp4[18], pp5[16]} );
	assign b_w[31] = w30cout[3];
	
	
	
	always @(*) begin
		
		a = a_w;
		b = b_w;
	
	
	end
	


endmodule // wallace16x16

module fa(sum,c_out,c_in,x,y);  //full adder
   input x,y,c_in;
   output sum,c_out;
   assign {c_out,sum}=x+y+c_in;
endmodule //fa

module fas2 (a, cout, fanin);

	input [4:0] fanin;
	output a;
	output [1:0] cout;
	
	wire sum1;
	
	fa FA0 (sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA1 (a, cout[1], fanin[3], fanin[4], sum1);

endmodule //

module fas3 (a, cout, fanin);

	input [6:0] fanin;
	output a;
	output [2:0] cout;
	
	wire sum1, sum2;
	
	fa FA0(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA1(sum2, cout[1], sum1 , fanin[4], fanin[3]);
	fa FA2(a, cout[2], sum2, fanin[6], fanin[5]);

endmodule

module fas4 (a, cout, fanin);

	input [8:0] fanin;
	output a;
	output [3:0] cout;
	
	wire sum1, sum2, sum3;
	
	fa FA0(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA1(sum2, cout[1], fanin[5], fanin[4], fanin[3]);
	fa FA2(sum3, cout[2], fanin[8], fanin[7], fanin[6]);
	fa FA3(a, cout[3], sum2, sum3, sum1);

endmodule








