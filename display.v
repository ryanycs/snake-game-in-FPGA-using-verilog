module display(
	output [15:0] led,
	output [6:0] seg, // 7_seg
	output [3:0] com_seg,
	output [7:0] color_r, 
	output [7:0] color_g, // 8x8 LED
	output [3:0] com_rgb,
	input [3:0] score,
	input [6:0] led_sec_h,
	input [6:0] led_sec_l,
	input [6:0] led_min_h,
	input [6:0] led_min_l,
	input [7:0] led_r [7:0],
	input [7:0] led_g [7:0],
	input game_over,
	input clk
);

	parameter logic [7:0] x [7:0] = '{
		8'b01111110,
		8'b10111101,
		8'b11011011,
		8'b11100111,
		8'b11100111,
		8'b11011011,
		8'b10111101,
		8'b01111110
	};
	
	// display 8 * 8 LED
	always @(posedge clk) begin
		reg [2:0] cnt;
		
		com_rgb <= {1'b1, cnt};
		if (!game_over)
			for (integer i = 0; i <= 7; i = i + 1) begin
				color_r[i] <= led_r[i][cnt];
				color_g[i] <= led_g[i][cnt];
			end	
		else begin
			color_r <= x[cnt];
			color_g <= 8'b11111111;
		end

		cnt <= cnt + 1;
	end
	
	// display timer
	always @(posedge clk) begin
		reg[1:0] cnt;
		cnt <= cnt + 1;
		
		case (cnt)
		0:	begin
				seg <= led_min_h;
				com_seg <= 4'b0111;
			end
		1:	begin
				seg <= led_min_l;
				com_seg <= 4'b1011;
			end
		2:	begin
				seg <= led_sec_h;
				com_seg <= 4'b1101;
			end
		3:	begin
				seg <= led_sec_l;
				com_seg <= 4'b1110;
			end			
		endcase
	end
	
	// display score
	always @(score) begin
		if (game_over)
			led <= led;
		else 
			case(score)
				0: led <= 16'b0000000000000000;
				1: led <= 16'b1000000000000000;
				2: led <= 16'b1100000000000000;
				3: led <= 16'b1110000000000000;
				4: led <= 16'b1111000000000000;
				5: led <= 16'b1111100000000000;
				6: led <= 16'b1111110000000000;
				7: led <= 16'b1111111000000000;
				8: led <= 16'b1111111100000000;
				9: led <= 16'b1111111110000000;
				10: led <= 16'b1111111111000000;
				11: led <= 16'b1111111111100000;
				12: led <= 16'b1111111111110000;
				13: led <= 16'b1111111111111000;
				14: led <= 16'b1111111111111100;
				15: led <= 16'b1111111111111110;
				default: led <= 16'b1111111111111111;
			endcase
	end

endmodule