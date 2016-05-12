class ImageUtl
  
  # 画像縮小. 要RMagick.
  def self.reduction(file_path, max_size, output_folder)
    img = Magick::Image.read(file_path).first
    # puts "file name: #{img.filename},  height: #{img.rows} px, width: #{img.columns} px, depth: #{img.depth} bits/px, colors: #{img.number_colors}, file size: #{img.filesize} bytes"
    return if max_size >= img.rows && max_size >= img.columns
    
    img.resize_to_fit!(max_size, max_size)
    
    new_file = File.new("#{output_folder ? output_folder + '/' : ''}#{img.filename}", "w")
    img.write(new_file)
    # puts "file name: #{new_file.path},  height: #{img.rows} px, width: #{img.columns} px, depth: #{img.depth} bits/px, colors: #{img.number_colors}, file size: #{new_file.size} bytes"
  end
  
end
