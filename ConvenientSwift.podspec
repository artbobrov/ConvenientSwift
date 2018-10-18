Pod::Spec.new do |s|
  s.name             = "ConvenientSwift"
  s.version          = "0.5.0"
  s.summary          = "Some useful Swift extensions for IOS development."
  s.description = <<-DESC
  ConvenientSwift is a library containing some convenient extensions for UIKit, Foundation, CoreGraphics and Swift Standart Library. Also there are some usefull stuff for developing.
                   DESC
  s.homepage         = "https://github.com/artbobrov/ConvenientSwift"
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { "Artem Bobrov" => "artembobrov3059@gmail.com" }
  s.source           = { git: "https://github.com/artbobrov/ConvenientSwift.git", tag: s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.ios.source_files = 'Sources/**/*.{swift}'
end
