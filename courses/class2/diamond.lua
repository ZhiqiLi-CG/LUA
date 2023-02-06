function getChar(idx) 
    return string.char(idx+string.byte("A"))
end
diamond=function(which)
  local n=string.byte(which)-string.byte("A")+1
  local row_list={}
  for i=1,n do
    row_list[i]=string.rep(" ",n-i)
    row_list[i]=row_list[i]..getChar(i-1)
    if(i~=1) then
        row_list[i]=row_list[i]..string.rep(" ",2*i-3)
        row_list[i]=row_list[i]..getChar(i-1)
    end
    row_list[i]=row_list[i]..string.rep(" ",n-i)
  end
  for i=n+1,2*n-1 do
    row_list[i]=row_list[2*n-i]
  end
  return table.concat(row_list,"\n")
end

print(diamond('A'))
print(diamond('B'))
print(diamond('E'))