# LUA COURSES

LUA面试题：https://zhuanlan.zhihu.com/p/383994942?utm_oi=757371723308879872#:~:text=1.%E5%AE%9E%E7%8E%B0%E6%9B%BF%E6%8D%A2%E5%AD%97%E7%AC%A6%E4%B8%B2%22abcdefgh%22%E4%B8%AD%E7%9A%84%22abc%22%E4%B8%BA%22ddc%22%EF%BC%9F%20string.gsub,%28%22abcdefgh%22%2C%22abc%22%2C%22ddc%22%29%202.ipairs%E5%92%8Cpairs%E7%9A%84%E5%8C%BA%E5%88%AB%EF%BC%9F%201.ipairs%E9%81%87%E5%88%B0nil%E4%BC%9A%E5%81%9C%E6%AD%A2%EF%BC%8Cpairs%E4%BC%9A%E8%BE%93%E5%87%BAnil%E5%80%BC%E7%84%B6%E5%90%8E%E7%BB%A7%E7%BB%AD%E4%B8%8B%E5%8E%BB

## 1. Basic
### 1.1 注释：
 两个减号是单行注释:

```lua
--
```
多行注释

```lua
--[[
 多行注释
 多行注释
 --]]
 ```
 ### 1.2 全局变量
 全局变量

在默认情况下，变量总是认为是全局的。

全局变量不需要声明，给一个变量赋值后即创建了这个全局变量，访问一个没有初始化的全局变量也不会出错，只不过得到的结果是：nil。 

如果你想删除一个全局变量，只需要将变量赋值为nil。

### 1.3 数据类型
Lua 中有 8 个基本类型分别为：**nil**、**boolean、number、string、userdata**(表示任意存储在变量中的C数据结构)、**function**、**thread**(表示执行的独立线路，用于执行协同程序) 和 **table**(Lua 中的表（table）其实是一个"关联数组"（associative arrays），数组的索引可以是数字、字符串或表类型。在 Lua 里，table 的创建是通过"构造表达式"来完成，最简单构造表达式是{}，用来创建一个空表。)。

我们可以使用 type 函数测试给定变量或者值的类型. type的输出值为string。一个没有赋值的变量，便会输出一个 nil 值

对于全局变量和 table，nil 还有一个"删除"作用，给全局变量或者 table 表里的变量赋一个 nil 值，等同于把它们删掉，执行下面代码就知：
```lua
tab1 = { key1 = "val1", key2 = "val2", "val3" }
for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end
 
tab1.key1 = nil
for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end
```

Lua 把 false 和 nil 看作是 false，其他的都为 true，数字 0 也是 true

```lua
if false or nil then
    print("至少有一个是 true")
else
    print("false 和 nil 都为 false")
end
```

也可以用 2 个方括号 "[[]]" 来表示"一块"字符串。
```lua
html = [[
<html>
<head></head>
<body>
    <a href="http://www.runoob.com/">菜鸟教程</a>
</body>
</html>
]]
print(html)
```

在对一个数字字符串上进行算术操作时，Lua 会尝试将这个数字字符串转成一个数字:

```lua
>print("2" + 6)
8.0
```

字符串连接使用的是 ..

使用 # 来计算字符串的长度，放在字符串前面

```lua
> len = "www.runoob.com"
> print(#len)
14
```

在 Lua 里，table 的创建是通过"构造表达式"来完成，最简单构造表达式是{}，用来创建一个空表。也可以在表里添加一些数据，直接初始化表,

table默认索引是数字。在 Lua 里表的默认初始索引一般以 1 开始

在 Lua 中，函数是被看作是"第一类值（First-Class Value）"，函数可以存在变量里:

```lua
-- function_test.lua 脚本文件
function factorial1(n)
    if n == 0 then
        return 1
    else
        return n * factorial1(n - 1)
    end
end
print(factorial1(5))
factorial2 = factorial1
print(factorial2(5))
```

```lua
-- function_test2.lua 脚本文件
function testFun(tab,fun)
        for k ,v in pairs(tab) do
                print(fun(k,v));
        end
end


tab={key1="val1",key2="val2"};
testFun(tab,
function(key,val)--匿名函数
        return key.."="..val;
end
);
```

在 Lua 里，最主要的线程是协同程序（coroutine）。它跟线程（thread）差不多，拥有自己独立的栈、局部变量和指令指针，可以跟其他协同程序共享全局变量和其他大部分东西。

线程跟协程的区别：线程可以同时多个运行，而协程任意时刻只能运行一个，并且处于运行状态的协程只有被挂起（suspend）时才会暂停。

userdata 是一种用户自定义数据，用于表示一种由应用程序或 C/C++ 语言库所创建的类型，可以将任意 C/C++ 的任意数据类型的数据（通常是 struct 和 指针）存储到 Lua 变量中调用。

### 1.3 变量
Lua 变量有三种类型：全局变量、局部变量、表中的域。

Lua 中的变量全是全局变量，哪怕是语句块或是函数里，除非用 local 显式声明为局部变量。

局部变量的作用域为从声明位置开始到所在语句块结束。 

Lua 可以对多个变量同时赋值，变量列表和值列表的各个元素用逗号分开，赋值语句右边的值会依次赋给左边的变量。

```lua
a, b = 10, 2*x  -- a=10; b=2*x
```
遇到赋值语句Lua会先计算右边所有的值然后再执行赋值操作，所以我们可以这样进行交换变量的值

 当变量个数和值的个数不一致时，Lua会一直以变量个数为基础采取以下策略：

 -   a. 变量个数 > 值的个数             按变量个数补足nil
- b. 变量个数 < 值的个数             多余的值会被忽略

 应该尽可能的使用局部变量，有两个好处：

-   1. 避免命名冲突。
-   2. 访问局部变量的速度比全局变量更快

 对 table 的索引使用方括号 []。Lua 也提供了 . 操作。

-   t[i]
-   t.i                 -- 当索引为字符串类型时的一种简化写法
-   gettable_event(t,i) -- 采用索引访问本质上是一个类似这样的函数调用

table如果在初始化的时候使用 “=”,那么其key的命名的规则类似于变量.而通过[]初始化是，没有这个要求

### 1.4 for循环

```lua
for var=exp1,exp2,exp3 do  
    <执行体>  
end  
```

泛型 for 循环通过一个迭代器函数来遍历所有值，类似 java 中的 foreach 语句。

Lua 编程语言中泛型 for 循环语法格式:

```lua
--打印数组a的所有值  
a = {"one", "two", "three"}
for i, v in ipairs(a) do
    print(i, v)
end 
```

ipairs貌似在第一个nil处会中断


Lua 语言中的 goto 语句允许将控制流程无条件地转到被标记的语句处。
```lua
goto Label
```

```lua
:: Label ::
```

``` lua
i = 0
::s1:: do
  print(i)
  i = i+1
end
if i>3 then
  os.exit()   -- i 大于 3 时退出
end
goto s1
```

lua 中是elseif

### 1.5 函数

Lua 函数可以接受可变数目的参数，和 C 语言类似，在函数参数列表中使用三点 ... 表示函数有可变的参数。

```lua
function add(...)  
local s = 0  
  for i, v in ipairs{...} do   --> {...} 表示一个由所有变长参数构成的数组  
    s = s + v  
  end  
  return s  
end  
print(add(3,4,5,6,7))  --->25
```

我们也可以通过 select("#",...) 来获取可变参数的数量, 也可以直接赋值：
```lua
local arg={...} 
or
select("#",...)
```

```lua
function fwrite(fmt, ...)  ---> 固定的参数fmt
    return io.write(string.format(fmt, ...))    
end

fwrite("runoob\n")       --->fmt = "runoob", 没有变长参数。  
fwrite("%d%d\n", 1, 2)   --->fmt = "%d%d", 变长参数为 1 和 2
```

通常在遍历变长参数的时候只需要使用 {…}，然而变长参数可能会包含一些 nil，那么就可以用 select 函数来访问变长参数了：``select('#', …)`` 或者 ``select(n, …)``

    
-   ``select('#', …)`` 返回可变参数的长度。

-   ``select(n, …)`` 用于返回从起点 n 开始到结束位置的所有参数列表。 

调用 select 时，必须传入一个固定实参 selector(选择开关) 和一系列变长参数。如果 selector 为数字 n，那么 select 返回参数列表中从索引 n 开始到结束位置的所有参数列表，否则只能为字符串 #，这样 select 返回变长参数的总数。

### 1.6 Lua 运算符
^	乘幂	10^2 输出结果 100

//	整除运算符(>=lua5.3)	5//2 输出结果 2

and or not

其他运算符：
-   ..	连接两个字符串
-   \#	一元运算符，返回字符串或表的长度。

### 1.7 字符串

字符串或串(String)是由数字、字母、下划线组成的一串字符。

Lua 语言中字符串可以使用以下三种方式来表示：

-   单引号间的一串字符。
-   双引号间的一串字符。
-   [[ 与 ]] 间的一串字符。

-   string.upper(argument):
字符串全部转为大写字母。
-   string.lower(argument):
字符串全部转为小写字母。
-   string.gsub(mainString,findString,replaceString,num),在字符串中替换。
mainString 为要操作的字符串， findString 为被替换的字符，replaceString 要替换的字符，num 替换次数（可以忽略，则全部替换），如：
```lua
> string.gsub("aaaa","a","z",3);
zzza    3
```

https://www.runoob.com/lua/lua-strings.html

字符与整数相互转换
```lua
-- 字符转换
-- 转换第一个字符
print(string.byte("Lua"))
-- 转换第三个字符
print(string.byte("Lua",3))
-- 转换末尾第一个字符
print(string.byte("Lua",-1))
-- 第二个字符
print(string.byte("Lua",2))
-- 转换末尾第二个字符
print(string.byte("Lua",-2))

-- 整数 ASCII 码转换为字符
print(string.char(97))
```

### 1.8数组
正如你所看到的，我们可以使用整数索引来访问数组元素，如果指定的索引没有值则返回 nil。

在 Lua 索引值是以 1 为起始，但你也可以指定 0 开始。

除此外我们还可以以负数为数组索引

### 1.9 迭代器
在Lua中我们常常使用函数来描述迭代器，每次调用该函数就返回集合的下一个元素。Lua 的迭代器包含以下两种类型：

-   无状态的迭代器
-   多状态的迭代器

无状态的迭代器是指不保留任何状态的迭代器，因此在循环中我们可以利用无状态迭代器避免创建闭包花费额外的代价. 每一次迭代，迭代函数都是用两个变量（状态常量和控制变量）的值作为参数被调用，一个无状态的迭代器只利用这两个值可以获取下一个元素。
```lua
function square(iteratorMaxCount,currentNumber)
    if currentNumber<iteratorMaxCount
    then
       currentNumber = currentNumber+1
    return currentNumber, currentNumber*currentNumber
    end
 end
 
 for i,n in square,3,0
 do
    print(i,n)
 end
```

迭代的状态包括被遍历的表（循环过程中不会改变的状态常量）和当前的索引下标（控制变量），ipairs 和迭代函数都很简单，我们在 Lua 中可以这样实现：

```lua
function iter (a, i)
    i = i + 1
    local v = a[i]
    if v then
       return i, v
    end
end
 
function ipairs (a)
    return iter, a, 0
end
```

多状态的迭代器

很多情况下，迭代器需要保存多个状态信息而不是简单的状态常量和控制变量，最简单的方法是使用闭包，还有一种方法就是将所有的状态信息封装到 table 内，将 table 作为迭代器的状态常量，因为这种情况下可以将所有的信息存放在 table 内，所以迭代函数通常不需要第二个参数。

```lua
array = {"Google", "Runoob"}

function elementIterator (collection)
   local index = 0
   local count = #collection
   -- 闭包函数
   return function ()
      index = index + 1
      if index <= count
      then
         --  返回迭代器的当前元素
         return collection[index]
      end
   end
end

for element in elementIterator(array)
do
   print(element)
end
```

### 1.10 表
Lua table 使用关联型数组，你可以用任意类型的值来作数组的索引，但这个值不能是 nil。

Lua table 是不固定大小的，你可以根据自己需要进行扩容。

Lua也是通过table来解决模块（module）、包（package）和对象（Object）的

**当我们为 table a 并设置元素，然后将 a 赋值给 b，则 a 与 b 都指向同一个内存。如果 a 设置为 nil ，则 b 同样能访问 table 的元素。如果没有指定的变量指向a，Lua的垃圾回收机制会清理相对应的内存**。

```lua
-- 简单的 table
mytable = {}
print("mytable 的类型是 ",type(mytable))

mytable[1]= "Lua"
mytable["wow"] = "修改前"
print("mytable 索引为 1 的元素是 ", mytable[1])
print("mytable 索引为 wow 的元素是 ", mytable["wow"])

-- alternatetable和mytable的是指同一个 table
alternatetable = mytable

print("alternatetable 索引为 1 的元素是 ", alternatetable[1])
print("mytable 索引为 wow 的元素是 ", alternatetable["wow"])

alternatetable["wow"] = "修改后"

print("mytable 索引为 wow 的元素是 ", mytable["wow"])

-- 释放变量
alternatetable = nil
print("alternatetable 是 ", alternatetable)

-- mytable 仍然可以访问
print("mytable 索引为 wow 的元素是 ", mytable["wow"])

mytable = nil
print("mytable 是 ", mytable)
```

table常见用法
-   table.concat (table [, sep [, start [, end]]]):
-   table.insert (table, [pos,] value):默认为数组部分末尾.
-   table.maxn (table):
-   table.remove (table [, pos])
-   table.sort (table [, comp])\

```lua
fruits = {"banana","orange","apple"}
-- 返回 table 连接后的字符串
print("连接后的字符串 ",table.concat(fruits))

-- 指定连接字符
print("连接后的字符串 ",table.concat(fruits,", "))

-- 指定索引来连接 table
print("连接后的字符串 ",table.concat(fruits,", ", 2,3))
```

```lua
fruits = {"banana","orange","apple","grapes"}
print("排序前")
for k,v in ipairs(fruits) do
        print(k,v)
end

table.sort(fruits)
print("排序后")
for k,v in ipairs(fruits) do
        print(k,v)
end
```

Table 最大值

table.maxn 在 Lua5.2 之后该方法已经不存在了，我们定义了 table_maxn 方法来实现。

### 1.11 模块与包
模块类似于一个封装库，从 Lua 5.1 开始，Lua 加入了标准的模块管理机制，可以把一些公用的代码放在一个文件里，以 API 接口的形式在其他地方调用，有利于代码的重用和降低代码耦合度。

```lua
-- 文件名为 module.lua
-- 定义一个名为 module 的模块
module = {}
 
-- 定义一个常量
module.constant = "这是一个常量"
 
-- 定义一个函数
function module.func1()
    io.write("这是一个公有函数！\n")
end
 
local function func2()
    print("这是一个私有函数！")
end
 
function module.func3()
    func2()
end
 
return module
```

Lua提供了一个名为require的函数用来加载模块。要加载一个模块，只需要简单地调用就可以了。

```lua
-- test_module.lua 文件
-- module 模块为上文提到到 module.lua
require("module")
 
print(module.constant)
 
module.func3()
```
加载机制
require 用于搜索 Lua 文件的路径是存放在全局变量 package.path 中，当 Lua 启动后，会以环境变量 LUA_PATH 的值来初始这个环境变量

当然，如果没有 LUA_PATH 这个环境变量，也可以自定义设置，在当前用户根目录下打开 .profile 文件（没有则创建，打开 .bashrc 文件也可以），例如把 "~/lua/" 路径加入 LUA_PATH 环境变量里

```lua
#LUA_PATH
export LUA_PATH="~/lua/?.lua;;"
```
 接着，更新环境变量参数，使之立即生效。

```lua
source ~/.profile
```

C包

与Lua中写包不同，C包在使用以前必须首先加载并连接，在大多数系统中最容易的实现方式是通过动态连接库机制。

Lua在一个叫loadlib的函数内提供了所有的动态连接的功能。这个函数有两个参数:库的绝对路径和初始化函数。所以典型的调用的例子如下

```lua
local path = "/usr/local/lua/lib/libluasocket.so"
local f = loadlib(path, "luaopen_socket")
```

oadlib 函数加载指定的库并且连接到 Lua，然而它并不打开库（也就是说没有调用初始化函数），反之他返回初始化函数作为 Lua 的一个函数，这样我们就可以直接在Lua中调用他。

如果加载动态库或者查找初始化函数时出错，loadlib 将返回 nil 和错误信息。我们可以修改前面一段代码，使其检测错误然后调用初始化函数：

```lua
local path = "/usr/local/lua/lib/libluasocket.so"
-- 或者 path = "C:\\windows\\luasocket.dll"，这是 Window 平台下
local f = assert(loadlib(path, "luaopen_socket"))
f()  -- 真正打开库
```

### 1.12 元表

在 Lua table 中我们可以访问对应的 key 来得到 value 值，但是却无法对两个 table 进行操作(比如相加)。

因此 Lua 提供了元表(Metatable)，允许我们改变 table 的行为，每个行为关联了对应的元方法。

例如，使用元表我们可以定义 Lua 如何计算两个 table 的相加操作 a+b。

当 Lua 试图对两个表进行相加时，先检查两者之一是否有元表，之后检查是否有一个叫 __add 的字段，若找到，则调用对应的值。 __add 等即时字段，其对应的值（往往是一个函数或是 table）就是"元方法"。

有两个很重要的函数来处理元表：

-   setmetatable(table,metatable): 对指定 table 设置元表(metatable)，如果元表(metatable)中存在 __metatable 键值，setmetatable 会失败。

-   getmetatable(table): 返回对象的元表(metatable)。

为指定的表设置元表
```lua
mytable = {}                          -- 普通表
mymetatable = {}                      -- 元表
setmetatable(mytable,mymetatable)     -- 把 mymetatable 设为 mytable 的元表 
```
或者
```lua
mytable = setmetatable({},{})
```
返回元表对象
```lua
getmetatable(mytable)                 -- 这会返回 mymetatable
```
(1) __index 元方法
当你通过键来访问 table 的时候，如果这个键没有值，那么Lua就会寻找该table的metatable（假定有metatable）中的__index 键。如果__index包含一个表格，Lua会在表格中查找相应的键。
```lua
> other = { foo = 3 }
> t = setmetatable({}, { __index = other })
> t.foo
3
> t.bar
nil
```

如果__index包含一个函数的话，Lua就会调用那个函数，table和键会作为参数传递给函数。

__index 元方法查看表中元素是否存在，如果不存在，返回结果为 nil；如果存在则由 __index 返回结果。

```lua
mytable = setmetatable({key1 = "value1"}, {
  __index = function(mytable, key)
    if key == "key2" then
      return "metatablevalue"
    else
      return nil
    end
  end
})

print(mytable.key1,mytable.key2)
```
Lua 查找一个表元素时的规则，其实就是如下 3 个步骤:

-   1.在表中查找，如果找到，返回该元素，找不到则继续
-   2.判断该表是否有元表，如果没有元表，返回 nil，有元表则继续。
-   3.判断元表有没有 __index 方法，如果 __index 方法为 nil，则返回 nil；如果 __index 方法是一个表，则重复 1、2、3；如果 __index 方法是一个函数，则返回该函数的返回值。

(2) __newindex 元方法

当你给表的一个缺少的索引赋值，解释器就会查找__newindex 元方法：如果存在则调用这个函数而不进行赋值操作。

```lua
mymetatable = {}
mytable = setmetatable({key1 = "value1"}, { __newindex = mymetatable })

print(mytable.key1)

mytable.newkey = "新值2"
print(mytable.newkey,mymetatable.newkey)

mytable.key1 = "新值1"
print(mytable.key1,mymetatable.key1)
```
以上实例中表设置了元方法 __newindex，在对新索引键（newkey）赋值时（mytable.newkey = "新值2"），会调用元方法，而不进行赋值。而如果对已存在的索引键（key1），则会进行赋值，而不调用元方法 __newindex。

与__index类似，也可以设置函数。

```lua
mytable = setmetatable({key1 = "value1"}, {
    __newindex = function(mytable, key, value)
        rawset(mytable, key, "\""..value.."\"")
    end
})

mytable.key1 = "new value"
mytable.key2 = 4

print(mytable.key1,mytable.key2)
```
**rawset (table, index, value) : Sets the real value of table[index] to value, without invoking any metamethod**

(3)运算

-   __add	对应的运算符 '+'.
-   __sub	对应的运算符 '-'.
-   __mul	对应的运算符 '*'.
-   __div	对应的运算符 '/'.
-   __mod	对应的运算符 '%'.
-   __unm	对应的运算符 '-'.
-   __concat	对应的运算符 '..'.
-   __eq	对应的运算符 '=='.
-   __lt	对应的运算符 '<'.
-   __le	对应的运算符 '<='.

（4）call
__call 元方法在 Lua 调用一个值时调用。以下实例演示了计算表中元素的和：

```lua
-- 计算表中最大值，table.maxn在Lua5.2以上版本中已无法使用
-- 自定义计算表中最大键值函数 table_maxn，即计算表的元素个数
function table_maxn(t)
    local mn = 0
    for k, v in pairs(t) do
        if mn < k then
            mn = k
        end
    end
    return mn
end

-- 定义元方法__call
mytable = setmetatable({10}, {
  __call = function(mytable, newtable)
        sum = 0
        for i = 1, table_maxn(mytable) do
                sum = sum + mytable[i]
        end
    for i = 1, table_maxn(newtable) do
                sum = sum + newtable[i]
        end
        return sum
  end
})
newtable = {10,20,30}
print(mytable(newtable))
```

(5) __tostring

```lua
mytable = setmetatable({ 10, 20, 30 }, {
  __tostring = function(mytable)
    sum = 0
    for k, v in pairs(mytable) do
                sum = sum + v
        end
    return "表所有元素的和为 " .. sum
  end
})
print(mytable)
```

### 1.13 协同程序

线程与协同程序的主要区别在于，一个具有多个线程的程序可以同时运行几个线程，而协同程序却需要彼此协作的运行。

在任一指定时刻只有一个协同程序在运行，并且这个正在运行的协同程序只有在明确的被要求挂起的时候才会被挂起。

协同程序有点类似同步的多线程，在等待同一个线程锁的几个线程有点类似协同。