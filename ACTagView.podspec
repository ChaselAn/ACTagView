Pod::Spec.new do |s|
    s.name         = 'ACTagView'
    s.version      = '2.3.0'
    s.summary      = 'Swift4版本的标签页'
    s.homepage     = 'https://github.com/ChaselAn/ACTagView'
    s.license      = 'MIT'
    s.authors      = {'ChaselAn' => '865770853@qq.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/ChaselAn/ACTagView.git', :tag => s.version}
    s.source_files = 'ACTagViewDemo/ACTagView/*.swift'
    s.requires_arc = true
    s.swift_version = '5.0'
end
