file = open('test', 'r') #opening file in "test" in read mode
x = file.read() 
z = int(x)
z = z+1 #Svaki put kada se skripta izvrsi povecava vrednost
file = open('test', 'w')#otvara fajl "test" u write modu
x = str(z)#konvertuje promenjivu "z" u string
file.write(x)#upisuje vrednost u fajl
