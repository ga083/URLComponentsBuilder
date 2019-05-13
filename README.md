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
    "username": "Stärk",
    "password": "%&34",
    "isSuperhero": true,
    "weightKg": 75.8,
    "phones": ["mobile": "123456789", "office": "123987456"]]

var urlComponents = URLComponentsBuilder()
        .setScheme("http")
        .setHost("urlbuilder.com")
        .setPath("/buildSuit/")
        .addQuery(items: query)
        .build()

print(urlComponents.url!.absoluteString)
```
#### Output:
http://urlbuilder.com/buildSuit/?isSuperhero=1&name=Tony&password=%25%2634&phones%5Bmobile%5D=123456789&phones%5Boffice%5D=123987456&username=St%C3%A4rk&weightKg=75.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
