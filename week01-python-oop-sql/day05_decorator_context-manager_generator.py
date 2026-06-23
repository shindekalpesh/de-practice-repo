"""
decorator,
context manager 'with',
generator (yield)
"""

# 1. Define the decorator function which takes main function as input
def greet(fx):          # decorator function
    # 2. Define an inner wrapper function aka modified (wrapped/extended) main function
    def mfx(*args):
        print("Something happening BEFORE the main function is called")

        result = fx(*args)       # Executes the original main function

        print("Something happening AFTER the main function is called")

        # 3. Return the modified (wrapped/extended) main function    
        return result
    
    return mfx

# 4. Apply the decorator using @
# @greet
# def add(a,b):
#     print(a + b)                          # Showing output

# print(add(3,4))
# print(add(2,2))

# 4. Apply the decorator using @
@greet
def add_3(*args):
    print(">", args)
    # print(sum(args))                      # Showing output
    return sum(args)                        # Showing None

# print(add_3(2,3,4,5))
# print(add_3())


# Imagine you have ETL pipeline functions and you want to know when each step starts and ends.

def my_logger(func):
    def wrapper(*args, **kwargs):
        print(f"Running: {func.__name__}")
        result = func(*args, **kwargs)
        print(f"Completed: {func.__name__}")

        return result
    return wrapper

@my_logger
def extract():
    print("Reading data from source.")

@my_logger
def transform():
    print("Performing some transformation operations.")

# extract()
# transform()

##############################################################################

# Context manager 'with':
# Definition: context managers are used for resource allocation and release by handling resource setup and teardown.

# One way:
# file = open("avengers_assemble.txt", "a")
# file.write("Shaktiiiiiiimaaaaannnnnn!!!\n")
# file.close()

# Alternative, best and safe way with context manager:

# with open("avengers_dont_assemble.txt", "a") as data:
#     data.write("I am Ironman!")


# Creating a custom context manager class:

class File:
    def __init__(self, filename, method):
        self.file = open(filename, method)

    def __enter__(self):
        print("Entering...")
        return self.file
        
    def __exit__(self, exc_type, exc, tb):
        print("Exiting...")
        self.file.close()


with File("Gokuldham.txt", "a") as file:
    file.write("Jethiyaaaaa!\n")


##############################################################################

# Generators are used to generate or yield sequence of values on-the-fly.
# This means it does not stores and consumes memory like lists.
# Instead it yields the values on-the-fly (when required)!
# When to use a generator?
# Once you create a generator, it can be used in:
    # - a for loop
    # - list comprehension
    # - generator expression

def my_generator():
    for i in range(100):
        yield i

gen = my_generator()
# print(next(gen))
# print(next(gen))
# print(next(gen))
# print(next(gen))
# print(next(gen))

file_path = "generator-example-finalapi.csv"
with open(file_path) as f:
    data = f.readlines()
    # print(len(data))

def file_opener_generator():
    with open(file_path) as f:
        for i in f:
            yield i

final_api_gen = file_opener_generator()
# print(next(final_api_gen))
# print(next(final_api_gen))
# print(next(final_api_gen))
# print(next(final_api_gen))
# print(next(final_api_gen))