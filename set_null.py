column_names = {
    1:["income","double"],  
    2:["house_age","int"],  
    3:["house_size","int"], 
    4:["rooms","int"], 
    5:["bedrooms","int"],
    6:["latitude","double"],  
    7:["longitude","double"],  
    8:["house_price","double"]
}

str = "alter table california_housing\n"
for v in column_names.values():
    if v[1] == "int": 
        ind = 0
    elif v[1] == "double":  
        ind = 0.0
    str += "modify column " + v[0] + " " + v[1] + " default " + f"{ind}" + ", \n"

str = str[:-3]
print(str)
