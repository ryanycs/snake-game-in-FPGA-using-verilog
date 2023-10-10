module food_generator(
    output [7:0] led_g [7:0],
    output [2:0] food_x, food_y,
    input [2:0] snake_x [15:0],
    input [2:0] snake_y [15:0],
    input eaten,
    input rst,
    input clk,
    input _1HZ_clk
);
    // food generate sinal
    reg gen;
    reg regenerate;

    // random number
    wire [2:0] rand_x;
    wire [2:0] rand_y;
    wire [2:0] seed;

    // elapsed time of food
    integer elapsed_time;

    random m_random(
        .rand_x(rand_x),
        .rand_y(rand_y),
        .snake_x(snake_x),
        .snake_y(snake_y),
        .seed(seed),
        .clk(clk)
    );

    // generate seed;
    always @(posedge clk) begin
        seed <= seed + 1;
    end

    // food generate sinal
    always @(eaten, regenerate) begin
        gen <= eaten || regenerate ? 1 : 0;
    end

    // get random position of food
    always @(posedge gen, posedge rst) begin
        if (rst) begin
            food_x <= 4;
            food_y <= 4;
        end
        else begin
            food_x <= rand_x;
            food_y <= rand_y;
        end
    end

    // regenerate food if snake doesn't eat the food too long
    always @(posedge _1HZ_clk) begin
        if (elapsed_time >= 9) begin
            elapsed_time <= 0;
            regenerate <= 1;
        end
        else begin
            elapsed_time <= elapsed_time + 1;
            regenerate <= 0;
        end
    end

    // transform food position to 8x8 LED metrix
    always @(food_y, food_x) begin
        for (integer i = 0; i <= 7; i = i + 1) begin
            for (integer j = 0; j <= 7; j = j + 1) begin
                led_g[i][j] <= i == food_y && j == food_x ? 0 : 1;
            end
        end
    end

endmodule
