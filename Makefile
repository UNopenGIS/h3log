DB = db
RESOLUTION = 11

clean:
	rm -r $(DB)

log: 
	gpspipe -w | DB=$(DB) RESOLUTION=$(RESOLUTION) ruby log.rb

pmtiles:
	DB=$(DB) ruby to_geojsons.rb | tippecanoe -f -o docs/h3log.pmtiles -l h3log

h3j:
	DB=$(DB) ruby to_h3j.rb > docs/h3log.h3j

dump:
	DB=$(DB) ruby to_geojsons.rb

serve:
	ruby -run -e httpd docs -p 8000

docs/planet.pmtiles: 
	curl -o docs/planet.pmtiles -C - https://tile.openstreetmap.jp/static/planet.pmtiles

ubx:
	ubxtool -d BINARY
	ubxtool -e NMEA

