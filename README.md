# Verilog代码汇总

[toc]

自己整理的verilog文件，方便后续查看。

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

