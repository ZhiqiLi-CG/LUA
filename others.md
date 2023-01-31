# 一些零散的函数

dofile() 在lua中加载文件

math.sqrt()开跟

lua -i a.lua 执行完过后，进入交互式界面

x= x or v
等价于 if not x then v end
表示，当x未被初始化时，将其默认值设为v（假设x不是false）

a and b or c
当b不为false时，等价于C中的a?b:c（and优先级比or高）

上面两则都是由于短路造成的

需要注意的是and or的返回值，执行到那里就返回什么
