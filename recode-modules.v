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
	

module recode16(grouping, recoded);
input [4:0] grouping;
output reg [4:0] recoded;

always @(*) begin

case (grouping)
	0,31: 	recoded = 5'd0;
	1,2:		recoded = 5'd1;
	3,4: 		recoded = 5'd2;
	5,6: 		recoded = 5'd3;
	7,8:		recoded = 5'd4;
	9,10:		recoded = 5'd5;
	11,12:	recoded = 5'd6;
	13,14:	recoded = 5'd7;
	15:		recoded = 5'd8;
	16:		recoded = -5'd8;
	17,18:	recoded = -5'd7;
	19,20:	recoded = -5'd6;
	21,22: 	recoded = -5'd5;
	23,24:	recoded = -5'd4;
	25,26:	recoded = -5'd3;
	27,28:	recoded = -5'd2;
	29,30:	recoded = -5'd1;
	default:	recoded = 5'd0;
	
endcase
end
	
endmodule

	
	
	
	
	
	
	
	
	
	
	
	