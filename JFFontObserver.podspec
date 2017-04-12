Pod::Spec.new do |s|
s.name             = 'JFFontObserver'
s.version          = '1.0.2'
s.summary          = 'JFFontObserver is used to update fonts and / or UI when a user changes their device font.'
s.description      = <<-DESC
JFFontObserver is used to update fonts and / or UI when a user changes their device font. It uses a simple observer approach to run font and / or UI update blocks.
DESC
s.homepage              = 'https://github.com/jfuellert/JFFontObserver'
s.license               = { :type => 'MIT', :file => 'LICENSE' }
s.author                = { 'jfuellert' => 'jfuellert@gmail.com' }
s.source                = { :git => 'https://github.com/jfuellert/JFFontObserver.git', :tag => s.version }
s.ios.deployment_target = '6.0'
s.osx.deployment_target = '10.11'
s.requires_arc          = true

s.source_files        = 'JFFontObserver/JFFontObserver/**/*.{h,m}'
s.public_header_files = 'JFFontObserver/JFFontObserver/**/*.{h}'

end
