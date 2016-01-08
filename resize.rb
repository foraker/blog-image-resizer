HEADER_SIZES = {
  "<file_name>.jpg"    => "820x330",
  "<file_name>@2x.jpg" => "1640x660",
  "<file_name>@3x.jpg" => "2460x990"
}

BACKGROUND_SIZES = {
  "<file_name>-mobile.jpg"    => "480x475",
  "<file_name>-mobile@2x.jpg" => "960x950",
  "<file_name>-mobile@3x.jpg" => "1440x1425",
  "<file_name>.jpg"           => "1440x640",
  "<file_name>@2x.jpg"        => "2880x1280",
  "<file_name>@3x.jpg"        => "4320x1920"
}

file_name = ARGV[0]
image_type = ARGV[1]

unless file_name && ['header', 'background'].include?(image_type)
  puts "Usage: ruby resize.rb file-name header|background"
  exit
end

sizes = image_type == 'header' ? HEADER_SIZES : BACKGROUND_SIZES

sizes.each do |file_name_template, size|
  # We want to strip off any path and the file extension.
  file_name_prefix = file_name.split('/').last.split('.').first

  `convert #{file_name} -resize #{size}\^ -extent #{size} #{file_name_template.gsub('<file_name>', file_name_prefix)}`
end
