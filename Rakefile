require 'json'

CONFIG = 'config.json'

def get_config(filename)
  JSON.parse File.open(filename).read
end

# Generate exports for running docker-compose
def export_str(config)
  'export ' + config.map do |k, v|
    name = k.gsub(/-/, '_').upcase
    "#{name}=#{v}"
  end.join(' ')
end

begin
  $config = get_config CONFIG
rescue Exception => e
  puts "Could not get configuration: #{e.message}"
  exit 1
end

desc 'Build images'
task :build do
  sh "#{export_str($config)} && docker-compose build"
end

desc 'Start containers'
task :start do
  sh "#{export_str($config)} && docker-compose up -d"
end

desc 'Stop containers'
task :down do
  sh 'docker-compose down'
end
