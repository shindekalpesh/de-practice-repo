
# Three levels of Access:

# Level 1 — Public - Can be freely read and manipulated outside the class:
class Person1:
    
    def __init__(self, name, age, gender):
        self.name = name
        self.age = age
        self.gender = gender

        
p1 = Person1("Wolverine", 30, "Male")
# print(p1.name)

p1.name = "James"
# print(p1.name)

# o/p:
# Wolverine
# James

##################################################################
# Level 2 — Protected - Signals the developer 'Do not touch this' as a gentelmen's agreement. 
# Python does not enforce it, meaning, it still works:

class Person2:
    
    def __init__(self, name, age, gender):
        self._name = name
        self.age = age
        self.gender = gender

        
p1 = Person2("Wolverine", 30, "Male")
# print(p1._name)

p1._name = "James"
# print(p1._name)

# o/p:
# Wolverine
# James

##################################################################
# Level 2 — Private - Python enforcement is active

class Person3:
    
    def __init__(self, name, age, gender):
        self.__name = name
        self.age = age
        self.gender = gender

        
p1 = Person3("Wolverine", 30, "Male")
# print(p1.__name)

p1.__name = "James"
# print(p1.__name)

# o/p"
# Traceback (most recent call last):
#     print(p1.__name)
#           ^^^^^^^^^
# AttributeError: 'Person3' object has no attribute '__name'

##################################################################

class Person4:

    def __init__(self, name, age, gender):
        self.__name = name
        self._age = age
        self.gender = gender

    @property
    def Name(self):                     # Getter
        return self.__name

    @Name.setter
    def Name(self, value):              # Setter
        if value == '':
            self.__name = 'Blank Name'
        else:
            self.__name = value

    

p1 = Person4("Wolverine", 30, "Male")
# print(p1.__name)              # Does not work. Message thrown: AttributeError: 'Person4' object has no attribute '__name'. 
                                # Reason: Because of Name Getter property.

print(p1.Name)                              # Works

p1.Name = ""
print(p1.Name)

p1.Name = "Logan"
print(p1.Name)

print(p1.__dict__)              # __dict__ : used for debugging. Gives the output as data attributes in the form of dictionary.

print(p1._Person4__name)        # Here the private variable is STILL accessible, which defeats out logic of restricting data access via 
                                # Encapsulation.
                                # Hence, this proves that Python does not DIRECTLY SUPPORT ENCAPSULATION BUT HELPS IN PREVENTING 
                                # ACCIDENTAL DATA MODIFICATIONS as mentioned above.


##################################################################

class Person5:

    def __init__(self, name, age, gender):
        self.__name = name
        self._age = age
        self.gender = gender

    @property
    def Name(self):                     # Getter
        return self.__name

    @Name.setter
    def Name(self, value):              # Setter
        if value == '':
            self.__name = 'Blank Name'
        else:
            self.__name = value

    @staticmethod
    def my_method():                # staticmethod is not object specific methods. That means it is not required to pass 'self'.
                                    # Hence it is class based.
        print("Hello world!")

p1 = Person5("Wolverine", 30, "Male")
print("p1", type(p1), p1)

Person5.my_method()

######################################### DUNDER METHODS #########################################

print("\n\n\nDunder Methods Starts From Here!\n\n")

# Dunder methods are the special methods that lets your objects work with python's inbuilt syntax and operators.

# 1. Object creation:
# __init__ : call it when a new object is created. Think of it as constructor initializer.
# It directly takes object attributes.

class Employee:

    def __init__(self, name, salary):
        self.name = name
        self.salary = salary

e1 = Employee("Martin", 400000)
print("e1", type(e1), e1)                   # Gives o/p as type class and object address : 
                                            # e1 <class '__main__.Employee'> <__main__.Employee object at 0x0000016554568C20>
print("e1.name", type(e1.name), e1.name)


# 2. __new__():
# Actually creates the object before __init__() runs.

class Employee:

    def __new__(cls, *args, **kwargs):
        print("Creating object")
        return super().__new__(cls)
    
    def __init__(self, name, salary):
        print("Initializing object")
        self.name = name
        self.salary = salary


e1 = Employee('Walia', 900000)
print(e1)

# 3. String Representation
# __str__(): Controls the representation of the object. What print(e1) shows.

class Employee:

    def __init__(self, id, name, salary):
        print("Initializing object")
        self.id = id
        self.name = name
        self.salary = salary

    def __str__(self):
        return f"id={self.id} - name={self.name}"
    

e1 = Employee(1001, 'Walia', 900000)
print(e1)

# 4. __repr__():
# Developer-friendly representation

class Employee:

    def __init__(self, id, name, salary):
        print("Initializing object")
        self.id = id
        self.name = name
        self.salary = salary

    def __repr__(self):
        return f"Employee(id={self.id}, name={self.name}, salary={self.salary}"
    
e1 = Employee(1002, 'Walter', 1900000)
print(repr(e1))