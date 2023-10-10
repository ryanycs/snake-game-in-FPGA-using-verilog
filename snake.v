module snake(
    output [15:0] led,
    output [6:0] seg, // 7_seg
    output [3:0] com_seg,
    output [7:0] color_r, color_g, // 8x8 LED
    output [3:0] com_rgb,
    input key_up,
    input key_down,
    input key_left,
    input key_right,
    input clk, rst
);
    // position of food
    wire [2:0] food_x;
    wire [2:0] food_y;

    // position of snake (max length of snake is 16)
    wire [2:0] snake_x [15:0];
    wire [2:0] snake_y [15:0];

    // length of snake
    wire [3:0] length;

    // sinal of game
    wire game_over;
    wire eaten;
    wire [3:0] score;

    // 8*8 LED metrix
    wire [7:0] led_r [7:0];
    wire [7:0] led_g [7:0];

    // 7_seg sinal
    wire [6:0] led_sec_h;
    wire [6:0] led_sec_l;
    wire [6:0] led_min_h;
    wire [6:0] led_min_l;

    // clock
    wire game_clk, system_clk, display_clk, _1HZ_clk;

    clock_generator game_clock(
        .gen_clk(game_clk),
        .clk(clk),
        .cnt_max(6250000)
    );

    clock_generator system_clock(
        .gen_clk(system_clk),
        .clk(clk),
        .cnt_max(2500)
    );

    clock_generator display_clock(
        .gen_clk(display_clk),
        .clk(clk),
        .cnt_max(25000)
    );

    clock_generator _1HZ_clock(
        .gen_clk(_1HZ_clk),
        .clk(clk),
        .cnt_max(25000000)
    );

    snake_control m_snake_control(
        .led_r(led_r),
        .game_over(game_over),
        .score(score),
        .snake_x(snake_x),
        .snake_y(snake_y),
        .length(length),
        .eaten(eaten),
        .food_x(food_x),
        .food_y(food_y),
        .key_up(key_up),
        .key_down(key_down),
        .key_left(key_left),
        .key_right(key_right),
        .rst(rst),
        .clk(game_clk),
        .system_clk(system_clk)
    );


    food_generator m_food_generator(
        .led_g(led_g),
        .food_x(food_x),
        .food_y(food_y),
        .snake_x(snake_x),
        .snake_y(snake_y),
        .eaten(eaten),
        .rst(rst),
        .clk(system_clk),
        ._1HZ_clk(_1HZ_clk)
    );
                                
    timer m_timer(
        .clk(_1HZ_clk),
        .rst(rst),
        .game_over(game_over),
        .led_sec_h(led_sec_h),
        .led_sec_l(led_sec_l),
        .led_min_h(led_min_h),
        .led_min_l(led_min_l)
    );

    display m_display(
        .led(led),
        .seg(seg),
        .com_seg(com_seg),
        .color_r(color_r),
        .color_g(color_g),
        .com_rgb(com_rgb),
        .score(score),
        .led_sec_h(led_sec_h),
        .led_sec_l(led_sec_l),
        .led_min_h(led_min_h),
        .led_min_l(led_min_l),
        .led_r(led_r),
        .led_g(led_g),
        .game_over(game_over),
        .clk(display_clk)
    );
endmodule
