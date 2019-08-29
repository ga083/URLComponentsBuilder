# URLComponentsBuilder
### A static library that offers a builder pattern for URLComponents to simplify setting query parameters
Translates a 'Dictionary' to 'URLQueryItem(s)'. Simplifies setting query parameters, avoiding the cumbersome task of representing arrays and dictionaries in an URL query.

## Install

#### Cocoa Pods
Requires Cocoapods 1.5.0 or above.

```ruby
target '<you project target>' do
    pod 'URLComponentsBuilder'
end
```

#### Or just copy this file into your project
URLComponentsBuilder.swift

## Usage example


```swift
let query: [String: Any] = [
    "name": "Tony",
    "username": "Stark",
    "password": "%&34",
    "isSuperhero": true,
    "weightKg": 75.8,
    "phones": ["mobile": "123456789",
               "office": "123987456"],
    "homes": [["name": "Point Dume", "address": "10880 Malibu Point"],
               ["name": "Stark Tower", "address": "200 Park Avenue"]],
    "belongings": ["cars": ["1932 Ford Flathead Roadster",
                            "1967 Shelby Cobra",
                            "Saleen S7"], 
                   "motorcycles": ["zero eng type6"]]]

var urlComponents = URLComponentsBuilder()
        .setScheme("http")
        .setHost("superherobuilder.com")
        .setPath("/buildSuit/")
        .addQuery(items: query)
        .build()

print(urlComponents.url!.absoluteString)
```
Output:
http://superherobuilder.com/buildSuit/?belongings[cars][0]=1932 Ford Flathead Roadster&belongings[cars][1]=1967 Shelby Cobra&belongings[cars][2]=Saleen S7&belongings[motorcycles][0]=zero eng type6&homes[0][address]=10880 Malibu Point&homes[0][name]=Point Dume&homes[1][address]=200 Park Avenue&homes[1][name]=Stark Tower&isSuperhero=1&name=Tony&password=%&34&phones[mobile]=123456789&phones[office]=123987456&username=Stark&weightKg=75.8

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
