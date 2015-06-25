file = open('nodenumber', 'r') #opening file in "test" in read mode
x = file.read() 
z = int(x)
z = z+1 
file = open('nodenumber', 'w')
x = str(z)
file.write(x)
