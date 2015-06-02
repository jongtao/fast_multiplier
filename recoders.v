
module recode4(grouping, recoded);
	input [2:0] grouping;
	output reg [2:0] recoded;

	always @(*) begin
		case (grouping)
			0,7: 		recoded = 3'd0;
			1,2:		recoded = 3'd1;
			3:			recoded = 3'd2;
			4:			recoded = -3'd2;
			5,6:		recoded = -3'd1;
			default:	recoded = 3'd0;
		endcase
	end
endmodule


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