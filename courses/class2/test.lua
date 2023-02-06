function split(str,seed)
  local str_list,iter_str={},str
  while(true) do
    beg,en=string.find(iter_str,seed)
    if(beg==nil) then break
    else
        new_str= string.sub(iter_str,1,beg-1)
        if( not (#new_str==0)) then
            str_list[#str_list+1]=new_str
        end
        iter_str=string.sub(iter_str,beg+1)
    end
  end
    if( not (#iter_str==0)) then
        str_list[#str_list+1]=iter_str
    end
  return str_list
end
function Matrix(s)
    local raw_row_list=split(s,"\n")
    local data={}
    local matrix={}
    for i = 1,#raw_row_list do
        local tem=split(raw_row_list[i]," ")
        data[i]={}
        for j = 1,#tem do 
            data[i][j]=tem[j]
        end 
    end
    matrix["raw_data"]=data
    matrix["row"]=function (r)
        local row_data={}
        for i = 1,#data[r] do
            row_data[i]=data[r][i]
        end
        return row_data
    end
    matrix["column"]=function (c)
        local col_data={}
        for i = 1,#data do
            col_data[i]=data[i][c]
        end
        return col_data
    end
    return matrix
end

local matrix = Matrix('1 2      3\n4 5 6\n7 8 9')
local test_col=matrix.row(1)
for i= 1,#test_col do
    print(test_col[i])
end

s="\nsddssda\n\n\n\nbs"
list=split(s,"\n")
for i= 1,#list do
    print(list[i])
end