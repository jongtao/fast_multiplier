module controller(clock, reset, mode, done, product);
	input clock, reset;
	input [1:0] mode;
	output reg done;
	output reg [127:0] product;

	// RAM 32x64
	reg [63:0] bank [31:0];
	reg [7:0] A_addr, B_addr;
	
	// buffers
	reg[31:0] A_32, B_32;
	reg[47:0] A_48, B_48;
	reg[63:0] A_64, B_64;
	
	wire[63:0] P_32;
	wire[95:0] P_48;
	wire[127:0] P_64;
/*
	// States of FSM
	reg [1:0] state, next;

	localparam
		S0 = 2'h0,
		S1 = 2'h1;
*/		
	localparam
		M1 = 2'h0,
		M2 = 2'h1,
		M3 = 2'h2,
		M4 = 2'h3;
		
	always @(A_addr) B_addr = A_addr + 1;

	// Clock and Reset Synchonizing
	always @(posedge clock, negedge reset) begin
		if(!reset) begin
			//state <= S0;
			A_addr <= 8'd0;
			done <= 1'b0;
		end
		else begin
			//state <= next;
			A_addr <= (A_addr == 31)? A_addr <= 8'd0: (A_addr + 2);
			done <= 1'b1;
		end
	end
	
	/*
	// Next state
	always @(state) begin
		if(state == S0) next = S1;
		else if(state == S1) next = S0;
	end
	*/
	
	// load inputs
	always @(posedge clock)
		case(mode)
			M1, M2: begin
				A_32 <= bank[A_addr][31:0];
				B_32 <= bank[B_addr][31:0];
			end
			M3: begin
				A_32 <= bank[A_addr][47:0];
				B_32 <= bank[B_addr][47:0];
			end
			M4: begin
				A_64 <= bank[A_addr];
				B_64 <= bank[B_addr];
			end
		endcase


	// load output
	always @(mode, P_32, P_48, P_64)
		case(mode)
			M1, M2: product = P_32;
			M3: product = P_48;
			M4: product = P_64;
		endcase

		
		
	initial $readmemh("memory.list", bank); // initialize memory

	
	
	dummy_32 m32(P_32, A_32, B_32);
	dummy_48 m48(P_48, A_48, B_48);
	dummy_64 m64(P_64, A_64, B_64);
		
endmodule // controller


module dummy_32(
	output [63:0] product,
	input [31:0] A, B
	);
	
	assign product = A * B;
endmodule


module dummy_48(
	output [95:0] product,
	input [47:0] A, B
	);
	
	assign product = A * B;
endmodule


module dummy_64(
	output [127:0] product,
	input [63:0] A, B
	);
	
	assign product = A * B;
endmodule