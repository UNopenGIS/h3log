require 'lmdb'
require 'json'
require 'h3'

DB = ENV['DB']

db = LMDB::new(DB).database

db.each {|k, v|
  h3 = k.unpack('Q>').first
  pomo = v.unpack('Q>').first
  f = {
    :type => 'Feature',
    :geometry => JSON.parse(
      H3::coordinates_to_geo_json([H3::to_boundary(h3)])
    ),
    :properties => {
      :pomo => pomo
    }
  }
  print JSON.dump(f), "\n"
}

