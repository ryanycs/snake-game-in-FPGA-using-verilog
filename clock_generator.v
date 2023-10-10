module clock_generator(
    output gen_clk,
    input clk,
    input integer cnt_max
);
    integer cnt;

    initial cnt = 0;

    always @(posedge clk) begin
        if (cnt >= cnt_max)
            begin
                cnt <= 0;
                gen_clk <= ~gen_clk;
            end
        else
            cnt <= cnt + 1;
    end

endmodule
