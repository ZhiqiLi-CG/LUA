function splitstr(str,seed)
    local str_list,iter_str={},str
    while(true) do
        local beg,en
        if(seed~="") then
            beg,en=string.find(iter_str,seed)        
        else
            if(#iter_str==0) then beg=nil
            else beg,en=2,1 end
        end
        if(beg==nil) then break
        else
            new_str= string.sub(iter_str,1,beg-1)
            --if( not (#new_str==0)) then
                str_list[#str_list+1]=new_str
            --end
            iter_str=string.sub(iter_str,en+1)
        end
    end
    if( not (#iter_str==0)) then
        str_list[#str_list+1]=iter_str
    end
    return str_list
end

function split(s)
    local row_list=splitstr(s,'\n')
    local data_list={}
    for i=1,#row_list do
        data_list[i]=splitstr(row_list[i],"")
    end
    return data_list
end
function trans(t)
    local final_list={}
    local max_num=0
    local row_max_num={}
    local max_col=0
    for i=1,#t do
        for j=1,#t[i] do
            if(final_list[j]==nil) then
                final_list[j]={}
            end
            if(row_max_num[j]==nil or i>row_max_num[j]) then
                row_max_num[j]=i
            end
            if(j>max_col) then max_col=j end
            final_list[j][i]=t[i][j]
        end
    end
    for i=1,max_col do
        if(row_max_num[i]==nil) then row_max_num[i]=0 end
    end
    return final_list,row_max_num
end
function merge(t,n)
    local s=""
    for i=1,#t do
        local row=""
        for j=1,n[i] do
            if(t[i][j]==nil) then row=row.." " 
            else
                row=row..t[i][j]
            end
        end
        s=s..row
        if(i~=#t) then
            s=s.."\n"
        end
    end
    return s
end

Transpose=function(s)
    local t=split(s)
    t,n=trans(t)
    return merge(t,n)
end
x="S\ni\nn\ng\nl\ne\n \nl\ni\nn\ne\n"
print(x)
x=Transpose(x)
print(x)

x="ABC\nCD"
print(x)
x=Transpose(x)
print(x)
print("end")

x='\n' ..
'Line 2\n' ..
'\n' ..
'L4'
print(x)
x=Transpose(x)
print(x)
--[[
x=split(x)
print(#x[1],#x[2],#x[3],#x[4])
x=trans(x)
print(#x)
for i=1,4 do
    print(x[1][i])
end
--]]