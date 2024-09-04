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
	busybox httpd -f -p 8000 -h docs
	#ruby -run -e httpd docs -p 8000 # Seems no support for Range Request

docs/planet.pmtiles: 
	curl -o docs/planet.pmtiles -C - https://tile.openstreetmap.jp/static/planet.pmtiles

docs/gel.pmtiles:
	curl -o docs/gel.pmtiles -C - https://data.source.coop/smartmaps/gel/gel.pmtiles

sprite:
	curl -o docs/sprite.json https://openmaptiles.github.io/positron-gl-style/sprite.json
	curl -o docs/sprite@2x.json https://openmaptiles.github.io/positron-gl-style/sprite@2x.json
	curl -o docs/sprite.png https://openmaptiles.github.io/positron-gl-style/sprite.png
	curl -o docs/sprite@2x.png https://openmaptiles.github.io/positron-gl-style/sprite@2x.png

ubx:
	ubxtool -d BINARY
	ubxtool -e NMEA

