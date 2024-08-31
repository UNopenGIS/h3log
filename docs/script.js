import 'https://unpkg.com/maplibre-gl/dist/maplibre-gl.js';
import './h3j_h3t.js';

const map = new maplibregl.Map({
  container: 'map',
  style: 'https://basemaps.cartocdn.com/gl/positron-gl-style/style.json',
  center: [139.75728, 35.69025],
  zoom: 12.24, hash: true, localIdeographFontFamily: 
  '"HiraginoSans-W6", "Hiragino Sans W6", "Hiragino Sans", "HGP創英角ｺﾞｼｯｸUB", "Meiryo", "sans900", sans-serif'
})

map.on('load', e => {
  map.addH3JSource( 'h3log', {
    data: 'h3log.h3j', attribution: "UN Smart Maps Group"
  }).then(m => m.addLayer({
    id: 'h3log', type: 'line', source: 'h3log',
    paint: {
      'line-color': 'rgb(0, 255, 0)',
      'line-width': 2,
      'line-blur': 2
    }
  })
)})

