"""
property decorator, polymorphism: runtime polymorphism (duck typing, method overriding and abstract base class ABC) and operator overloading, abstraction via Abstract Base Class (ABC)
"""

class Student:

    def __init__(self, phy, chem, math):
        self.phy = phy
        self.chem = chem
        self.math = math

    # Create another attribute 'calc_percentage':
    def calc_percentage(self):
        return str((self.phy + self.chem + self.math) / 3) + "%"

    # The above method calc_percentage works properly.
    # But when an attribute's value depends upon a function, then we can use @property decorator
    # on that function in the class to use that method as a property (attribute).

    @property
    def percentage(self):
        return str((self.phy + self.chem + self.math) / 3) + "%"


s1 = Student(98,96,94)
# print("s1.phy", s1.phy)
# print(s1.calc_percentage())

# Update the phy marks from 98 to 88
s1.phy = 88
# print("s1.phy", s1.phy)
# print(s1.calc_percentage())

#####################################
# With property decorator:
s2 = Student(98,96,94)
# print(s2.phy)
# print(s2.percentage)        # percentage became an attribute therefore no '()' required.

s2.phy = 88
# print(s2.phy)
# print(s2.percentage)        # percentage became an attribute therefore no '()' required.

#############################################################################################
# Polymorphism:
# Poly means many and phism means forms. 
# Same interface (class, method, operator) BEHAVES differently depending on type of object.
# There are 4 types of Polymorphism in Python:
    # Type 1: Runtime Polymorphism
        # 1. Duck Typing (most Pythonic)
        # 2. Method Overriding
        # 3. Abstract Base Class (ABC)
    # Type 2: Operator Polymorphism
        # 4. Operators Overloading

#################################################
# 1. Duck Typing: Very pythonic form of Polymorphism
# "If it walks like a duck and quacks like a duck, it is a duck!"
# Python does not check what an object is, it just checks whether it has the method that is being called.

class PDFReport:
    def generate(self):
        return "Generating PDF Report..."
    
class ExcelReport:
    def generate(self):
        return "Generating Excel Report..."
        
class EmailReport:
    def generate(self):
        return "Generating Email Report..."
        
obj1 = PDFReport()
# print(obj1.generate())

obj2 = ExcelReport()
# print(obj2.generate())

obj3 = EmailReport()
# print(obj3.generate())

# So here we can conclude that generate() method works for all without an error, ie, no type checks needed.

#####################################################
# 2. Method Overriding: classic runtime polymorphism
# Subclass redefines parent method to change its behaviour

class Animal:
    def makes_sound(self):
        return "makes some kind of sound."
    
class Lion(Animal):
    def makes_sound(self):
        return "Roars"
    
l1 = Lion()
# print(l1.makes_sound())

# same method call -> different result depending upon the object they belong to.
#####################################################
# 3. Abstract Base Class (ABC):
# The Abstract Base Class (ABC) is not a type of Polymorphism. Instead, ABC provides a common interface that enables polymorphism.
# VERY IMP NOTE: ABC are primarily a mechanism for implementing Abstraction which is one of the pillars of OOP.

from abc import ABC, abstractmethod

class Animal(ABC):
    @abstractmethod
    def makes_sound(self):
        pass
    
class Lion(Animal):
    def makes_sound(self):
        return "100-Raors!"
    
class Dog(Animal):
    def makes_sound(self):
        return "Barks!"
    
class Cat(Animal):
    def makes_sound(self):
        return "Meows!"
    

# eg_3 = Animal()
# print(eg_3.makes_sound())       # TypeError: Can't instantiate abstract class Animal without an implementation for abstract method 'makes_sound'

eg_4 = Lion()
# print(eg_4.makes_sound())


#####################################################
# 4. Operator Overloading:
# When the same operator is allowed to have different meaning according to the context.
"""
Operators & Dunder Methods
Addition :          a + b               ---                 __add__
Substraction :      a - b               ---                 __sub__
Multiplication :    a * b               ---                 __mul__
Division :          a / b               ---                 __truediv__
Division :          a // b              ---                 __floordiv__
"""

print(1 + 3)                # 4
print("Clark"+"Kent")       # ClarkKent <> Concatenated the strings
print([1,2,3]+[4,5,6])      # [1, 2, 3, 4, 5, 6] <> Merged the lists

class Person:
    def __init__(self, x):
        self.x = x

    def __add__(self, other):
        return self.x + other.x
    

p1 = Person("4")
p2 = Person("5")
print(p1 + p2)

# Comparison Operators:
"""
Operator	Dunder Method
==          	__eq__()
!=             	__ne__()
<	            __lt__()
<=	            __le__()
>	            __gt__()
>=	            s__ge__()
"""

class Person:
    def __init__(self, x):
        self.x = x

    def __eq__(self, other):
        return self.x == other.x
    
p1 = Person(50)
p2 = Person(57)

print(p1 == p2)