import requests
import json

url = "http://127.0.0.1:8080/api/validate-customers"

payload = [
    {
        "id": "1",
        "firstName": "John",
        "lastName": "Doe",
        "company": "ABC Corp",
        "city": "New York"
    },
    {
        "id": "2",
        "firstName": "Alice",
        "lastName": "Smith",
        "company": "XYZ Ltd",
        "city": "London"
    },
    {
        "id": "3",
        "firstName": "Bob",
        "lastName": "Taylor",
        "company": "Tech Ltd",
        "city": "Berlin"
    }
]

headers = {
    "Content-Type": "application/json",
    "Accept": "text/event-stream"
}

with requests.post(url, data=json.dumps(payload), headers=headers, stream=True) as response:
    print("Connected...\n")
    print(response)
    for line in response.iter_lines():
        if line:
            decoded = line.decode("utf-8")
            print(decoded)