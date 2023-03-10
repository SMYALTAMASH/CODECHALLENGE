#!/usr/local/bin/python3
# Function to retrieve the metadata of an instance
import requests
import json

def retrieveMetadata(key=None):
    url = "http://169.254.169.254/latest/meta-data/"
    if key:
        url += key
    response = requests.get(url)
    metadata = response.text

    # Check if metadata is a nested object
    if '/' in metadata:
        # Split the key path into individual keys
        keys = metadata.split('/')
        # Iterate over each key to get the corresponding nested object
        for k in keys:
            response = requests.get(url + k)
            response.raise_for_status()
            metadata = json.loads(response.text)
    else:
        metadata = json.loads(metadata)

    return metadata


def main():
    try:
        key = input("Enter a key to retrieve (leave blank to retrieve all metadata): ")
        if key:
            metadata = retrieveMetadata(key)
            if metadata:
                print(json.dumps(metadata, indent=4))
            else:
                print("Error: Invalid key or key does not exist")
        else:
            metadata = retrieveMetadata()
            print(json.dumps(metadata, indent=4))
    except Exception as e:
        print("Error: {}".format(e))


if __name__ == '__main__':
    main()

