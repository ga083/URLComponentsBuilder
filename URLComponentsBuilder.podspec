Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '10.0'
  s.swift_version = "4.2"
  s.name = "URLComponentsBuilder"
  s.version = "1.2.0"
  s.summary = "A builder pattern for URLComponents to simplify setting query parameters."
  s.description = <<-DESC
Translates a 'Dictionary' to 'URLQueryItem(s)'. Simplifies setting query parameters, specifically avoiding the cumbersome task of representing arrays and dictionaries in an URL query.
                   DESC
  s.homepage = "https://github.com/ga083/URLComponentsBuilder"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Alexander Solis" => "alexandersv@gmail.com" }
  s.source = { :git => "https://github.com/ga083/URLComponentsBuilder.git", :tag => "#{s.version}" }
  s.source_files = "URLComponentsBuilder", "URLComponentsBuilder/**/*.{h,m}"
  s.framework = "Foundation"
end
