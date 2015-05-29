module mplier32( 
	output [63:0] product, 
	input [31:0] mplier, mcand
	);
	
	wire [3:0] rec0, rec1, rec2, rec3, rec4, rec5, rec6, rec7, rec8, rec9, rec10;
	wire [34:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10;
	wire [63:0] sums, couts;
	
	recode8 REC0	({mplier[2:0],1'b0},				rec0);
	recode8 REC1	(mplier[5:2],						rec1);
	recode8 REC2	(mplier[8:5],						rec2);
	recode8 REC3	(mplier[11:8],						rec3);
	recode8 REC4	(mplier[14:11],					rec4);
	recode8 REC5	(mplier[17:14],					rec5);
	recode8 REC6	(mplier[20:17],					rec6);
	recode8 REC7	(mplier[23:20],					rec7);
	recode8 REC8	(mplier[26:23],					rec8);
	recode8 REC9	(mplier[29:26],					rec9);
	recode8 REC10	({mplier[31], mplier[31:29]},	rec10);
	
	pps32 PP0 	(mcand, rec0, 	pp0);
	pps32 PP1 	(mcand, rec1, 	pp1);
	pps32 PP2 	(mcand, rec2, 	pp2);
	pps32 PP3 	(mcand, rec3, 	pp3);
	pps32 PP4 	(mcand, rec4, 	pp4);
	pps32 PP5 	(mcand, rec5, 	pp5);
	pps32 PP6 	(mcand, rec6, 	pp6);
	pps32 PP7 	(mcand, rec7, 	pp7);
	pps32 PP8 	(mcand, rec8, 	pp8);
	pps32 PP9 	(mcand, rec9, 	pp9);
	pps32 PP10 	(mcand, rec10, pp10);
	
	
	
	stages32 ALLSTAGE (sums, couts, { {29{pp0[34]}}, pp0 }, { {26{pp1[34]}},pp1,3'd0}, { {23{pp2[34]}},pp2,6'd0},
			{ {20{pp3[34]}},pp3,9'd0}, { {17{pp4[34]}},pp4,12'd0}, { {14{pp5[34]}},pp5,15'd0}, { {11{pp6[34]}},pp6,18'd0}, 
			{ {8{pp7[34]}},pp7,21'd0}, { {5{pp8[34]}},pp8,24'd0}, { { 2{pp9[34]}},pp9,27'd0}, {pp10, 29'd0} );
	
	
	assign product = { {29{pp0[34]}}, pp0 } + { {26{pp1[34]}},pp1,3'd0} + { {23{pp2[34]}},pp2,6'd0} 
		+ { {20{pp3[34]}},pp3,9'd0} + { {17{pp4[34]}},pp4,12'd0} + { {14{pp5[34]}},pp5,15'd0} 
		+ { {11{pp6[34]}},pp6,18'd0} + { {8{pp7[34]}},pp7,21'd0} + { {5{pp8[34]}},pp8,24'd0} 
		+ { { 2{pp9[34]}},pp9,27'd0} + {pp10, 29'd0};
	
	
	

	
endmodule // mplier32




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
	
endmodule
////////////
////////////
module pps32(mcand, recoding, partprod);

	localparam 
		MCAND_LEN = 32, 
		RADIX_LEN = 4;

	input [MCAND_LEN-1:0] mcand;
	input [RADIX_LEN-1:0] recoding;
	output reg [MCAND_LEN+2:0] partprod;
	
	
always @(*) begin
		case (recoding)
		0:		partprod = 35'd0;
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
				partprod = 35'd0;
		endcase
end
	
endmodule




module stages32 (sums, couts, pps0, pps1, pps2, pps3, pps4, pps5, pps6, pps7, pps8, pps9, pps10);

	input [63:0] 	pps0, pps1, pps2, pps3, pps4, pps5, pps6, pps7, pps8, pps9, pps10;
	output [63:0] 	sums, couts;
	
	wire [63:0] sumst1, sumst2, sumst3, sumst4, sumst5, sumst6, sumst7, sumst8, sumst9,
					coutst1, coutst2, coutst3, coutst4, coutst5, coutst6, coutst7, coutst8, coutst9;
	
	
	stage STAGE1 (sumst1, 	coutst1, 	pps2,								pps1, 		pps0);
	stage STAGE2 (sumst2, 	coutst2, 	{coutst1[62:0], 1'b0}, 		sumst1,		pps2);
	stage STAGE3 (sumst3, 	coutst3, 	{coutst2[62:0], 1'b0},		sumst2, 		pps3);
	stage STAGE4 (sumst4, 	coutst4, 	{coutst3[62:0], 1'b0},		sumst3, 		pps4);
	stage STAGE5 (sumst5, 	coutst5, 	{coutst4[62:0], 1'b0},		sumst4, 		pps5);
	stage STAGE6 (sumst6, 	coutst6, 	{coutst5[62:0], 1'b0},		sumst5, 		pps6);
	stage STAGE7 (sumst7, 	coutst7, 	{coutst6[62:0], 1'b0},		sumst6, 		pps7);
	stage STAGE8 (sumst8, 	coutst8, 	{coutst7[62:0], 1'b0},		sumst7, 		pps8);
	stage STAGE9 (sumst9, 	coutst9, 	{coutst8[62:0], 1'b0},		sumst8, 		pps9);
	stage STAGE10 (sums, 	couts, 		{coutst9[62:0], 1'b0},		sumst9, 		pps10);	
	
	
endmodule




module stage (sums, couts, fanin2, fanin1, fanin0);

	input [63:0] fanin2, fanin1, fanin0;
	output [63:0] sums, couts;
	
	
	eightfas FA8_0 ( sums[7:0], 		couts[7:0], 	fanin2[7:0], 	fanin1[7:0], 	fanin0[7:0] );
	eightfas FA8_1 ( sums[15:8], 		couts[15:8], 	fanin2[15:8], 	fanin1[15:8], 	fanin0[15:8] );
	eightfas FA8_2 ( sums[23:16], 	couts[23:16], 	fanin2[23:16], fanin1[23:16], fanin0[23:16] );
	eightfas FA8_3 ( sums[31:24], 	couts[31:24], 	fanin2[31:24], fanin1[31:24], fanin0[31:24] );
	eightfas FA8_4 ( sums[39:32], 	couts[39:32], 	fanin2[39:32], fanin1[39:32], fanin0[39:32] );
	eightfas FA8_5 ( sums[47:40], 	couts[47:40], 	fanin2[47:40], fanin1[47:40], fanin0[47:40] );
	eightfas FA8_6 ( sums[55:48], 	couts[55:48], 	fanin2[55:48], fanin1[55:48], fanin0[55:48] );
	eightfas FA8_7 ( sums[63:56], 	couts[63:56], 	fanin2[63:56], fanin1[63:56], fanin0[63:56] );
	
	
	
	
	
endmodule // a stage of wallace


module eightfas (sums, couts, fanin2, fanin1, fanin0);

	input [7:0] fanin2, fanin1, fanin0;
	output [7:0] sums, couts;
	
	
	fa FA0 ( sums[0], couts[0], fanin2[0], fanin1[0], fanin0[0] );
	fa FA1 ( sums[1], couts[1], fanin2[1], fanin1[1], fanin0[1] );
	fa FA2 ( sums[2], couts[2], fanin2[2], fanin1[2], fanin0[2] );
	fa FA3 ( sums[3], couts[3], fanin2[3], fanin1[3], fanin0[3] );
	fa FA4 ( sums[4], couts[4], fanin2[4], fanin1[4], fanin0[4] );
	fa FA5 ( sums[5], couts[5], fanin2[5], fanin1[5], fanin0[5] );
	fa FA6 ( sums[6], couts[6], fanin2[6], fanin1[6], fanin0[6] );
	fa FA7 ( sums[7], couts[7], fanin2[7], fanin1[7], fanin0[7] );	
	
	
endmodule // eight fas for adding





module fa(sum,c_out,c_in,x,y);  //full adder
   input x,y,c_in;
   output sum,c_out;
   assign {c_out,sum}=x+y+c_in;
endmodule //fa









/*











module weight2 (fanin, carryins, fanout, carryout);

	input [1:0] fanin;
	input [1:0] carryins;
	output [1:0] fanout;
	output carryout;
	
	fa FA0 	(fanout[0],	carryout,	fanin[1],	fanin[0], 	carryins[0]);
	assign fanout[1] = carryins[1];
	
endmodule // weight2
	


module weight3 (fanin, carryins, fanout, carryout);

	input [2:0] fanin;
	input [1:0] carryins;
	output [1:0] fanout;
	output carryout;
	
	wire fasum0;
	
	fa FA0	(fasum0, 		carryout,	fanin[2],	fanin[1], 		fanin [0]);
	fa FA1 	(fanout[0],		fanout[1],	fasum,		carryins[0], 	carryins[1]);
	
endmodule  // weight3
	
	
module weight4 (fanin, carryins, fanout, carryouts);

	input [3:0] fanin;
	input [1:0] carryins;
	output [1:0] fanout;
	output [1:0] carryouts;
	
	wire fasum0;
	
	
	fa FA0	(fasum0, 		carryouts[0],	fanin[3],	fanin[2], 	fanin [1]);
	fa FA1 	(fanout[0],		carryouts[1],	fasum0,		fanin[0], 	carryins[0]);

	assign fanout[1] = carryins[1];
	
	
	
endmodule // weight4
	
	

module weight5 (fanin, carryins, fanout, carryouts);

	input [4:0] fanin;
	input [1:0] carryins;
	output [1:0] fanout;
	output [1:0] carryouts;
	
	wire fasum0, fasum1;
	
	
	fa FA0	(fasum0, 		carryouts[0],	fanin[4],	fanin[2], 	fanin [3]);
	fa FA1 	(fasum1,			carryouts[1],	fasum0,		fanin[0], 	fanin[1]);
	fa FA2	(fanout[0], 	fanout[1],		fasum1,	carryins[0], 	carryins [1]);	
	
	
endmodule // weight5


module weight6 (fanin, carryins, fanout, carryouts);

	input [5:0] fanin;
	input [1:0] carryins;
	output [1:0] fanout;
	output [1:0] carryouts;
	
	wire fasum0, fasum1, fasum2, cout2;
	
	
	fa FA0	(fasum0, 		carryouts[0],	fanin[5],	fanin[4], 	fanin [3]);
	fa FA1 	(fasum1,			carryouts[1],	fasum0,		fanin[2], 	fanin[1]);
	fa FA2	(fasum2, 		cout2,			fasum1,		fanin[0], 	carryins [0]);	
	fa FA3	(fanout[0], 	fanout[1],		fasum2,		cout2, 		carryins [1]);	
	
	
endmodule // weight6

module weight7 (fanin, carryins, fanout, carryouts);

	input [6:0] fanin;
	input [1:0] carryins;
	output [1:0] fanout;
	output [1:0] carryouts;
	
	wire fasum0, fasum1, fasum2, fasum3, cout2, cout3;
	
	
	fa FA0	(fasum0, 		carryouts[0],	fanin[6],	fanin[5], 	fanin [4]);
	fa FA1 	(fasum1,			carryouts[1],	fasum0,		fanin[3], 	fanin[2]);
	fa FA2	(fasum2, 		cout2,			fasum1,		fanin[1], 	fanin [0]);	
	fa FA3	(fasum3, 		cout3,			fasum2,		cout2, 		carryins [1]);	
	fa FA4	(fanout[0], 	fanout[1],		fasum3,		cout3, 		carryins [0]);	
	
endmodule // weight7

	
	
	
	
	
	module ha(sum,c_out,x,y);  //half adder
   input x,y;
   output sum,c_out;
   assign {c_out,sum}=x+y;
endmodule // ha






*/


