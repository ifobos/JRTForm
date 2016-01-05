Pod::Spec.new do |s|
  s.name         = "JRTForm"
  s.version      = "0.0.3"
  s.summary      = "JRTForm framework to create forms"
  s.homepage     = "https://github.com/ifobos/JRTForm"
  s.license      = "MIT"
  s.author       = { "ifobos" => "juancarlos.garcia.alfaro@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/ifobos/JRTForm.git", :tag => "0.0.3" }
  s.source_files = "JRTForm/JRTForm/PodFiles/*.{h,m}"
  s.resources    = "JRTForm/JRTForm/PodFiles/*.{png,bundle,xib,nib}"
  s.requires_arc = true
end
