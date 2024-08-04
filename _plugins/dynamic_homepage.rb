module DynamicHomepagePlugin

  class Generator < Jekyll::Generator
    def generate(site)
      site.data["videos"] = Common.read_data_files_videos(site)
    end
  end
end
