Pod::Spec.new do |s|
    s.name         = 'ACTagView'
    s.version      = '1.0.0'
    s.summary      = 'Swift3.0版本的标签页'
    s.homepage     = 'https://github.com/ChaselAn/ACTagView'
    s.license      = 'MIT'
    s.authors      = {'ChaselAn' => '865770853@qq.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/ChaselAn/ACTagView.git', :tag => s.version}
    s.source_files = 'ACTagViewDemo/ACTagViewDemo/ACTagView/*.swift'
    s.requires_arc = true
end
