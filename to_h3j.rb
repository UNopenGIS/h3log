require 'lmdb'
require 'json'

DB = ENV['DB']

db = LMDB::new(DB).database

doc = { :cells => [] }

db.each {|k, v|
  h3 = k.unpack('Q>').first
  pomo = v.unpack('Q>').first
  doc[:cells].push({
    :h3id => h3.to_s(16),
    :pomo => pomo
  })
}

print JSON.dump(doc), "\n"
