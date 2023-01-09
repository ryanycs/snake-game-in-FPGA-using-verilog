module timer(
    input clk, rst, game_over,
    output reg[6:0] led_sec_h, led_sec_l, led_min_h, led_min_l  //7段輸出: 秒鐘十位、個位, 分鐘十位、個位
);
reg[5:0] sec = 0, min = 0;
reg [3:0] minh,minl; //BCD 分鐘十位、個位
reg [3:0] sech,secl; //BCD 秒鐘十位、個位,
integer i;

always @(posedge clk, posedge rst) begin
    if(rst)
		begin //reset
			sec <= 0;
			min <= 0;
		end
	else if (game_over)
		begin
			sec <= sec;
			min <= min;
		end
	else if (sec == 6'b111011) //sec == 59
		begin 
			sec <= 6'b000000;
			if (min == 6'b111011) //min == 59
				min <= 6'b000000;
			else 
				min <= min + 1'b1;
		end
	else 
	    sec <= sec + 1'b1;
end

always @(min) begin //將minute的二進制碼轉換成BCD碼
    minh=4'd0;    //並將十位數、個位數保存至minh、minl
    minl=4'd0;
    for(i = 5; i >= 0; i = i - 1) begin	
		if (minh >= 5)
			minh = minh + 3;
		if (minl >= 5)
			minl = minl + 3;
		minh = minh << 1;
		minh[0] = minl[3];
		minl = minl << 1;
		minl[0] = min[i];
	end		
end
	
always @(sec) begin //將second的二進制碼轉換成BCD碼
	sech=4'd0;      //並將十位數、個位數保存至sech、secl
	secl=4'd0;
   for(i=5; i>=0; i=i-1)begin	
		if(sech>=5)
				sech=sech+3;
		if(secl>=5)
				secl=secl+3;
		sech = sech<<1; 
		sech[0] = secl[3];
		secl = secl<<1;
		secl[0]= sec[i];
	end		
end
//BCD轉換成7段
always@(minl or minh) begin // min 
		case(minl)		//低位數的可能值：0~9
				5'd0: led_min_l<=7'b0000001;
				5'd1: led_min_l<=7'b1001111;
				5'd2: led_min_l<=7'b0010010;
				5'd3: led_min_l<=7'b0000110;
				5'd4: led_min_l<=7'b1001100;
				5'd5: led_min_l<=7'b0100100;
				5'd6: led_min_l<=7'b0100000; 
				5'd7: led_min_l<=7'b0001111;
				5'd8: led_min_l<=7'b0000000;
				5'd9: led_min_l<=7'b1111101;
				default: led_min_l<=7'b1111111;
		endcase
		case(minh)     //十位數的可能值：0~6    
				5'd0: led_min_h<=7'b0000001;
				5'd1: led_min_h<=7'b1001111;
				5'd2: led_min_h<=7'b0010010;
				5'd3: led_min_h<=7'b0000110;
				5'd4: led_min_h<=7'b1001100;
				5'd5: led_min_h<=7'b0100100;
				default: led_min_h<=7'b1111111;
		endcase
end
			
always@(secl or sech) begin//sec
		case(secl)		//個位數的可能值：0~9
				5'd0: led_sec_l<=7'b0000001;
				5'd1: led_sec_l<=7'b1001111;
				5'd2: led_sec_l<=7'b0010010;
				5'd3: led_sec_l<=7'b0000110;
				5'd4: led_sec_l<=7'b1001100;
				5'd5: led_sec_l<=7'b0100100;
				5'd6: led_sec_l<=7'b0100000; 
				5'd7: led_sec_l<=7'b0001111;
				5'd8: led_sec_l<=7'b0000000;
				5'd9: led_sec_l<=7'b0000100;
				default: led_sec_l<=7'b1111111;
		endcase
		case(sech)     //十位數的可能值：0~6
		      5'd0: led_sec_h<=7'b0000001;
				5'd1: led_sec_h<=7'b1001111;
				5'd2: led_sec_h<=7'b0010010;
				5'd3: led_sec_h<=7'b0000110;
				5'd4: led_sec_h<=7'b1001100;
				5'd5: led_sec_h<=7'b0100100;
				default: led_sec_h<=7'b1111111;
		endcase
end   
endmodule
