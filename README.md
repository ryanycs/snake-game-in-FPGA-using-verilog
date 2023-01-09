# snake-game-in-FPGA-using-verilog
使用 verilog 製作在 FPGA 上的貪食蛇遊戲

---
## 遊戲說明
利用四個按鍵控制 snake 的移動，每當 snake 吃到食物時身體便會增長，如果 snake 碰到自己的身體遊戲則會結束
每經過一段時間如果食物還沒被吃掉則會在地圖上重新生成一個食物

---
## module 功能介紹
這個 project 由六個 module 組成，分別為
1. clock_generator
2. snake_contr0l
3. food_generator
4. random
5. timmer
6. display

以下是各個 module 的功能

### clock_generator
* 用來產生遊戲所需要的各種 clock，包括蛇的速度、偵測按鍵、計時以及顯示所需時脈

### snake_control
* 裡面包含了方向控制、蛇頭與身體的移動、吃到食物變長與死亡的判定

### food_generator
* 透過 random module 產生的亂數來決定生成食物的座標產生食物

### random
* 利用傳入的參數 seed 以及 snake 身體的座標來產生亂數

### timer
* 計時器

### display
* 負責將蛇和食物的座標顯示到 8*8 LED metrix 上以及在七段顯示器和 LED 上顯示經過時間與分數
