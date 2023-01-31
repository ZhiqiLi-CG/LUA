print("Hello")

tab1 = { key1 = "val1", key2 = "val2", "val3" }
for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end
 
tab1.key1 = nil
for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end

if false or nil then
    print("至少有一个是 true")
else
    print("false 和 nil 都为 false")
end

print("2" + 6)

local a={"1","2","3"}
for k,v in pairs(a) do
    print(k .. ":" .. v)
end

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

ttt= {"sss",1}
ttt[1]=1
for key, val in ipairs(ttt) do
    print(key .." ".. val)
end




t={"12"}
t[3]=1
for k, v in pairs(t) do
    print(k, v)
end



i = 0
::s1:: do
  print(i)
  i = i+1
end
if i>3 then
  os.exit()   -- i 大于 3 时退出
end
goto s1