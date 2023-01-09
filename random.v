module random(
	output [2:0] rand_x, rand_y,
	input [2:0] snake_x [15:0],
	input [2:0] snake_y [15:0],
	input [2:0] seed,
	input clk
);

	always @(posedge clk) begin
		rand_x[0] <= seed[0] ^ snake_x[0][0] ^ snake_x[1][0] ^ snake_y[2][0] ^ snake_x[3][0];
		rand_x[1] <= seed[2] ^ snake_y[0][2] ^ snake_x[1][2];
		rand_x[2] <= seed[1] ^ snake_x[0][1] ^ snake_x[1][1] ^ snake_x[2][1] ^ snake_y[3][1];
		
		rand_y[0] <= seed[1] ^ snake_y[0][1] ^ snake_x[1][1];
		rand_y[1] <= seed[0] ^ snake_x[0][0] ^ snake_x[1][0] ^ snake_x[2][0] ^ snake_y[3][0];
		rand_y[2] <= seed[2] ^ snake_x[0][2] ^ snake_y[1][2];
	end

endmodule
