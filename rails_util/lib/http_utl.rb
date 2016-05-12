
class HttpUtl
  
  class FilelessIO < StringIO
    attr_accessor :original_filename
    attr_accessor :content_type
  end
  
  
  def create_uploaded_file(filepath, type = "image/jpeg")
    filepath = File.join(Rails.root, filepath)
    ActionDispatch::Http::UploadedFile.new(
      tempfile: File.open(filepath),
      filename: File.basename(filepath),
      type: type
      )
  end
  
  
  def self.convert_base64_to_uploaded_file(base64_file, filename, type = "image/jpeg")
    header, image_data = base64_file.split(',')
    if header && header =~ /(image\/[a-z]*);/
      type = $1 # headerのtype値を優先
    end
    
    io = FilelessIO.new(Base64.decode64(image_data))
    io.original_filename = add_ext(filename,type)
    ActionDispatch::Http::UploadedFile.new(
      tempfile: io,
      filename: io.original_filename,
      type: type)
  end
  
  # burowser: Safari, Firefox, Internet Explorer, Chrome, Opera
  # platform: Macintosh, Windows, An
  # os: Windows Vista
  # def judge_browse(request, )
  #   Browser = Struct.new(:browser, :version)
  #   supported = []
  #   Browser.new("Safari", "3.1.1")
  #   user_agent = UserAgent.parse(request.user_agent)
  #   supported.detect { |browser| user_agent >= browser }
  # end
  
  private
  
  def self.add_ext(filename, type)
    case type
    when /jpeg$/
      filename << ".jpg" unless filename =~ /jpg$/
    when /png$/
      filename << ".png" unless filename =~ /png$/
    when /gif$/
      filename << ".gif" unless filename =~ /gif$/
    end
    filename
  end
end
