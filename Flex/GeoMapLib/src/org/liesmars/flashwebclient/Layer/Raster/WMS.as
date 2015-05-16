// ActionScript file
/* Copyright (c) 2006-2008 MetaCarta, Inc., published under the Clear BSD
 * license.  See http://svn.openlayers.org/trunk/openlayers/license.txt for the
 * full text of the license. */


/**
 * @requires OpenLayers/Layer/Grid.js
 * @requires OpenLayers/Tile/Image.js
 */

/**
 * Class: OpenLayers.Layer.WMS
 * Instances of OpenLayers.Layer.WMS are used to display data from OGC Web
 *     Mapping Services. Create a new WMS layer with the <OpenLayers.Layer.WMS>
 *     constructor.
 * 
 * Inherits from:
 *  - <OpenLayers.Layer.Grid>
 */
package org.liesmars.flashwebclient.Layer.Raster {
	import org.liesmars.flashwebclient.BaseTypes.Bounds;
	import org.liesmars.flashwebclient.BaseTypes.Pixel;
	import org.liesmars.flashwebclient.BaseTypes.Size;
	import org.liesmars.flashwebclient.Tile;
	import org.liesmars.flashwebclient.Tile.ImageTile;
	import org.liesmars.flashwebclient.Util;
	import org.liesmars.flashwebclient.Layer.Raster;
	import org.liesmars.flashwebclient.GeoMap;
	
		public class WMS extends Raster {
	    /**
	     * Constant: DEFAULT_PARAMS
	     * {Object} Hashtable of default parameter key/value pairs 
	     */
	    private const DEFAULT_PARAMS:Object = { service: "WMS",
	                      version: "1.1.1",
	                      request: "GetMap",
	                      styles: "",
	                      exceptions: "application/vnd.ogc.se_inimage",
	                      format: "image/jpeg",
	                      transparent:"true"
	                     };
	    
//	    /**
//	     * Property: reproject
//	     * *Deprecated*. See http://trac.openlayers.org/wiki/SphericalMercator
//	     * for information on the replacement for this functionality. 
//	     * {Boolean} Try to reproject this layer if its coordinate reference system
//	     *           is different than that of the base layer.  Default is true.  
//	     *           Set this in the layer options.  Should be set to false in 
//	     *           most cases.
//	     */
//	    reproject: false,
	 
//	    /**
//	     * APIProperty: isBaseLayer
//	     * {Boolean} Default is true for WMS layer
//	     */
//	    isBaseLayer: true,
	    
	    /**
	     * APIProperty: encodeBBOX
	     * {Boolean} Should the BBOX commas be encoded? The WMS spec says 'no', 
	     * but some services want it that way. Default false.
	     */
	    public var encodeBBOX:Boolean = false;
	 
	    /**
	     * Constructor: OpenLayers.Layer.WMS
	     * Create a new WMS layer object
	     *
	     * Example:
	     * (code)
	     * var wms = new OpenLayers.Layer.WMS("NASA Global Mosaic",
	     *                                    "http://wms.jpl.nasa.gov/wms.cgi", 
	     *                                    {layers: "modis,global_mosaic"});
	     * (end)
	     *
	     * Parameters:
	     * name - {String} A name for the layer
	     * url - {String} Base url for the WMS
	     *                (e.g. http://wms.jpl.nasa.gov/wms.cgi)
	     * params - {Object} An object with key/value pairs representing the
	     *                   GetMap query string parameters and parameter values.
	     * options - {Ojbect} Hashtable of extra options to tag onto the layer
	     */
	    public function WMS(name:String, url:String, params:Object, options:Object) {
	        var newArguments:Array = [];
	        //uppercase params
	        params = Util.upperCaseObject(params);//将key值转换成大写的 by WCZ
//	        newArguments.push(name, url, params, options);
//			this.singleTile = true;
	        super(name, url, params, options);
//	        OpenLayers.Layer.Grid.prototype.initialize.apply(this, newArguments);
			
	        Util.applyDefaults(
	                       this.params,
	                       Util.upperCaseObject(this.DEFAULT_PARAMS)
	                       );//将所有的参数组织到一起了 by WCZ
	
	
	        //layer is transparent        
	        if (this.params.TRANSPARENT && 
	            this.params.TRANSPARENT.toString().toLowerCase() == "true") {
	            
	            // unless explicitly set in options, make layer an overlay
	            if ( (options == null) || (!options.isBaseLayer) ) {
	                this.isBaseLayer = false;
	            } 
	            
	            // jpegs can never be transparent, so intelligently switch the 
	            //  format, depending on teh browser's capabilities
	            if (this.params.FORMAT == "image/jpeg") {
	                this.params.FORMAT = Util.alphaHack() ? "image/gif": "image/png";//alphaHack()函数本身就返回false
	            }
	        }
	
	    }
	
	    /**
	     * Method: destroy
	     * Destroy this layer
	     */
	    protected override function destroy():void {
	        // for now, nothing special to do here. 
//	        OpenLayers.Layer.Grid.prototype.destroy.apply(this, arguments);  
	        super.destroy();
	    }
	
	    
	    /**
	     * Method: clone
	     * Create a clone of this layer
	     *
	     * Returns:
	     * {<OpenLayers.Layer.WMS>} An exact clone of this layer
	     */
	    protected override function clone(obj:Object):Object {
	        
	        if (obj == null) {
	            obj = new WMS(this.name,
	                                           this.url,
	                                           this.params,
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
	     * Return a GetMap query string for this layer
	     *
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>} A bounds representing the bbox for the
	     *                                request.
	     *
	     * Returns:
	     * {String} A string with the layer's url and parameters and also the
	     *          passed-in bounds and appropriate tile size specified as 
	     *          parameters.
	     */
	    public override function getURL(bounds:Bounds):String {
	        bounds = this.adjustBounds(bounds);
	        
	        var imageSize:Size = this.getImageSize(); 
	        var bbox:Object;
	        if(encodeBBOX) {bbox = bounds.toBBOX();}
	        else bbox = bounds.toArray();
	        
	        var newParams:Object = {
	            'BBOX': (bbox, encodeBBOX? bounds.toBBOX():bounds.toArray()),
	            'WIDTH': imageSize.w,
	            'HEIGHT': imageSize.h
	        };
	        var requestString:String = this.getFullRequestString(newParams);//拼出一个带有参数的URL by WCZ 
	        trace(requestString);
	        return requestString;
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
	     * APIMethod: mergeNewParams
	     * Catch changeParams and uppercase the new params to be merged in
	     *     before calling changeParams on the super class.
	     * 
	     *     Once params have been changed, we will need to re-init our tiles.
	     * 
	     * Parameters:
	     * newParams - {Object} Hashtable of new params to use
	     */
//	    public function mergeNewParams(newParams:Object) {
//	        var upperParams:Object = Util.upperCaseObject(newParams);
////	        var newArguments = [upperParams];
////	        return OpenLayers.Layer.Grid.prototype.mergeNewParams.apply(this, 
////	                                                             newArguments);
//	        return supermergeNewParams(upperParams);	                                                             	                                                             
//	    }
	
	    /** 
	     * Method: getFullRequestString
	     * Combine the layer's url with its params and these newParams. 
	     *   
	     *     Add the SRS parameter from projection -- this is probably
	     *     more eloquently done via a setProjection() method, but this 
	     *     works for now and always.
	     *
	     * Parameters:
	     * newParams - {Object}
	     * altUrl - {String} Use this as the url instead of the layer's url
	     * 
	     * Returns:
	     * {String} 
	     */
	    public override function getFullRequestString(newParams:Object, altUrl:String=""):String {
//	        var projectionCode = this.map.getProjection();
//	        this.params.SRS = (projectionCode == "none") ? null : projectionCode;
//	
////	        return OpenLayers.Layer.Grid.prototype.getFullRequestString.apply(
////	                                                    this, arguments);
//	                                                    
	        return super.getFullRequestString(newParams, altUrl);	                                                    
	    }
	    
	 
	}


}


