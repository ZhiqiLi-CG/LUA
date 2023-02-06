local BinarySearchTree = {}

function BinarySearchTree:new(idx)
    local o={value=idx,left=nil,right=nil}
    setmetatable(o, BinarySearchTree)
    BinarySearchTree.__index=BinarySearchTree
    return o
end

function BinarySearchTree:from_list(t)
    if(#t==0) then
        error("should not allow a tree to be created from an empty list")
    end
    local root=self:new(t[1])
    for i=2,#t do
        root:insert(t[i])
    end
    return root
end
local function tranverse(root)
    if(root==nil) then
        return {}
    end
    local left_list=tranverse(root.left)
    local right_list=tranverse(root.right)
    local list,left_num=left_list,#left_list+1
    list[#left_list+1]=root.value
    for i=1,#right_list do
        list[left_num+i]=right_list[i]
    end    
    return list
end
function BinarySearchTree:values()
    local list=tranverse(self)
    -- then define the interator
    local index = 0
    local count = #list
    -- 闭包函数
    return function ()
       index = index + 1
       if index <= count
       then
          return list[index]
       end
    end
end

function BinarySearchTree:insert(idx)
    local iter=self
    while(true) do
        if(iter.value==idx) then break end
        if(iter.left==nil and iter.right==nil) then
            if(idx<iter.value) then iter.left=self:new(idx) break
            else iter.right=self:new(idx) break end
        elseif(iter.left==nil) then
            if(idx<iter.value) then iter.left=self:new(idx) break
            else iter=iter.right end
        elseif(iter.right==nil) then
            if(idx<iter.value) then iter=iter.left
            else iter.right=self:new(idx) break end
        else
            if(idx>iter.value) then
                iter=iter.right
            else
                iter=iter.left
            end
        end
    end
end

local tree = BinarySearchTree:new(4)
tree:insert(3)
print(tree.value)
print(tree.left.value)
print(tree.right)

tree = BinarySearchTree:from_list({ 2, 4, 6, 3, 5, 1 })
-- local expected = { 1, 2, 3, 4, 5, 6 }
local actual = {}
for v in tree:values() do
    table.insert(actual, v)
    print(v,"...")
end
