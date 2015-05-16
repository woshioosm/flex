package org.liesmars.flashwebclient.Layer.Raster
{
	import org.liesmars.flashwebclient.BaseTypes.Bounds;
	import org.liesmars.flashwebclient.BaseTypes.Pixel;
	import org.liesmars.flashwebclient.BaseTypes.Size;
	import org.liesmars.flashwebclient.Layer.Raster;
	import org.liesmars.flashwebclient.Tile;
	import org.liesmars.flashwebclient.Util;
	import org.liesmars.flashwebclient.Tile.ImageTile;
	//import org.liesmars.flashwebclient.Tile.ImageTile;
	
	public class WCS extends Raster
	{
		public var encodeBBOX:Boolean = true;
		
		private const DEFAULT_PARAMS:Object = { service: "WCS",
	                      version: "1.0.0",
	                      request: "GetCoverage",
	                      format: "png"
	                     };
	                     
		public function WCS(name:String, url:String, params:Object, options:Object)
		{
			var newArguments:Array = [];
	        //uppercase params
	        params = Util.upperCaseObject(params);
//	        newArguments.push(name, url, params, options);
//			this.singleTile = true;
	        super(name, url, params, options);
	        
	        Util.applyDefaults(
	                       this.params, 
	                       Util.upperCaseObject(this.DEFAULT_PARAMS)
	                       );
	                
	        
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
	                this.params.FORMAT = Util.alphaHack() ? "image/gif"
	                                                                 : "image/png";
	            }
	        }
		}
		
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
	        var requestString:String = this.getFullRequestString(newParams);
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
	       
			var str:String =  super.getFullRequestString(newParams, altUrl);
			                            
	        return str;
//	        return super.getFullRequestString(newParams, altUrl);	                                                    
	    }

	}
}