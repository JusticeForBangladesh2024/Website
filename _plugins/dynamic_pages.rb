module DynamicPagesPlugin
  class Generator < Jekyll::Generator
    def generate(site)
      videos = Common.read_data_files_videos(site)
      videos.each do |video|
        site.pages << VideoPage.new(site, site.source, '', "#{video['id']}.html", video)
      end
    end
  end

  class VideoPage < Jekyll::Page
    def initialize(site, base, dir, name, video)
      @site = site
      @base = base
      @dir  = dir
      @name = name
      self.process(name)
      self.read_yaml(File.join(base, '_layouts'), 'video-page.html')
      self.data.merge!('video' => video)
    end
  end
end