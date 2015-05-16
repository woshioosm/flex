// ActionScript file
/* Copyright (c) 2006-2008 MetaCarta, Inc., published under the Clear BSD
 * licence.  See http://svn.openlayers.org/trunk/openlayers/license.txt for the
 * full text of the license. */


/**
 * @requires OpenLayers/Layer/Grid.js
 */

/**
 * Class: OpenLayers.Layer.TMS
 * 
 * Inherits from:
 *  - <OpenLayers.Layer.Grid>
 */
 
package  org.liesmars.flashwebclient.Layer.Raster  {
	import org.liesmars.flashwebclient.BaseTypes.Bounds;
	import org.liesmars.flashwebclient.BaseTypes.Pixel;
	import org.liesmars.flashwebclient.BaseTypes.LonLat;	
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.Tile.ImageTile;
	import org.liesmars.flashwebclient.Tile;	
	import org.liesmars.flashwebclient.Layer.Raster;
	
	public class GeoGlobe extends Raster {
	    /**
	     * APIProperty: serviceVersion
	     * {String}
	     */
	    public var serviceVersion:String = "1.0.0";
	
	    /**
	     * APIProperty: serviceVersion
	     * {String}
	     */
	    public var serviceType:String = "GloImage";
	    	
//	    /**
//	     * APIProperty: isBaseLayer
//	     * {Boolean}
//	     */
//	    public var isBaseLayer:Boolean = false;
	
	    /**
	     * APIProperty: tileOrigin
	     * {<OpenLayers.Pixel>}
	     */
	    public var tileOrigin:LonLat = null;
	
	    /**
	     * Constructor: OpenLayers.Layer.TMS
	     * 
	     * Parameters:
	     * name - {String}
	     * url - {String}
	     * options - {Object} Hashtable of extra options to tag onto the layer
	     */
	    public function GeoGlobe(name:String, url:String, options:Object) {
	        super(name, url, {}, options);
	    }
	
	    /**
	     * APIMethod:destroy
	     */
	    protected override function destroy():void {
	        // for now, nothing special to do here. 
//	        apply(this, arguments); 
	        super.destroy();  
	    }
	
	    
	    /**
	     * APIMethod: clone
	     * 
	     * Parameters:
	     * obj - {Object}
	     * 
	     * Returns:
	     * {<OpenLayers.Layer.TMS>} An exact clone of this <OpenLayers.Layer.TMS>
	     */
	    protected override function clone(obj:Object):Object {
	        
	        if (obj == null) {
	            obj = new GeoGlobe(this.name,
	                                           this.url,
	                                           this.options);
	        }
	
	        //get all additions from superclasses
//	        obj = OpenLayers.Layer.Grid.prototype.clone.apply(this, [obj]);
			obj = super.clone(obj);
	        // copy/set any non-init, non-simple values here
	
	        return obj;
	    }
	    
	    /**
	     * Method: getURL
	     * 
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>}
	     * 
	     * Returns:
	     * {String} A string with the layer's url and parameters and also the 
	     *          passed-in bounds and appropriate tile size specified as 
	     *          parameters
	     */
	    public override function getURL(bounds:Bounds):String {
	        bounds = this.adjustBounds(bounds);
	        var res:Number = this.map.getResolution();

	        var x:int = Math.round((bounds.left - this.tileOrigin.lon) / (res * this.tileSize.w));
	        var y:int = Math.round((bounds.bottom - this.tileOrigin.lat) / (res * this.tileSize.h));
	               
	        var z:int = this.map.getZoomForResolution(this.resolutions[0] as Number);
	        var level:int = this.map.zoom - z;
      	       
			var path:String =  "?T=" + this.serviceType + "&L=" + level + "&X=" + x + "&Y=" + y;

	        var url:String = this.url;
	        if (url is Array) {
	        }
	        trace(url+path);
	        return url + path;
	    }
	
	    /**
	     * Method: addTile
	     * addTile creates a tile, initializes it, and adds it to the layer div. 
	     * 
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>}
	     * position - {<OpenLayers.Pixel>}
	     * 
	     * Returns:
	     * {<OpenLayers.Tile.Image>} The added OpenLayers.Tile.Image
	     */
	    protected override function addTile(bounds:Bounds,position:Pixel):Tile {
	        return new ImageTile(this, position, bounds, 
	                                         null, this.tileSize);
	    }
	
	    /** 
	     * APIMethod: setMap
	     * When the layer is added to a map, then we can fetch our origin 
	     *    (if we don't have one.) 
	     * 
	     * Parameters:
	     * map - {<OpenLayers.Map>}
	     */
	    public override function setMap(map:GeoMap):void {
	        super.setMap(map);
	        if (!this.tileOrigin) { 
	            this.tileOrigin = new LonLat(this.map.maxExtent.left,
	                                                this.map.maxExtent.bottom);
	        }                                       
	    }
	    
	}
}

