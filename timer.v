module timer(
    input clk, rst, game_over,
    output [6:0] led_sec_h, led_sec_l, led_min_h, led_min_l  //7_seg output
);
	reg[5:0] sec = 0, min = 0;
	integer i;

	always @(posedge clk, posedge rst) begin
		if(rst) begin //reset
				sec <= 0;
				min <= 0;
		end
		else if (game_over) begin
			sec <= sec;
			min <= min;
		end
		else if (sec == 59) begin 
			sec <= 0;
			if (min == 59)
				min <= 0;
			else 
				min <= min + 1;
		end
		else 
			sec <= sec + 1;
	end

	// BCD to 7_seg
	always@(min) begin // min 
		case(min % 10)		// units digit: 0~9
			0: led_min_l <= 7'b0000001;
			1: led_min_l <= 7'b1001111;
			2: led_min_l <= 7'b0010010;
			3: led_min_l <= 7'b0000110;
			4: led_min_l <= 7'b1001100;
			5: led_min_l <= 7'b0100100;
			6: led_min_l <= 7'b0100000; 
			7: led_min_l <= 7'b0001111;
			8: led_min_l <= 7'b0000000;
			9: led_min_l <= 7'b0000100;
			default: led_min_l <= 7'b1111111;
		endcase
		case(min / 10)     // tens digit: 0~5
			0: led_min_h <= 7'b0000001;
			1: led_min_h <= 7'b1001111;
			2: led_min_h <= 7'b0010010;
			3: led_min_h <= 7'b0000110;
			4: led_min_h <= 7'b1001100;
			5: led_min_h <= 7'b0100100;
			default: led_min_h <= 7'b1111111;
		endcase
	end
			
	always@(sec) begin//sec
		case(sec % 10)		// units digit: 0~9
			0: led_sec_l <= 7'b0000001;
			1: led_sec_l <= 7'b1001111;
			2: led_sec_l <= 7'b0010010;
			3: led_sec_l <= 7'b0000110;
			4: led_sec_l <= 7'b1001100;
			5: led_sec_l <= 7'b0100100;
			6: led_sec_l <= 7 'b0100000; 
			7: led_sec_l <= 7'b0001111;
			8: led_sec_l <= 7'b0000000;
			9: led_sec_l <= 7'b0000100;
			default: led_sec_l<=7'b1111111;
		endcase
		case(sec / 10)     // tens digit: 0~5
			0: led_sec_h <= 7'b0000001;
			1: led_sec_h <= 7'b1001111;
			2: led_sec_h <= 7'b0010010;
			3: led_sec_h <= 7'b0000110;
			4: led_sec_h <= 7'b1001100;
			5: led_sec_h <= 7'b0100100;
			default: led_sec_h <= 7'b1111111;
		endcase
	end

endmodule
