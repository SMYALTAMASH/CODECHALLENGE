# CHALLENGE3: We have a nested object. We would like a function where you pass in the object and a key and get back the value.

# Test cases for the code

* Invalid input: a simple JSON object with a single key and value, and a valid key string:

```
Enter a JSON object: {"a": "b"}
Enter a key: a
The value for key a is: b
```

* Invalid input: a JSON object with a syntax error, and a valid key string:

```
Enter a JSON object: {"a": "b"
Invalid JSON object. Please try again.
Enter a JSON object: {"a": "b"}
Enter a key: a
The value for key a is: b
```

* Invalid input: a valid JSON object, and an invalid key string:

```
Enter a JSON object: {"a": {"b": "c"}}
Enter a key: x
Invalid key. Please try again.
Enter a key: a/b/c
Invalid key. Please try again.
Enter a key: a/b
The value for key a/b is: {"c": "d"}
```

* Invalid input: a JSON object with nested objects and an invalid key string:

```
Enter a JSON object: {"a": {"b": {"c": "d"}}}
Enter a key: a/b/c/d
Invalid key. Please try again.
Enter a key: a/b/c
The value for key a/b/c is: d
```

* Invalid input: reaching the maximum number of attempts for input validation:

```
Enter a JSON object: {"a": {"b": {"c": "d"}}
Invalid JSON object. Please try again.
Enter a JSON object: {"a": {"b": {"c": "d"}}
Invalid JSON object. Please try again.
Enter a JSON object: {"a": {"b": {"c": "d"}}
Maximum attempts reached. Exiting program.
```
