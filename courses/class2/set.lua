member_funcions = {}

function member_funcions:is_empty ()
    local empty=true
    if #self~=0 then empty=false end
    return empty  
end

function member_funcions:contains (idx)
    local find=false
    for i,v in ipairs(self) do
        if(v==idx) then
            find=true
            break
        end
    end
    return find
end

function member_funcions:is_subset(set)
    local is=true
    for i,v in ipairs(self) do
        if(not set:contains(v)) then
            is=false
            break
        end
    end
    return is
end

function member_funcions:equals(set)
    if(self:is_subset(set) and set:is_subset(self)) then
        return true
    else
        return false
    end
end

function member_funcions:intersection(set)
    local tem,cnt={},1
    for i,v in ipairs(self) do
        if(set:contains(v)) then
            tem[cnt]=v
            cnt=cnt+1
        end
    end
    return Set(tem)
end

function member_funcions:is_disjoint(set)
    return self:intersection(set):is_empty()
end

function member_funcions:difference(set)
    local tem,cnt={},1
    for i,v in ipairs(self) do
        if(not set:contains(v)) then
            tem[cnt]=v
            cnt=cnt+1
        end
    end
    return Set(tem)
end

function member_funcions:union(set)
    local tem,cnt={},1
    tem,cnt=set,#set+1
    for i,v in ipairs(self) do
        if(not set:contains(v)) then
            tem[cnt]=v
            cnt=cnt+1
        end
    end
    return Set(tem)
end

function member_funcions:add(v)
    if(not self:contains(v)) then
        self[#self+1]=v
    end
end

function member_funcions:print()
    local s=""..(#self)..":"
    for i,v in ipairs(self) do
        s=s.." "..tostring(v)
    end
    print(s)
end

Set= function(...)
  local o={...}
  if(type(o[1])=="table") then
    o=o[1]
  end
  setmetatable(o, member_funcions)
  member_funcions.__index=member_funcions
  return o
end
print(Set(1,2,3):is_empty())
print("test contains")
print(Set(1,2,3):contains(1))
print(Set(1,2,3):contains(2))
print(Set(1,2,3):contains(3))
print(Set(1,2,3):contains(4))
print("test subset")
print(Set(1,2,3):is_subset(Set(1,2,3)))
print(Set(1,2,3):is_subset(Set(1,2,3,4)))
print(Set(1,2,3,4):is_subset(Set(1,2,3)))
print("test equalis")
print(Set(1,2,3):equals(Set(1,2,3)))
print(Set(1,2,3):equals(Set(1,2,3,4)))
print(Set(1,2,3,4):equals(Set(1,2,3)))
print("test intersect")
-- Set(1,2,3):print()
Set(1,2,3):intersection(Set(1,2,3)):print()
Set(1,2,3):intersection(Set(1,2,3,4)):print()
Set(1,2,3,4):intersection(Set(1,2,3)):print()
print("test difference")
Set(1,2,3):difference(Set(1,2,3)):print()
Set(1,2,3):difference(Set(1,2,3,4)):print()
Set(1,2,3,4):difference(Set(1,2,3)):print()
print("test union")
Set(1,2,3):union(Set(1,2,3)):print()
Set(1,2,3):union(Set(1,2,3,4)):print()
Set(1,2,3,4):union(Set(1,2,3)):print()

print(Set():is_disjoint(Set()))

assert(Set():union(Set()):equals(Set()),"not trye")