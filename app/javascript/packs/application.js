import "bootstrap";

import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';
import { toggleShadow } from '../plugins/footer_menu';
import { commentUpdate } from '../plugins/comment_update';


initMapbox();
toggleShadow();
commentUpdate();  // this is left here to discuss with santi, it can be deleted (inclusive the corresponding file) at the end of march latest

