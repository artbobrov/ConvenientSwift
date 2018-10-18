Pod::Spec.new do |s|
  s.name             = "ConvenientSwift"
  s.version          = "1.0.0"
  s.summary          = "A short description of ConvenientSwift."
  s.homepage         = "https://github.com/artbobrov/ConvenientSwift"
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { "Artem Bobrov" => "artembobrov3059@gmail.com" }
  s.source           = { git: "https://github.com/artbobrov/ConvenientSwift.git", tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/artbobrov'
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.ios.source_files = 'ConvenientSwift/Sources/**/*.{swift}'
  # s.resource_bundles = {
  #   'ConvenientSwift' => ['ConvenientSwift/Sources/**/*.xib']
  # }
  # s.ios.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'Eureka', '~> 4.0'
end
