prime = function(n)
    if(n<=0) then error("should raise an error for n <= 0") end
    local prime_list={}
    local i,prime_num=2,0
    local maxn=n*100
    while(true) do 
      if(prime_list[i]==nil) then
        prime_num=prime_num+1
        if(prime_num==n) then
          break
        end
        for j=i,maxn,i do
           prime_list[j]=1
        end
      end
      i=i+1
    end
    return i
end