require 'lmdb'
require 'h3'
require 'json'

DB = ENV['DB']
RESOLUTION = ENV['RESOLUTION'].to_i

env = LMDB::new(DB,
  :nosync => true, :nometasync => true,
  :writemap => true, :mapasync => true,
  :mapsize => 100 * 1024 * 1024 * 1024
)
db = env.database

count = 0
while gets
  r = JSON.parse($_)
  next unless r['class'] == 'TPV' && r['mode'] == 3
  h3 = H3::from_geo_coordinates([r['lat'], r['lon']], RESOLUTION)
  pomo = Time.now.to_i / 1800
  env.transaction {|txn|
    db[[h3].pack('Q>')] = [pomo].pack('Q>')
    print "."
    count += 1
  }
  if count % 180 == 0
    env.sync
    print "sync[#{Time.now}]"
  end
end

