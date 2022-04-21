# Verilog代码汇总

- [Verilog代码汇总](#verilog代码汇总)
- [xorgate](#xorgate)
- [1位4选1多路选择器](#1位4选1多路选择器)
- [数字钟设计](#数字钟设计)
  - [内容](#内容)
  - [设计思路](#设计思路)
- [单端口RAM](#单端口ram)
  - [内容](#内容-1)
  - [设计思路](#设计思路-1)
  - [单端口同步RAM](#单端口同步ram)
  - [单端口异步RAM](#单端口异步ram)
- [双端口RAM](#双端口ram)
  - [内容](#内容-2)
  - [设计思路](#设计思路-2)
  - [双端口同步RAM](#双端口同步ram)
  - [双端口异步RAM](#双端口异步ram)
- [FIFO](#fifo)
  - [内容](#内容-3)
  - [设计思路](#设计思路-3)

自己整理的verilog文件，方便后续查看。

因个人技术力低下，可能会出现错误，可以通过邮箱和我交流：jiaming_li@cqu.edu.cn

使用vivado软件进行编写，更改[文件编辑器为VSC](https://blog.csdn.net/rebortt/article/details/111401979)，[安装格式化插件verilog-format](https://github.com/ericsonj/verilog-format)

# xorgate

代码传送门：https://github.com/Geaming-CHN/Vivado/tree/main/_Digital%20logic/gates/xorgate

异或门的verilog实现：

​	熟悉大概格式

`xorgate.v`

```verilog
module xorgate
#(parameter WIDTH = 8)
    (
    input[(WIDTH-1):0] a,
    input[(WIDTH-1):0] b,
    output[(WIDTH-1):0] c
    );
    assign c = a^b;
endmodule
```

# 1位4选1多路选择器

代码传送门：https://github.com/Geaming-CHN/Vivado/tree/main/_Digital%20logic/Project3

逻辑表达式

$\large e=a\bar{S_2}\bar{S_1}+b\bar{S_2}{S_1}+c{S_2}\bar{S_1}+d{S_2}{S_1}$

手绘电路图如下：

![image-20220421194041779](https://cdn.jsdelivr.net/gh/GEAMING-CHN/images/blogimg/%E6%9D%82%E9%A1%B9/image-20220421194041779.png)

源代码文件：

采用`assign`

```verilog
module design_1
    (
    input [0:0] a,
    input [0:0] b,
    input [0:0] c,
    input [0:0] d,
    input [0:0] S1,
    input [0:0] S2,

    output [0:0] e
    );
    assign e = a&(~S2)&(~S1)|b&(~S2)&(S1)|c&(S2)&(~S1)|d&(S2)&(S1);
endmodule
```

采用`always`

```verilog
module design_1
    (
    input [2:0]a,
    input [2:0]b,
    input [2:0]c,
    input [2:0]d,
    input [1:0]S,
    output reg[2:0]e
    );
    always @(a,b,c,d,S) 
    begin
        case(S[1:0])
            2'b00: e = a;      
            2'b01: e = b;
            2'b10: e = c;
            2'b11: e = d;
            default:e = 2'b00;  
        endcase
    end
endmodule
```

仿真文件：

```verilog
module design_1_sim_2();
    parameter size = 10000;
    reg a          = 0;
    reg b          = 0;
    reg c          = 0;
    reg d          = 0;
    reg S1         = 0;
    reg S2         = 0;
    wire e;
    design_1 u(.a(a),.b(b),.c(c),.d(d),.S1(S1),.S2(S2),.e(e));
    initial begin
        a  = 'd0;
        b  = 'd0;
        c  = 'd0;
        d  = 'd0;
        S1 = 'd0;
        S2 = 'd0;
        repeat(size)
        begin
            #10
            a  = $random;
            b  = $random;
            c  = $random;
            d  = $random;
            S1 = $random;
            S2 = $random;
        end
    end
endmodule
```

# 数字钟设计

代码传送门：https://github.com/Geaming-CHN/Vivado/tree/main/_Digital%20logic/project7

代码当时没有分模块写，所以一个代码给完了。

## 内容

实现一个六十进制数字时钟，秒到60则归零重加，同时让分加1，分加到60归零重加，并让小时加1，小时加到24归零重加。

## 设计思路

首先将整个实验分成三大部分，一是**分频模块**，二是**计数模块**，三是**显示模块**。

**分频：**

- 因为代码中的时钟信号clk频率过高，与数字时钟的要求不匹配。在代码中采用设置parameter分频获得clk2，计数时以clk2为时钟信号进行计算。

**计数：**

- 计数模块钟分别设计一个60进制和24进制的计数器，用来计算时分秒及其进位。为方便显示模块使用，
- 将秒拆分为Second_2,Second_1；
- 将分拆分为Minute_2,Minute_1；
- 将时拆分为Hour_2,Hour_1；
- 则Second_1,Minute_1为十进制计数器，Second_2,Minute_2为六进制计数器，Hour_2为3进制计数器，Hour_1为10进制计数器（最后为5进制计数器，特殊情况：23:59:59）

**显示：**

使用七段数码管进行显示。

其中**低电平为有效**。为了实现4个数码管显示不同内容，利用人眼的视觉暂留，对4个气短数码管进行分时复用。当数码管的刷新频率高于人眼的视觉暂留时，人眼就无法察觉数码管信息的改变。

`reg[10:0] display`

使用11位的display对数码管进行输出，前4位为使能端，后七位与七段数码管相对应。

- Hour_1为10进制计数器（最后为5进制计数器，特殊情况：23:59:59）

![img](https://cdn.jsdelivr.net/gh/GEAMING-CHN/images/blogimg/%E6%9D%82%E9%A1%B9/clip_image002.jpg)

```verilog
module clock(
    input clk,rst,second_select,
    output reg[10:0] display
    );
    reg[3:0] Hour_2,Hour_1,Minute_2,Minute_1,Second_2,Second_1;
    reg[26:0] count = 0;
    reg[15:0] count2 = 0;
    reg[2:0] sel = 0;
    parameter T = 10000000;
    parameter T2 = 50000;
    reg clk2 = 1'b0;
    //时间
    always @(posedge clk) begin
        if(rst)
            count<='b0;
        else if(count == T)
        begin
            clk2 <= ~clk2;
            count <= 0;
        end
        else count <= count + 'b1;
    end
    //Second_1 % 10
    always @(posedge clk2) begin
        //rst
        if(rst)
            Second_1 <= 4'b0000;
        //进位
        else if(Second_1==4'b1001)
            Second_1 <= 4'b0000;
        else
            Second_1 <= Second_1 + 4'b0001;
    end
    //Second_2 % 6
    always @(posedge clk2) begin
        //rst
        if(rst)
            Second_2 <= 4'b0000;
        //进位
        else if(Second_1==4'b1001)//Second_1进位
            begin
                if(Second_2 == 4'b0101)//Second_2==5
                    Second_2<=4'b0000;
                else
                    Second_2<=Second_2+4'b0001;
            end
    end
    //Minute_1 % 10
    always @(posedge clk2) begin
        if(rst)
            Minute_1 <= 4'b0000;
        else if(Second_2 == 4'b0101&&Second_1==4'b1001)
            begin
                if(Minute_1==4'b1001)
                    Minute_1 <= 4'b0000;
                else
                    Minute_1 <= Minute_1+4'b0001;
            end
    end
    //Minute_2 % 6
    always @(posedge clk2) begin
        if(rst)
            Minute_2 <= 4'b0000;
        else if(Second_2 == 4'b0101&&Second_1==4'b1001)
            begin
                if(Minute_1==4'b1001)
                begin
                    if(Minute_2==4'b0101)
                        Minute_2<=4'b0000;
                    else
                        Minute_2 <= Minute_2+4'b0001;
                end
            end
    end
    //Hour_1 % 10 最后为4
    always @(posedge clk2) begin
        if(rst)
            Hour_1 <= 4'b0000;
        else if(Second_2 == 4'b0101&&Second_1==4'b1001&&Minute_2==4'b0101&&Minute_1==4'b1001)
            begin
                if(Hour_2==4'b0010&&Hour_1==4'b0011)//23:59:59
                    Hour_1 <= 4'b0000;
                else if(Hour_1 == 4'b1001)
                    Hour_1 <= 4'b0000;
                else
                    Hour_1 <= Hour_1 + 4'b0001;
            end
    end
    //Hour_2 % 3
    always @(posedge clk2) begin
        if(rst)
            Hour_2 <= 4'b0000;
        else if(Second_2 == 4'b0101&&Second_1==4'b1001&&Minute_2==4'b0101&&Minute_1==4'b1001)
            begin
                if(Hour_2==4'b0010&&Hour_1==4'b0011)//23:59:59
                    Hour_2 <= 4'b0000;
                else if(Hour_1 == 4'b1001)
                    Hour_2 <= Hour_2+4'b0001;
            end
    end
    //显示
    always @(posedge clk) begin
        if(rst)
            count2<='b0;
        else if(count2==T2)
            begin
                count2<=0;
                sel<=sel+1;
                if(sel==4)
                    sel<=0;
            end        
        else
            count2 <=count2+1;
    end
    always @(posedge clk) begin
        //显示秒
        if(second_select)
            begin
                case(sel)
                //Second_1 0~9
                0,1: begin
                    case(Second_1)
                        4'b0000:display = 11'b1110_0000001;
                        4'b0001:display = 11'b1110_1001111;
                        4'b0010:display = 11'b1110_0010010;
                        4'b0011:display = 11'b1110_0000110;
                        4'b0100:display = 11'b1110_1001100;
                        4'b0101:display = 11'b1110_0100100;
                        4'b0110:display = 11'b1110_0100000;
                        4'b0111:display = 11'b1110_0001111;
                        4'b1000:display = 11'b1110_0000000;
                        4'b1001:display = 11'b1110_0000100;
                    endcase
                end
                //Second_2 0~5
                2,3:begin
                    case(Second_2)
                        4'b0000:display = 11'b1101_0000001;
                        4'b0001:display = 11'b1101_1001111;
                        4'b0010:display = 11'b1101_0010010;
                        4'b0011:display = 11'b1101_0000110;
                        4'b0100:display = 11'b1101_1001100;
                        4'b0101:display = 11'b1101_0100100;
                    endcase
                end
                endcase
            end
        //显示小时和分钟
        else
            begin
                case(sel)
                //Minute_1 0~9
                0:begin
                    case(Minute_1)
                        4'b0000:display = 11'b1110_0000001;
                        4'b0001:display = 11'b1110_1001111;
                        4'b0010:display = 11'b1110_0010010;
                        4'b0011:display = 11'b1110_0000110;
                        4'b0100:display = 11'b1110_1001100;
                        4'b0101:display = 11'b1110_0100100;
                        4'b0110:display = 11'b1110_0100000;
                        4'b0111:display = 11'b1110_0001111;
                        4'b1000:display = 11'b1110_0000000;
                        4'b1001:display = 11'b1110_0000100;
                    endcase
                end
                //Minute_2 0~5
                1:begin
                    case(Minute_2)
                        4'b0000:display = 11'b1101_0000001;
                        4'b0001:display = 11'b1101_1001111;
                        4'b0010:display = 11'b1101_0010010;
                        4'b0011:display = 11'b1101_0000110;
                        4'b0100:display = 11'b1101_1001100;
                        4'b0101:display = 11'b1101_0100100;
                    endcase
                end
                //Hour_1 0~9
                2:begin
                    case(Hour_1)
                        4'b0000:display = 11'b1011_0000001;
                        4'b0001:display = 11'b1011_1001111;
                        4'b0010:display = 11'b1011_0010010;
                        4'b0011:display = 11'b1011_0000110;
                        4'b0100:display = 11'b1011_1001100;
                        4'b0101:display = 11'b1011_0100100;
                        4'b0110:display = 11'b1011_0100000;
                        4'b0111:display = 11'b1011_0001111;
                        4'b1000:display = 11'b1011_0000000;
                        4'b1001:display = 11'b1011_0000100;
                    endcase
                end
                //Hour_2
                3:begin
                    case(Hour_2)
                        4'b0000:display = 11'b0111_0000001;
                        4'b0001:display = 11'b0111_1001111;
                        4'b0010:display = 11'b0111_0010010;
                    endcase
                end
                endcase
            end
    end
endmodule
```

# 单端口RAM

代码传送门：https://github.com/Geaming-CHN/Vivado/tree/main/_Digital%20logic/Project14

## 内容

利用BASYS3片内存储器单元实现单端口RAM设计（带异步读和同步读两种模式），在时钟（clk）上升沿，采集地址addr）、输入数据data_in）、执行相关控制信息。当写使能（we）有效，则执行写操作，否则执行读取操作。同步与异步设计仅针对读操作：对于异步RAM而言，读操作为异步，即地址信号有效时，控制器直接读取RAM阵列；对于同步RAM而言，地址信号在时钟上升沿被采集。并保存在寄存器中，然后使用该地址信号读取RAM阵列。

## 设计思路

单端口RAM设计（带异步读和同步读两种模式），在时钟（clk）上沿采集地址（addr）、输入数据data_in）、执行相关控制信息。当写使能we有效，则执行写操作，否则执行读取操作。同步与异步设计仅针对读操作：对于异步RAM而言，读操作为异步，即地址信号有效时，控制器直接读取RAM阵列；对于同步RAM而言，地址信号在时钟上升沿被采集并保存在寄存器中，然后使用该地址信号读取RAM阵列。（额外添加了读使能oe）

<img src="https://cdn.jsdelivr.net/gh/GEAMING-CHN/images/blogimg/%E6%9D%82%E9%A1%B9/image-20220421220041632.png" alt="image-20220421220041632" style="zoom:100%;" />

## 单端口同步RAM

- 顶层模块

  ![image-20220421220150561](https://cdn.jsdelivr.net/gh/GEAMING-CHN/images/blogimg/%E6%9D%82%E9%A1%B9/image-20220421220150561.png)

  

- divider：为七段数码管提供分频后的clk；
- Syn_SinglePortRAM：单端口同步RAM；
- transformer：移位加三法，输入至七段数码管进行显示功能的实现；
- display7seg：七段数码管显示模块；

`top_Syn_SinglePortRAM`

```verilog
module top_Syn_SinglePortRAM#(parameter DATA_WIDTH = 4,parameter ADDR_DEPTH = 4)(
    input clk,rst,
    input [ADDR_DEPTH-1:0]addr,
    input [DATA_WIDTH-1:0]data_in,
    input we,oe,
    output wire[3:0]an,
    output wire[6:0]display
    );
    wire[DATA_WIDTH-1:0]data_out;
    wire clk_div;
    reg [25:0]target = 50000;
    wire [15:0]BCD;
    //divider
    divider d(.clk(clk),.rst(rst),.target(target),.clk_div(clk_div));
    //Syn_SinglePortRAM
    Syn_SinglePortRAM S(.clk(clk),.rst(rst),.addr(addr),.data_in(data_in),.we(we),.oe(oe),.data_out(data_out));
    //transformer
    transformer t(.data(data_out),.BCD(BCD));
    //display7seg
    display7seg dis(.clk(clk_div),.data3(BCD[15:12]),.data2(BCD[11:8]),.data1(BCD[7:4]),.data0(BCD[3:0]),.an(an),.display(display));
endmodule
```

`divider`

```verilog
module divider(
    input clk,rst,
    input [15:0] target,
    output reg clk_div
    );
    reg [15:0] counter;
    always @(posedge clk) begin
        if(rst)
        begin
            counter <= 0;
            clk_div <= 0;
        end
        else if(counter==target)
        begin
            counter <= 0;
            clk_div <= ~clk_div;
        end
        else 
            counter <= counter+1;
    end
endmodule
```

`Syn_SinglePortRAM`

```verilog
module Syn_SinglePortRAM#(parameter DATA_WIDTH = 4,parameter ADDR_DEPTH = 4)(
    input clk,rst,
    input [ADDR_DEPTH-1:0]addr,
    input [DATA_WIDTH-1:0]data_in,
    input we,
    input oe,
    output reg[DATA_WIDTH-1:0]data_out
    );
    reg [DATA_WIDTH-1:0] RAM[(1<<ADDR_DEPTH)-1:0];
    //write
    always @(posedge clk) 
    begin
        if(rst)
        begin:init_RAM
            integer i;//必须声明在有名字的块中，或写在外面
            for(i=0;i<(1<<ADDR_DEPTH);i = i+1)
            begin
                RAM[i] <= 0;
            end
        end
        else if(we)
        begin
            RAM[addr] <= data_in;
        end
    end
    //syn_read
    always @(posedge clk) begin
        if(rst)
        begin
            data_out <= 0;
        end
        else if(!we && oe)
        begin 
            data_out <= RAM[addr];
        end
        else
            data_out <= 0;
    end
endmodule
```

`transformer`

```verilog
module transformer(
    input [3:0] data,
    output [15:0]BCD//四位，方便输入至数码管
    );
    //移位加3，转换成BCD
    reg [19:0] transfor_data;
    always @(*) 
    begin
        transfor_data = 16'b0;
        transfor_data[3:0] = data;
        repeat(4)
        begin
            if(transfor_data[19:16]>4)
                transfor_data[19:16] = transfor_data[19:16]+2'b11;
            if(transfor_data[15:12]>4)
                transfor_data[15:12] = transfor_data[15:12]+2'b11;
            if(transfor_data[11:8]>4)
                transfor_data[11:8] = transfor_data[11:8]+2'b11; 
            if(transfor_data[7:4]>4)     
                transfor_data[7:4] = transfor_data[7:4]+2'b11;      
            transfor_data[19:1] = transfor_data[18:0];
        end
    end
    assign BCD = transfor_data[19:4];
endmodule
```

`display7seg`

```verilog
module display7seg(
    input clk,
    input [3:0]data3,data2,data1,data0,
    output reg[3:0]an,
    output reg[6:0]display
    );
    reg [1:0] count;
    always @(posedge clk) begin
        if(count == 'b11)
            count <= 0;
        else
            count <= count +'b1;
    end
    always @(posedge clk) begin
        case(count)
        2'b00: an <= 4'b1110;
        2'b01: an <= 4'b1101;
        2'b10: an <= 4'b1011;
        2'b11: an <= 4'b0111;
        endcase
    end
    always @(posedge clk) begin
        case(count)
            2'b00:
            case (data0)
                4'b0000:display = 7'b0000001;
                4'b0001:display = 7'b1001111;
                4'b0010:display = 7'b0010010;
                4'b0011:display = 7'b0000110;
                4'b0100:display = 7'b1001100;
                4'b0101:display = 7'b0100100;
                4'b0110:display = 7'b0100000;
                4'b0111:display = 7'b0001111;
                4'b1000:display = 7'b0000000;
                4'b1001:display = 7'b0000100;    
            endcase
            2'b01:
            case (data1)
                4'b0000:display = 7'b0000001;
                4'b0001:display = 7'b1001111;
                4'b0010:display = 7'b0010010;
                4'b0011:display = 7'b0000110;
                4'b0100:display = 7'b1001100;
                4'b0101:display = 7'b0100100;
                4'b0110:display = 7'b0100000;
                4'b0111:display = 7'b0001111;
                4'b1000:display = 7'b0000000;
                4'b1001:display = 7'b0000100;    
            endcase
            2'b10:
            case (data2)
                4'b0000:display = 7'b0000001;
                4'b0001:display = 7'b1001111;
                4'b0010:display = 7'b0010010;
                4'b0011:display = 7'b0000110;
                4'b0100:display = 7'b1001100;
                4'b0101:display = 7'b0100100;
                4'b0110:display = 7'b0100000;
                4'b0111:display = 7'b0001111;
                4'b1000:display = 7'b0000000;
                4'b1001:display = 7'b0000100;    
            endcase
            2'b11:
            case (data3)
                4'b0000:display = 7'b0000001;
                4'b0001:display = 7'b1001111;
                4'b0010:display = 7'b0010010;
                4'b0011:display = 7'b0000110;
                4'b0100:display = 7'b1001100;
                4'b0101:display = 7'b0100100;
                4'b0110:display = 7'b0100000;
                4'b0111:display = 7'b0001111;
                4'b1000:display = 7'b0000000;
                4'b1001:display = 7'b0000100;    
            endcase
        endcase
    end
endmodule
```

## 单端口异步RAM

- 顶层模块

![image-20220421220247508](https://cdn.jsdelivr.net/gh/GEAMING-CHN/images/blogimg/%E6%9D%82%E9%A1%B9/image-20220421220247508.png)

- Asy_SinglePortRAM：单端口异步RAM；
- 其余模块功能同上；

`top_Asy_SinglePortRAM`

```verilog
module top_Asy_SinglePortRAM#(parameter DATA_WIDTH = 4,
                              parameter ADDR_DEPTH = 4)
                            (input clk,
                              rst,
                              input [ADDR_DEPTH-1:0]addr,
                              input [DATA_WIDTH-1:0]data_in,
                              input we,
                              oe,
                              output wire[3:0]an,
                              output wire[6:0]display);
    wire[DATA_WIDTH-1:0]data_out;
    wire clk_div;
    reg [25:0]target = 50000;
    wire [15:0]BCD;
    //divider
    divider d(.clk(clk),.rst(rst),.target(target),.clk_div(clk_div));
    //Syn_SinglePortRAM
    Asy_SinglePortRAM S(.clk(clk),.rst(rst),.addr(addr),.data_in(data_in),.we(we),.oe(oe),.data_out(data_out));
    //transformer
    transformer t(.data(data_out),.BCD(BCD));
    //display7seg
    display7seg dis(.clk(clk_div),.data3(BCD[15:12]),.data2(BCD[11:8]),.data1(BCD[7:4]),.data0(BCD[3:0]),.an(an),.display(display));
endmodule
```

`Asy_SinglePortRAM`

```verilog
module Asy_SinglePortRAM#(parameter DATA_WIDTH = 4,parameter ADDR_DEPTH = 4)(
    input clk,rst,
    input [ADDR_DEPTH-1:0]addr,
    input [DATA_WIDTH-1:0]data_in,
    input we,oe,
    output reg[DATA_WIDTH-1:0]data_out
    );
    reg [DATA_WIDTH-1:0] RAM[(1<<ADDR_DEPTH)-1:0];
    //write
    always @(posedge clk) 
    begin
        if(rst)
        begin:init_RAM
            integer i;//必须声明在有名字的块中，或写在外面
            for(i=0;i<(1<<ADDR_DEPTH);i = i+1)
            begin
                RAM[i] <= 0;
            end
        end
        else if(we)
        begin
            RAM[addr] <= data_in;
        end
    end
    //read
    //asy
    always @(addr) 
    begin
        if(!we && oe)
            data_out = RAM[addr];
        else
        begin
            data_out = 0;
        end
    end
endmodule
```

# 双端口RAM

代码传送门：https://github.com/Geaming-CHN/Vivado/tree/main/_Digital%20logic/Project14

## 内容

实现双端口（同步与异步）RAM设计，相对于单端口RAM而言，双端口RAM存在两个存取端口，并且可独立进行读写操作，具有自己的地址（addr_a、addr_b）、数据输入din_a、din_b输出端口（dout_a、dout_b以及控制信号。

## 设计思路

双端口（同步与异步）RAM，相对于单端口RAM而言，双端口RAM存在两个存取端口，并且可独立进行读写操作，具有自己的地址（addr_a、addr_b）、数据输入（din_a、din_b）/输出端口（dout_a、dout_b）以及控制信号。双端口RAM常用于视频/图像处理设计中。（额外添加了读使能oe_a，oe_b）

![image-20220421220346608](https://cdn.jsdelivr.net/gh/GEAMING-CHN/images/blogimg/%E6%9D%82%E9%A1%B9/image-20220421220346608.png)

## 双端口同步RAM

- 顶层模块：

![image-20220421220423865](https://cdn.jsdelivr.net/gh/GEAMING-CHN/images/blogimg/%E6%9D%82%E9%A1%B9/image-20220421220423865.png)

- Syn_DoublePortRAM：双端口同步RAM；
- 其余模块功能同上

`top_Syn_DoublePortRAM`

```verilog
module top_Syn_DoublePortRAM#(parameter DATA_WIDTH = 4,
                              parameter ADDR_DEPTH = 3)
                            (input clk,
                              rst,
                              input [ADDR_DEPTH-1:0]addr_a,
                              addr_b,
                              input [DATA_WIDTH-1:0]din_a,
                              din_b,
                              input we_a,
                              we_b,
                              input oe_a,
                              oe_b,
                              output wire[3:0]an,
                              output wire[6:0]display,
                              output wire error);
    wire[DATA_WIDTH-1:0]dout_a,dout_b;
    wire clk_div;
    reg [25:0]target = 50000;
    wire [15:0]BCD_a;
    wire [15:0]BCD_b;
    //divider
    divider d(.clk(clk),.rst(rst),.target(target),.clk_div(clk_div));
    //Syn_DoublePortRAM
    Syn_DoublePortRAM S(.clk(clk),.rst(rst),.addr_a(addr_a),.addr_b(addr_b),.din_a(din_a),.din_b(din_b),.we_a(we_a),.we_b(we_b),.oe_a(oe_a),.oe_b(oe_b),.dout_a(dout_a),.dout_b(dout_b),.error(error));
    //transformer
    transformer t_a(.data(dout_a),.BCD(BCD_a));
    transformer t_b(.data(dout_b),.BCD(BCD_b));
    //display7seg
    display7seg dis(.clk(clk_div),.data3(BCD_a[7:4]),.data2(BCD_a[3:0]),.data1(BCD_b[7:4]),.data0(BCD_b[3:0]),.an(an),.display(display));
endmodule
```

`Syn_DoublePortRAM`

```verilog
module Syn_DoublePortRAM#(parameter DATA_WIDTH = 4,
                          parameter ADDR_DEPTH = 3)
                        (input clk,
                          rst,
                          input [ADDR_DEPTH-1:0]addr_a,
                          addr_b,
                          input [DATA_WIDTH-1:0]din_a,
                          din_b,
                          input we_a,
                          we_b,
                          input oe_a,
                          oe_b,
                          output reg[DATA_WIDTH-1:0]dout_a,
                          dout_b,
                          output reg error);
    reg [DATA_WIDTH-1:0] RAM[(1<<ADDR_DEPTH)-1:0];
    //error
    always @(posedge clk)
    begin
        if (rst)
        begin
            error <= 0;
        end
        else if (!we_a&&!we_b&&(addr_a == addr_b))//地址相同时只能进行read
            error <= 0;
        else if (addr_a! = addr_b)//地址不同
            error <= 0;
        else
            error <= 1;//error指示灯亮
    end
    //write
    integer i;
    always @(posedge clk)
    begin
        if (rst)//init
        begin
            for(i = 0;i<(1<<ADDR_DEPTH);i = i+1)
            begin
                RAM[i] <= 0;
            end
        end
        else if (we_a&&!we_b&&(addr_a! = addr_b))
            RAM[addr_a] = din_a;
        else if (!we_a&&we_b&&(addr_a! = addr_b))
            RAM[addr_b] = din_b;
        else if (we_a&&we_b&&(addr_a! = addr_b))
        begin
            RAM[addr_a] = din_a;
            RAM[addr_b] = din_b;
        end
            end
            //read
            //syn_a
            always @(posedge clk)
            begin
                if (rst)
                begin
                    dout_a <= 0;
                end
                else if (!we_a && oe_a)
                begin
                    dout_a <= RAM[addr_a];
                end
                else
                    dout_a <= 0;
            end
            
            always @(posedge clk)
            begin
                if (rst)
                begin
                    dout_b <= 0;
                end
                else if (!we_b && oe_b)
                begin
                    dout_b <= RAM[addr_b];
                end
                else
                    dout_b <= 0;
            end
            endmodule
```

## 双端口异步RAM

- 顶层模块：

  ![image-20220421220505617](https://cdn.jsdelivr.net/gh/GEAMING-CHN/images/blogimg/%E6%9D%82%E9%A1%B9/image-20220421220505617.png)

- Asy_DoublePortRAM：双端口同步RAM；

- 其余模块功能同上

`top_Asy_DoublePortRAM`

```verilog
module top_Asy_DoublePortRAM#(parameter DATA_WIDTH = 3,
                              parameter ADDR_DEPTH = 3)
                            (input clk,
                              rst,
                              input [ADDR_DEPTH-1:0]addr_a,
                              addr_b,
                              input [DATA_WIDTH-1:0]din_a,
                              din_b,
                              input we_a,
                              we_b,
                              input oe_a,
                              oe_b,
                              output wire[3:0]an,
                              output wire[6:0]display,
                              output wire error);
    
    wire[DATA_WIDTH-1:0]dout_a,dout_b;
    wire clk_div;
    reg [25:0]target = 50000;
    wire [15:0]BCD_a;
    wire [15:0]BCD_b;
    
    //divider
    divider d(.clk(clk),
    .rst(rst),
    .target(target),
    .clk_div(clk_div));
    
    //Syn_DoublePortRAM
    Asy_DoublePortRAM S(.clk(clk),
    .rst(rst),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .din_a(din_a),
    .din_b(din_b),
    .we_a(we_a),
    .we_b(we_b),
    .oe_a(oe_a),
    .oe_b(oe_b),
    .dout_a(dout_a),
    .dout_b(dout_b),
    .error(error));
    
    //transformer
    transformer t_a(.data(dout_a),.BCD(BCD_a));
    transformer t_b(.data(dout_b),.BCD(BCD_b));
    //display7seg
    display7seg dis(.clk(clk_div),.data3(BCD_a[7:4]),.data2(BCD_a[3:0]),.data1(BCD_b[7:4]),.data0(BCD_b[3:0]),.an(an),.display(display));
endmodule
```

`Asy_DoublePortRAM`

```verilog
module Asy_DoublePortRAM#(parameter DATA_WIDTH = 4,
                          parameter ADDR_DEPTH = 3)
                        (input clk,
                          rst,
                          input [ADDR_DEPTH-1:0]addr_a,
                          addr_b,
                          input [DATA_WIDTH-1:0]din_a,
                          din_b,
                          input we_a,
                          we_b,
                          input oe_a,
                          oe_b,
                          output reg[DATA_WIDTH-1:0]dout_a,
                          dout_b,
                          output reg error);
    
    reg [DATA_WIDTH-1:0] RAM[(1<<ADDR_DEPTH)-1:0];
    //error
    always @(posedge clk)
    begin
        if (rst)
        begin
            error <= 0;
        end
        else if (!we_a&&!we_b&&(addr_a == addr_b))//地址相同时只能进行read
            error <= 0;
        else if (addr_a! = addr_b)//地址不同
            error <= 0;
        else
            error <= 1;//error指示灯亮
    end
    //write
    integer i;
    always @(posedge clk)
    begin
        if (rst)//init
        begin
            for(i = 0;i<(1<<ADDR_DEPTH);i = i+1)
            begin
                RAM[i] <= 0;
            end
        end
        else if (we_a&&!we_b&&(addr_a! = addr_b))
            RAM[addr_a] = din_a;
        else if (!we_a&&we_b&&(addr_a! = addr_b))
            RAM[addr_b] = din_b;
        else if (we_a&&we_b&&(addr_a! = addr_b))
        begin
            RAM[addr_a] = din_a;
            RAM[addr_b] = din_b;
        end
            end
            //read
            //asy_a
            always @(addr_a)
            begin
                if (!we_a && oe_a)
                    dout_a <= RAM[addr_a];
                else
                    dout_a <= 0;
            end
            
            //asy_b
            always @(addr_b)
            begin
                if (!we_b && oe_b)
                    dout_b <= RAM[addr_b];
                else
                    dout_b <= 0;
            end
            endmodule

```



# FIFO

代码传送门：https://github.com/Geaming-CHN/Vivado/tree/main/_Digital%20logic/Project14

## 内容

实现FIFO设计，FIFO由存储单元队列或阵列构成，和RAM不同的是FIFO没有地址，第一个被写入队列的数据也是第一个从队列中读出的数据。

## 设计思路

FIFO 是一个先入先出的存储队列，和RAM 不同的是FIFO 没有地址，第一个被写入队列的数据也是第一个从队列中读出的数据。FIFO 可以在输入输出速率不匹配时，作为临时存储单元；可用于不同时钟域中间的同步；输入数据路径和输出数据路径之间数据宽度不匹配时，可用于数据宽度调整电路。

![image-20220421220605129](https://cdn.jsdelivr.net/gh/GEAMING-CHN/images/blogimg/%E6%9D%82%E9%A1%B9/image-20220421220605129.png)

- 顶层模块

  ![image-20220421220624346](https://cdn.jsdelivr.net/gh/GEAMING-CHN/images/blogimg/%E6%9D%82%E9%A1%B9/image-20220421220624346.png)

- debkey：消抖模块；

- FIFO：实现FIFO；

`top_FIFO`

```verilog
module top_FIFO#(parameter DATA_WIDTH = 4,parameter ADDR_DEPTH = 4)(
    input button,clk,rst,wr_en,rd_en,
    input [DATA_WIDTH-1:0]data_in,
    output empty,full, 
    output wire[3:0]an,
    output wire[6:0]display
    );
    wire button_deb;
    wire[DATA_WIDTH-1:0]data_out;
    wire clk_div;
    reg [25:0]target = 50000;
    wire [15:0]BCD;
    //divider
    divider d(.clk(clk),.rst(rst),.target(target),.clk_div(clk_div));
    //debkey
    debkey deb(.clk(clk),.rst(rst),.key_in(button),.key_out(button_deb));
    //FIFO
    FIFO F(.clk(button_deb),.rst(rst),.wr_en(wr_en),.rd_en(rd_en),.data_in(data_in),.empty(empty),.full(full),.data_out(data_out));
    //transformer
    transformer t(.data(data_out),.BCD(BCD));
    //display7seg
    display7seg dis(.clk(clk_div),.data3(BCD[15:12]),.data2(BCD[11:8]),.data1(BCD[7:4]),.data0(BCD[3:0]),.an(an),.display(display));    
endmodule
```

`FIFO`

```verilog
module FIFO#(parameter DATA_WIDTH = 4,parameter ADDR_DEPTH = 4)(
    input clk,rst,wr_en,rd_en,
    input [DATA_WIDTH-1:0] data_in,
    output reg empty,full,    
    output reg[DATA_WIDTH-1:0] data_out
    );
    reg [DATA_WIDTH-1:0] FIFO[(1<<ADDR_DEPTH) - 1:0]; 
    reg [ADDR_DEPTH-1:0]head;
    reg [ADDR_DEPTH-1:0]rear;
    reg [ADDR_DEPTH:0]NUM;
    //empty
    always @(*) begin
        if(NUM==0)
            empty<=1;
        else
            empty<=0;
    end
    //full
    always @(*) begin
        if(NUM==(1<<ADDR_DEPTH))
            full<=1;
        else
            full<=0;
    end
    //NUM
    always @(posedge clk or posedge rst) begin
        if(rst)
            NUM<=0;
        else if(!wr_en&&!rd_en)//no write no read
            NUM<=NUM;
        else if(wr_en&&!rd_en&&(NUM<(1<<ADDR_DEPTH)))//wirte no read
            NUM<=NUM+'b1;
        else if(!wr_en&&rd_en&&(NUM>0))//read no write
            NUM<=NUM-'b1; 
        else if(wr_en&&rd_en)
            NUM<=NUM;
    end
    //write
    integer i;
    always @(posedge clk or posedge rst) begin
        if(rst)
        begin
            rear<='b0;
            for(i=0;i<(1<<ADDR_DEPTH);i=i+1)
                FIFO[i]<=0;
        end
        else if(wr_en&&(NUM<(1<<ADDR_DEPTH)))//not full
        begin
            FIFO[rear]<=data_in;
            rear<=(rear+1)%(1<<ADDR_DEPTH);
        end
        else if(wr_en&&(NUM>(1<<ADDR_DEPTH)-1))//full
            rear<=rear;

    end
    //read
    always @(posedge clk or posedge rst) begin
        if(rst)
        begin
            head<='b0;
            data_out<=0;
        end
            
        else if(rd_en&&(NUM!=0))
        begin
            data_out<=FIFO[head];
            head<=(head+1)%(1<<ADDR_DEPTH);
        end
        else if(NUM==0)
            data_out<=0;
    end
endmodule
```

`debkey`

```verilog
module debkey(
    input clk,
    input rst,
    input key_in,
    output key_out
    );
    parameter T100Hz = 249999;
    integer cnt_100Hz;
    reg clk_100Hz;
    always @(posedge clk) begin
        if(rst)
            cnt_100Hz<=32'b0;
        else
        begin
            cnt_100Hz<=cnt_100Hz+1'b1;
            if(cnt_100Hz==T100Hz)
            begin
                cnt_100Hz<=32'b0;
                clk_100Hz<=~clk_100Hz;
            end
        end
    end

    reg[2:0]key_rrr,key_rr,key_r;
    always @(posedge clk_100Hz) begin
        if(rst)
            begin
                key_rrr<=1'b1;
                key_rr<=1'b1;
                key_r<=1'b1;
            end
        else
        begin
            key_rrr<=key_rr;
            key_rr<=key_r;
            key_r<=key_in;
        end
    end
    assign key_out = key_rrr&key_rr&key_r;

endmodule
```

