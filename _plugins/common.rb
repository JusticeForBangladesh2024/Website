module Common

  def self.read_data_files_videos(site)
    videos = []
    videos_dir_items = site.data['video-sources']
    videos_dir_items.each do | video_item |
      # For some reason, video_item is an array, first item is the filename and second item is content
      file_name = video_item[0] + '.yml'
      video = video_item[1]
      video["filename"] = file_name
      videos << video
    end

    videos = sort_videos_by_filename_prefix(videos)
    videos
  end

  def self.sort_videos_by_filename_prefix(videos)
    videos.sort_by { |hash| hash["filename"][0, hash["filename"].index('-')].to_i }
  end

  def self.to_slug(value)
    value.gsub!(/[']+/, '')
    value.gsub!(/[&]+/, 'and')
    value.gsub!(/[*]+/, 'star')
    value.strip!
    value.gsub!(' ', '-')
    value
  end

  def self.create_file(path, extension)
    dir = File.dirname(path)
    unless File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end
    path << ".#{extension}"
    File.new(path, 'w')
  end

  def self.generate_json(site, path, obj)
    json_file = Common.create_file("./generated/" + path, "json")
    json_file.puts(JSON.pretty_generate(obj))
    json_file.close
    site.static_files << DynamicStaticFile.new(site, site.source, "/generated/", path + ".json", "/assets/")
  end

  def self.append_to_file(path, obj)
    txt_file = File.open(path, 'a')
    txt_file.write(obj)
    txt_file.close
  end

  class DynamicStaticFile < Jekyll::StaticFile
    def initialize(site, base, dir, name, dest)
      super(site, base, dir, name)
      @name = name
      @dest = dest
    end
    def destination(dest)
      @destination ||= {}
      @destination[@dest] ||= @site.in_dest_dir(@dest, Jekyll::URL.unescape_path(url))
    end
  end

end
