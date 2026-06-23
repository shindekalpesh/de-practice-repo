"""
basics of built-in data types
list/dict/set comprehensions review,
*args/**kwargs,
unpacking,
basic type hints
"""
# CRUD - Create Read Update Delete 
# Covering basic datatypes:
# 1. Integer

num = 25

print("-------- integer --------")
# print(type(num))                    # <class 'int'>
# print(num + 25)                     # 50
# print(num - 5)                      # 20
# print(num * 2)                      # 50
# print(num / 4)                      # 6.25
# print(num // 3)                     # 8

pew = 5/3
# print(pew)                          # 1.6666666666666667
# print(pew.is_integer())             # False
# print(isinstance(pew, float))       # True


# 2. Float
num2 = 2.75

print("-------- float --------")
# print(type(num2))                         # <class 'float'>
# print(num2 + 1)                           # 3.75
# print(num2 - 1)                           # 1.75
# print(num2 * 2)                           # 5.5
# print(num2 / 2)                           # 1.375
# print(num2 // 2)                          # 1.0
# print(round(num2,1))                      # 2.8

# 3. str
my_str = "Clark Kent"
print("-------- string --------")
# print(type(my_str))                         # <class 'str'>
# print(id(my_str))                           # 2292176588976
# print(my_str.upper())                       # CLARK KENT
# print(my_str.lower())                       # clark kent
x, y = my_str.split(" ")
# print(x)                                    # Clark
# print(my_str[0])                            # C
# print(my_str[0:8])                          # Clark Ke
# print(my_str[0:8:2])                        # CakK
# print(my_str[:-1])                          # Clark Ken
# print(my_str[::-1])                         # tneK kralC

del x
# print(x)                                    # NameError: name 'x' is not defined

# 4. list:
# ls = []                                     # Blank list
# ls = [1,2,3,4,5]                            # [1, 2, 3, 4, 5]
# print(ls[0:4])                              # [1, 2, 3, 4]
# print(ls[::-1])                             # [5, 4, 3, 2, 1]
# print(ls[::2])                              # [1, 3, 5]
# print(ls[4])
# ls[4] = 55
# print(ls[4])                                # 55 : Updated the element of list at 4 index from 5 to 55
# print(ls)       
# # print(ls.index(x)                         # Returns the index of the value (x) if present in the list. (starting of index = 0), 
#                                             # if not x is not present then returns : ValueError: list.index(x): x not in list           
# print(ls.index(2))                    
# print(ls.index(3))  
# print(ls.index(4))  
# print(ls.index(55)) 
# # print(ls.index(5))                          # ValueError: list.index(x=5): x not in list             
# # print(help(list.index))                 

# ls.append(232)                              # [1, 2, 3, 4, 55, 232]
# print(ls)       
# ls.append([222,333,444])                    # [1, 2, 3, 4, 55, 232, [222, 333, 444]]
# print(ls)       

# ls.remove(55)                               # [1, 2, 3, 4, 232, [222, 333, 444]]
# print(ls)

# ls.pop()
# print(ls)                                   # [1, 2, 3, 4, 232]

# ls.sort()                                   # [1, 2, 3, 4, 232]
# print(ls)

# ls.sort(reverse=True)                       # [232, 4, 3, 2, 1]
# print(ls)

# # ls.clear()                                  # []
# # print(ls)   
# ls.append(67)                               # [232, 4, 3, 2, 1, 67]
# ls.append(77)                               # [232, 4, 3, 2, 1, 67, 77]
# ls.append(67)                               # [232, 4, 3, 2, 1, 67, 77, 67]
# print(ls)                                   # [232, 4, 3, 2, 1, 67, 77, 67]
# print(ls.count(67))                         # 2

# ls.extend([123,321,432,321])                # [232, 4, 3, 2, 1, 67, 77, 67, 123, 321, 432, 321]
# print(ls)

# ls.insert(0,999)
# print(ls)                                   # [999, 232, 4, 3, 2, 1, 67, 77, 67, 123, 321, 432, 321]

# ls.reverse()
# print(ls)

# ls2 = [i**2 for i in range(1,10)]               
# print(ls2)                                      # [1, 4, 9, 16, 25, 36, 49, 64, 81]

# ls2 = [i**2 for i in range(1,10) if i%2==0] 
# print(ls2)                                      # [4, 16, 36, 64]
#################################################################################################################

# 5. dict
print("-------- dict --------")

# dict1 = {}
# print(dict1)                                # Empty dict
# dict1 = {"a":20, "b": 40}
# print(dict1)                                # {'a': 20, 'b': 40}
# dict1.clear()
# print(dict1)                                # Clears the dict
# dict1 = {"a":20, "b": 40, "c": [11,22,33]}
# print(dict1.get("a"))                       # 20
# print(dict1.get("c"))                       # [11, 22, 33]

# print(dict1.values())                       # dict_values([20, 40, [11, 22, 33]])
# print(dict1.keys())                         # dict_keys(['a', 'b', 'c'])

# for i in dict1.keys():
#     if i == "a":
#         print(i)                            # a

# for i in dict1.values():
#     print(i)                                # 20 \n40 \n[11, 22, 33]

# print(dict1.get('a') == "Hutu")             # False
# print(dict1)

# student = dict(name="Zakir", city="Indore", age=35)
# print(student['name'])                          # Zakir

# print(student.get('name'))                      # Zakir   : Safe way

# student['city'] = 'Mumbai'
# print(student)                                  # {'name': 'Zakir', 'city': 'Mumbai', 'age': 35}

# student['profession'] = 'Standup'
# print(student)                                  # {'name': 'Zakir', 'city': 'Mumbai', 'age': 35, 'profession': 'Standup'}

# del student['age']
# print(student)                                  # {'name': 'Zakir', 'city': 'Mumbai', 'profession': 'Standup'}

# print(student.pop('profession'))                # Standup <> Removes key-value pair of last index. Here 'profession'.
# print(student)                                  # {'name': 'Zakir', 'city': 'Mumbai'}

# student.popitem()
# print(student)                                  # {'name': 'Zakir'}

# actor = {"name": "Brad Pitt", "wood": "Hollywood", "total_films": 150, "top3": ["Fight Club", 'Se7en', 'Once upon a time in Hollywood']}
# print(actor)                                    # {'name': 'Brad Pitt', 'wood': 'Hollywood', 'total_films': 150, 'top3': ['Fight Club', 'Se7en', 'Once upon a time in Hollywood']}

# print("name" in actor)                          # True
# print("name" in actor.keys())                   # True
# print("Name" in actor)                          # False

# print("Brad Pitt" in actor.values())            # True

# for i,j in actor.items():
#     print(i)
#     print(j,"\n")

# """
# o/p:
# name
# Brad Pitt 

# wood
# Hollywood 

# total_films
# 150 

# top3
# ['Fight Club', 'Se7en', 'Once upon a time in Hollywood'] 
# """

# new_dict = {"Planets": ["Earth", "Venus", "Mars"]}

# actor = actor | new_dict
# print(actor)                    # {'name': 'Brad Pitt', 'wood': 'Hollywood', 'total_films': 150, 'top3': ['Fight Club', 'Se7en', 'Once upon a time in Hollywood'], 'Planets': ['Earth', 'Venus', 'Mars']}
# # or 
# # actor = actor.update(new_dict)
# # print(actor)                  # {'name': 'Brad Pitt', 'wood': 'Hollywood', 'total_films': 150, 'top3': ['Fight Club', 'Se7en', 'Once upon a time in Hollywood'], 'Planets': ['Earth', 'Venus', 'Mars']}

# dict3 = {x:x*2 for x in range(10)}
# print(dict3)


#################################################################################################################

# 6. set
print("-------- set --------")

# s1 = {}
# print(type(s1))                             # <class 'dict'>
# s1 = set()
# print(type(s1))                             # <class 'set'>

# s1 = {23,25,24,25,63,45,36,25,66,25}                          
# print(s1)                                   # {66, 36, 23, 24, 25, 45, 63} <> Removes duplicates

# s1.add(232) 
# print(s1)                                   # {232, 66, 36, 23, 24, 25, 45, 63} : <> Unordered
# s1.add(333)                                 # 
# s1.add(666)                                     
# print(s1)                                   # {66, 333, 23, 24, 25, 666, 36, 232, 45, 63}       # <> Unordered

# s1 = {i for i in range(10)}                     # {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
# print(s1)


#################################################################################################################

# 7. tuple
print("-------- tuple --------")

# s1 = ()
# # print(s1)                                       # Empty tuple
# # print(type(s1))                                 # <class 'tuple'>              

# s1 = (i**2 for i in range(10))                  # There is no tuple comprehension syntax in Python.
# print(s1)                                       # <generator object <genexpr> at 0x0000026CFB4D8EE0>

#################################################################################################################

# *args and **kwargs:

def order_pizza(size: str, *args: tuple, **kwargs: dict):
    pass

# *args added:
def order_pizza(size, *toppings):
    print(f"You have ordered {size} sized Pizza!")
    print(f"You have added following toppings on your Pizza!")
    for i in toppings:
        print(f"- {i}")

    return ""

# print(order_pizza('Mid', "pepporoni", "pepe"))

# **kargs added:
def order_pizza(size, *toppings, **details):
    print(f"You have ordered {size} sized Pizza!")
    print(f"You have added following toppings on your Pizza!")
    for i in toppings:
        print(f"- {i}")
    print(f"Extra details are as follows:")
    for i,j in details.items():
        print(f"- {i}: {j}")

    return ""                   # Deliberately put "", since do not want to print None

# print(order_pizza('Mid', "pepporoni", "pepe", city='Mumbai', tips=99))


#######################################################
# Unpacking
# Unpacking means taking values from an iterable (like a list, tuple, string, or dictionary) 
# and assigning them to multiple variables in one step.

# nums = [23,55,32]

# print(type(nums), nums)
# print(*nums)

# x,y,z = nums            
# print("x", x)
# print("y", y)
# print("z", z)


###############################################################################################
# Type Hint:
# Type hints are a formal syntax used to declare the expected data types of variables, function arguments, and return values.

# x : str = "Hello World!"        # Variable type hint
# print(x)

# def add(a: int | float, b: int) -> int | float:         # Function type hint
#     return a+b

# obj1 = add(15,5)
# print(type(obj1), obj1)