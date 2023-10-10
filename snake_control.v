module snake_control(
    output [7:0] led_r [7:0],
    output [2:0] snake_x [15:0],
    output [2:0] snake_y [15:0],
    output [3:0] score,
    output [3:0] length,
    output game_over, 
    output eaten,
    input [2:0] food_x, 
    input [2:0] food_y,
    input key_up,
    input key_down,
    input key_left,
    input key_right,
    input clk,
    input rst,
    input system_clk
);

    reg [1:0] direction;

    parameter
        up = 0,
        down = 1,
        left = 2,
        right = 3;

    // direction control
    always @(posedge system_clk, posedge rst) begin
        if (rst)
            direction <= right;
        else if (key_up && direction != down)
            direction <= up;
        else if (key_down && direction != up)
            direction <= down;
        else if (key_left && direction != right)
            direction <= left;
        else if (key_right && direction != left)
            direction <= right;
    end

    // snake head
    always @(posedge clk, posedge rst) begin
        if (rst) begin
                snake_x[0] <= 3;
                snake_y[0] <= 3;
        end
        else
            case (direction)
                up:
                    snake_y[0] <= snake_y[0] - 1;
                down:
                    snake_y[0] <= snake_y[0] + 1;
                left:
                    snake_x[0] <= snake_x[0] - 1;
                right:
                    snake_x[0] <= snake_x[0] + 1;                
            endcase
    end

    // snake body
    always @(posedge clk, posedge rst) begin
        if (rst)
            for (integer i = 1; i <= 15; i = i + 1) begin
                snake_x[i] <= 0;
                snake_y[i] <= 0;
            end
        else
            for (integer i = 1; i <= 15; i = i + 1) begin
                snake_x[i] <= snake_x[i-1];
                snake_y[i] <= snake_y[i-1];
            end
    end

    // eat the food
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            eaten <= 0;
            length <= 0;
        end
        else if (snake_x[0] == food_x && snake_y[0] == food_y && eaten == 0) begin
            eaten <= 1;
            
            if (length == 15)
                length <= length;
            else
                length <= length + 1;
        end
        else
            eaten <= 0;
                
        score = length;
    end

    // game over
    always @(posedge clk, posedge rst) begin
        if (rst) game_over <= 0;
        else begin
            for (integer i = 1; i <= 15; i = i + 1) begin
                if (snake_x[0] == snake_x[i] && snake_y[0] == snake_y[i] && length >= i)
                    game_over <= 1;
            end
        end
    end

    // transform snake position to 8x8 LED metrix
    always @(posedge system_clk) begin
        for (integer i = 0; i <= 7; i = i + 1) begin
            led_r[i] <= 8'b11111111;
        end
        for (integer i = 0; i <= length; i = i + 1) begin
            led_r[snake_y[i]][snake_x[i]] <= 0;
        end
    end

endmodule
