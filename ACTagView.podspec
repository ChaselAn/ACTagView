Pod::Spec.new do |s|
    s.name         = 'ACTagView'
    s.version      = '0.1.0'
    s.summary      = 'tag view for wechat'
    s.homepage     = 'https://github.com/ChaselAn/ACTagView'
    s.license      = 'MIT'
    s.authors      = {'ChaselAn' => '865770853@qq.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/ChaselAn/ACTagView.git', :tag => s.version}
    s.source_files = 'ACTagView/ACTagView/*.swift'
    s.requires_arc = true
end
