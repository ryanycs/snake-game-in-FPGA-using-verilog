# snake-game-in-FPGA-using-verilog

## About the Project
This is a snake game using verilog

### Fectures
* The snake will grow longer when eating the food
* when snake eats the food, food will regenerate at random position (maybe overlap with snake)
* The food will be regenerated if the snake doesn't eat the food too long
* If the snake head touch its body, GAME OVER !
* show gaming time on 7 segment display
* show the score on LED

## Usage
Use 4-bit switch to control the snake

use 8 dip switch to reset the game

## Pins Setting
| To        | Value    |
| --------- | -------- |
key_down	|	PIN_65
key_left	|	PIN_64
key_right	|	PIN_67
key_up	    |	PIN_66
clk	        |	PIN_22
rst	        |	PIN_72
color_r[0]	|	PIN_98
color_r[1]	|	PIN_99
color_r[2]	|	PIN_100
color_r[3]	|	PIN_103
color_r[4]	|	PIN_104
color_r[5]	|	PIN_105
color_r[6]	|	PIN_106
color_r[7]	|	PIN_110
color_g[0]	|	PIN_111
color_g[1]	|	PIN_112
color_g[2]	|	PIN_113
color_g[3]	|	PIN_114
color_g[4]	|	PIN_115
color_g[5]	|	PIN_119
color_g[6]	|	PIN_120
color_g[7]	|	PIN_121
com_rgb[0]	|	PIN_68
com_rgb[1]	|	PIN_69
com_rgb[2]	|	PIN_70
com_rgb[3]	|	PIN_71|
led[0]	    |	PIN_144
led[1]	    |	PIN_143
led[2]	    |	PIN_142
led[3]	    |	PIN_141
led[4]	    |	PIN_138
led[5]	    |	PIN_137
led[6]	    |	PIN_136
led[7]	    |	PIN_135
led[8]	    |	PIN_50
led[9]	    |	PIN_49
led[10]	    |	PIN_46
led[11]	    |	PIN_44
led[12]	    |	PIN_43
led[13]	    |   PIN_42
led[14]	    |	PIN_39
led[15]	    |	PIN_38
seg[0]	    |	PIN_59
seg[1]	    |	PIN_58
seg[2]	    |	PIN_55
seg[3]	    |	PIN_54
seg[4]	    |	PIN_53
seg[5]	    |	PIN_52
seg[6]	    |	PIN_51
com_seg[0]	|	PIN_76
com_seg[1]	|	PIN_75
com_seg[2]	|	PIN_74
com_seg[3]	|	PIN_73
