import './maplibre-gl.js'
import './h3j_h3t.js'

let protocol = new pmtiles.Protocol()
maplibregl.addProtocol('pmtiles', protocol.tile)

const map = new maplibregl.Map({
  container: 'map',
  style: 'style.json', maxPitch: 85, 
  center: [139.75728, 35.69025],
  zoom: 12.24, hash: true, localIdeographFontFamily: 
  '"HiraginoSans-W6", "Hiragino Sans W6", "Hiragino Sans", "HGP創英角ｺﾞｼｯｸUB", "Meiryo", "sans900", sans-serif'
})
map.addControl(new maplibregl.FullscreenControl())
map.addControl(new maplibregl.NavigationControl())
map.addControl(new maplibregl.TerrainControl({ "source": "gel-raster-dem" }))
map.addControl(new maplibregl.ScaleControl({ "unit": "metric" }))
map.addControl(new maplibregl.GeolocateControl())

map.on('load', e => {
  map.addH3JSource('h3log_pg', {
    data: 'h3log.h3j', attribution: "UN Smart Maps Group", geometry_type: 'Polygon',
    minzoom: 10
  }).then(m => m.addLayer({
    id: 'h3log_pg', type: 'line', source: 'h3log_pg',
    paint: {
      'line-color': 'rgb(92, 129, 184)',
      'line-opacity': [
        'interpolate',
        ['linear'],
        ['zoom'],
        10, 1,
        10.5, 1
      ],
      'line-width': [
        'interpolate',
        ['exponential', 2],
        ['zoom'],
        10, 3,
        16, 16 
      ], 
      'line-blur': 5
    }
  }))
  map.addH3JSource('h3log_pt', {
    data: 'h3log.h3j', attribution: "UN Smart Maps Group", geometry_type: 'Point',
    maxzoom: 10
  }).then(m => m.addLayer({
    id: 'h3log_pt', type: 'circle', source: 'h3log_pt',
    maxzoom: 10.5,
    paint: {
      'circle-color': 'rgb(92, 129, 184)',
      'circle-opacity': [
        'interpolate',
        ['linear'],
        ['zoom'],
        10, 1,
        10.5, 0
      ],
      'circle-radius': [
        'interpolate',
        ['linear'],
        ['zoom'],
        2, 0.1,
        10, 1
      ]
    }
  }))
})

