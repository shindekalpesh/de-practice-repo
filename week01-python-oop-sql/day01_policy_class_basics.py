"""
Day 1 -- OOP basics: classes, instances, __init__, self
Refactoring a procedural premium calculator into a class.

This is meant to look like REAL Day 1 work: a bit rough, with comments
to self where something didn't click immediately. That's fine. The point
is finishing and committing, not perfection.
"""


# procedural way of writing:
def calculate_premium_procedural(policy_type: str, sum_assured: int | float, age: int):
    if policy_type == 'term':
        return sum_assured * 0.002 * (1 + age / 100)
    elif policy_type == 'life':
        return sum_assured * 0.004 * (1 + age / 100)
    else:
        return "policy_type not found!"
    
print("calculate_premium_procedural('term', 1000, 30)", type(calculate_premium_procedural("term", 1000, 30)), calculate_premium_procedural("term", 1000, 30))

# class based logic:
class Policy:
    """
    Base class for life insurance policy.
    """

    # class attribute -- shared by every Policy instance, not per object.
    policy_count = 0

    def __init__(self, policy_no: str, customer_name: str, sum_assured: int | float, age: int):
        self.policy_no = policy_no
        self.customer_name = customer_name
        self.sum_assured = sum_assured
        self.age = age

        # Using class name here, not self, because this is the shared STATE across all the instances.
        Policy.policy_count += 1


    def __repr__(self):
        return f"Policy(id={self.policy_no}, customer_name={self.customer_name})"


# print(Policy("POL001", "Asha Kulkarni", 500000, 32))

if __name__ == '__main__':
    """
    if __name__ == '__main__': is used to make sure some code runs only when the file is executed directly, not when it is imported as a module.
    """
    p1 = Policy("POL001", "Asha Kulkarni", 500000, 32)
    p2 = Policy("POL002", "Rahul Mehta", 1000000, 45)

    print(p1)  # uses __repr__
    print(p2)
    print("Total policies created so far:", Policy.policy_count)

    # confirms policy_count is shared across instances, not per-object --
    # this is the thing that didn't click until I actually ran it and saw 2
