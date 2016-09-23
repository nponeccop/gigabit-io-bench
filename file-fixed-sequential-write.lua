total = 30000000000
chunk = 8000000
print(total)
s = string.rep("Q",chunk)
f = io.open("bench.bin","a")
for i=0,total/chunk,1 do f:write(s) end
f:close()
