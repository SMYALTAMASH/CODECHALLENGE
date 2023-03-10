#!/usr/local/bin/python3
# Function to get the value of a particular key by passing in the json and the path to retrieve a key

import json

# define maximum number of attempts for input validation
max_attempts = 3

# take user input for the JSON object
for i in range(max_attempts):
    obj_str = input("Enter a JSON object: ")
    try:
        obj = json.loads(obj_str)
        break
    except json.JSONDecodeError:
        if i == max_attempts - 1:
            print("Maximum attempts reached. Exiting program.")
            exit()
        print("Invalid JSON object. Please try again.")

# take user input for the key
for i in range(max_attempts):
    key = input("Enter a key: ")
    keys = key.split('/')
    try:
        # check if all keys exist in the object
        val = obj
        for k in keys:
            val = val[k]
        break
    except (KeyError, TypeError):
        if i == max_attempts - 1:
            print("Maximum attempts reached. Exiting program.")
            exit()
        print("Invalid key. Please try again.")

# define the get_value function
def get_value(obj, key):
    keys = key.split('/')
    val = obj
    for k in keys:
        val = val[k]
    return val

# call the get_value function with the user input
value = get_value(obj, key)

print("The value for key", key, "is:", value)

