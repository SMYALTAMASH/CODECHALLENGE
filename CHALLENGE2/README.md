# CHALLENGE 3: Retrieve the metadata of an instance by taking user input.

* The main function is the entry point of the program. It prompts the user to enter a key to retrieve from the metadata or to leave the input blank to retrieve all the metadata.

* If a key is entered, the retrieveMetadata function is called with the specified key. If the returned metadata is not empty, it is printed to the console in a pretty-printed JSON format using the json.dumps function. If the returned metadata is empty, an error message is displayed to the user.

* If no key is entered, the retrieveMetadata function is called without any arguments to retrieve all the metadata. The metadata is then printed to the console in a pretty-printed JSON format.

# Output

* Retrieving the AMI ID:

```
$ python main.py
Enter a key to retrieve (leave blank to retrieve all metadata): ami-id
{
    "id": "ami-0ab12cd34e5678f90"
}
```

* Retrieving the network interface device index:

```
$ python main.py
Enter a key to retrieve (leave blank to retrieve all metadata): network/interfaces/macs/98:0c:82:9a:e9:39/device-number
{
    "number": "0"
}
```

* Retrieving the security group ID:

```
$ python main.py
Enter a key to retrieve (leave blank to retrieve all metadata): security-groups
{
    "groups": ["sg-0ab12cd34e5678f90"]
}
```

* Retrieving a nested object:

```
$ python main.py
Enter a key to retrieve (leave blank to retrieve all metadata): network/interfaces/macs/<mac>
{
    "interface-id": "eni-0ab12cd34e5678f90",
    "local-hostname": "ip-10-0-0-123.ec2.internal",
    "local-ipv4s": ["10.0.0.123"],
    "mac": "12:34:56:78:90:ab",
    "owner-id": "0123456789",
    "public-hostname": "ec2-54-123-456-789.compute-1.amazonaws.com",
    "public-ipv4s": ["54.123.456.789"],
    "security-group-ids": ["sg-0ab12cd34e5678f90"],
    "subnet-id": "subnet-0ab12cd34e5678f90",
    "subnet-ipv4-cidr-block": "10.0.0.0/24",
    "vpc-id": "vpc-0ab12cd34e5678f90"
}
```


