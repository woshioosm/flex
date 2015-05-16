/* Copyright (c) 2006-2008 MetaCarta, Inc., published under the Clear BSD
 * license.  See http://svn.openlayers.org/trunk/openlayers/license.txt for the
 * full text of the license. */


/*
 * @requires OpenLayers/Util.js
 */

/*
 * Class: OpenLayers.Tile 
 * This is a class designed to designate a single tile, however
 *     it is explicitly designed to do relatively little. Tiles store 
 *     information about themselves -- such as the URL that they are related
 *     to, and their size - but do not add themselves to the layer div 
 *     automatically, for example. Create a new tile with the 
 *     <OpenLayers.Tile> constructor, or a subclass. 
 * 
 * TBD 3.0 - remove reference to url in above paragraph
 * 
 */
 
 
package org.liesmars.flashwebclient {
	import org.liesmars.flashwebclient.BaseTypes.Bounds;
	import org.liesmars.flashwebclient.BaseTypes.LonLat;
	import org.liesmars.flashwebclient.BaseTypes.Pixel;
	import org.liesmars.flashwebclient.BaseTypes.Size;
	import org.liesmars.flashwebclient.Layer.Raster;
	
	
	
	public class Tile {
//	    /** 
//	     * Constant: EVENT_TYPES
//	     * {Array(String)} Supported application event types
//	     */
//	    EVENT_TYPES: [ "loadstart", "loadend", "reload", "unload"],
//	    
//	    /**
//	     * APIProperty: events
//	     * {<OpenLayers.Events>} An events object that handles all 
//	     *                       events on the tile.
//	     */
//	    events: null,
	
	    /**
	     * Property: id 
	     * {String} null
	     */
	    private var id:String = null;
	    
	    /** 
	     * Property: layer 
	     * {<OpenLayers.Layer>} layer the tile is attached to 
	     */
	    protected var layer:Layer = null;
	    
	    /**
	     * Property: url
	     * {String} url of the request.
	     *
	     * TBD 3.0 
	     * Deprecated. The base tile class does not need an url. This should be 
	     * handled in subclasses. Does not belong here.
	     */
	    private var url:String = null;
	
	    /** 
	     * APIProperty: bounds 
	     * {<OpenLayers.Bounds>} null
	     */
	    public var bounds:Bounds = null;
	    
	    /** 
	     * Property: size 
	     * {<OpenLayers.Size>} null
	     */
	    public var size:Size = null;
	    
	    /** 
	     * Property: position 
	     * {<OpenLayers.Pixel>} Top Left pixel of the tile
	     */    
	    public var position:Pixel = null;
	
	    /** 
	     * Property: size 
	     * {<OpenLayers.Size>} null
	     */
	    public var imageSize:Size = null;
	    
	    /** 
	     * Property: position 
	     * {<OpenLayers.Pixel>} Top Left pixel of the tile
	     */    
	    public var imageOffset:Pixel = null;	
	
	    /** 
	     * Property: position 
	     * {<OpenLayers.Pixel>} Top Left pixel of the tile
	     */    
	    public var resolution:Number;	
	    	
	    /**
	     * Property: isLoading
	     * {Boolean} Is the tile loading?
	     */
	    protected var isLoading:Boolean = false;
	    
	    /**
	     * Property: isBackBuffer
	     * {Boolean} Is this tile a back buffer tile?
	     */
	    public var isBackBuffer:Boolean = false;

	    /**
	     * Property: isBackBuffer
	     * {Boolean} Is this tile a back buffer tile?
	     */
	    private var shouldDraw:Boolean = false;	    

	    
	    /**
	     * Property: lastRatio
	     * {Float} Used in transition code only.  This is the previous ratio
	     *     of the back buffer tile resolution to the map resolution.  Compared
	     *     with the current ratio to determine if zooming occurred.
	     */
	    protected var lastRatio:Number = 1;
	
	    /**
	     * Property: isFirstDraw
	     * {Boolean} Is this the first time the tile is being drawn?
	     *     This is used to force resetBackBuffer to synchronize
	     *     the backBufferTile with the foreground tile the first time
	     *     the foreground tile loads so that if the user zooms
	     *     before the layer has fully loaded, the backBufferTile for
	     *     tiles that have been loaded can be used.
	     */
	    protected var isFirstDraw:Boolean = true;
	        
	    /**
	     * Property: backBufferTile
	     * {<OpenLayers.Tile>} A clone of the tile used to create transition
	     *     effects when the tile is moved or changes resolution.
	     */
	    protected var backBufferTile:Tile = null;
	    
	    /**
	     * Property: backBufferTile
	     * {<OpenLayers.Tile>} A clone of the tile used to create transition
	     *     effects when the tile is moved or changes resolution.
	     */
	    public var queued:Boolean = false;	    
	        
	    /** TBD 3.0 -- remove 'url' from the list of parameters to the constructor.
	     *             there is no need for the base tile class to have a url.
	     * 
	     * Constructor: OpenLayers.Tile
	     * Constructor for a new <OpenLayers.Tile> instance.
	     * 
	     * Parameters:
	     * layer - {<OpenLayers.Layer>} layer that the tile will go in.
	     * position - {<OpenLayers.Pixel>}
	     * bounds - {<OpenLayers.Bounds>}
	     * url - {<String>}
	     * size - {<OpenLayers.Size>}
	     */   
	    public function Tile(layer:Layer, position:Pixel, bounds:Bounds, url:String, size:Size) {
	        this.layer = layer;
	        this.position = position.clone();
	        this.bounds = bounds.clone();
	        this.url = url;
	        this.size = size.clone();

	        //give the tile a unique id based on its BBOX.
//	        this.id = OpenLayers.Util.createUniqueID("Tile_");
	        this.id = Util.CreateId("Tile_");
	        
//	        this.events = new OpenLayers.Events(this, null, this.EVENT_TYPES);
	    }
	
	    /**
	     * Method: unload
	     * Call immediately before destroying if you are listening to tile
	     * events, so that counters are properly handled if tile is still
	     * loading at destroy-time. Will only fire an event if the tile is
	     * still loading.
	     */
	    public function unload():void {
	       if (this.isLoading) { 
	           this.isLoading = false; 
//	           this.events.triggerEvent("unload"); 
	       }
	    }
	    
	    /** 
	     * APIMethod: destroy
	     * Nullify references to prevent circular references and memory leaks.
	     */
	    public function destroy():void {
	        if (Util.indexOf(this.layer.SUPPORTED_TRANSITIONS, 
	                this.layer.transitionEffect) != -1) {
//	            this.layer.events.unregister("loadend", this, this.resetBackBuffer);
//	            this.events.unregister('loadend', this, this.resetBackBuffer);            
	        } else {
//	            this.events.unregister('loadend', this, this.showTile);
	        }
	        this.layer  = null;
	        this.bounds = null;
	        this.size = null;
	        this.position = null;
	        
//	        this.events.destroy();
//	        this.events = null;
	        
	        /* clean up the backBufferTile if it exists */
	        if (this.backBufferTile) {
	            this.backBufferTile.destroy();
	            this.backBufferTile = null;
	        }
	    }
	    
	    /**
	     * Method: clone
	     *
	     * Parameters:
	     * obj - {<OpenLayers.Tile>} The tile to be cloned
	     *
	     * Returns:
	     * {<OpenLayers.Tile>} An exact clone of this <OpenLayers.Tile>
	     */
	    protected function clone(obj:Object):Object {
	        if (obj == null) {
	            obj = new Tile(this.layer, 
	                                      this.position, 
	                                      this.bounds, 
	                                      this.url, 
	                                      this.size);
	        } 
	        
	        // catch any randomly tagged-on properties
//	        OpenLayers.Util.applyDefaults(obj, this);
	        
	        return obj;
	    }
	
	    /**
	     * Method: draw
	     * Clear whatever is currently in the tile, then return whether or not 
	     *     it should actually be re-drawn.
	     * 
	     * Returns:
	     * {Boolean} Whether or not the tile should actually be drawn. Note that 
	     *     this is not really the best way of doing things, but such is 
	     *     the way the code has been developed. Subclasses call this and
	     *     depend on the return to know if they should draw or not.
	     */
	    public function draw():Boolean {
	        var maxExtent:Bounds = this.layer.maxExtent;
	        var withinMaxExtent:Boolean = (maxExtent &&
	                               this.bounds.intersectsBounds(maxExtent, false));
	 
	        // The only case where we *wouldn't* want to draw the tile is if the 
	        // tile is outside its layer's maxExtent.
	        var drawTile:Boolean = (withinMaxExtent || this.layer.displayOutsideMaxExtent);
	
	        if (Util.indexOf(this.layer.SUPPORTED_TRANSITIONS, this.layer.transitionEffect) != -1) {
	            if (drawTile) {
	                //we use a clone of this tile to create a double buffer for visual
	                //continuity.  The backBufferTile is used to create transition
	                //effects while the tile in the grid is repositioned and redrawn
	                if (this.backBufferTile!=null) {
	                    this.backBufferTile.show();	                    
	                    // this is important.  It allows the backBuffer to place itself
	                    // appropriately in the DOM.  The Image subclass needs to put
	                    // the backBufferTile behind the main tile so the tiles can
	                    // load over top and display as soon as they are loaded.
//	                    this.backBufferTile.isBackBuffer = true;
	                    
//	                    // potentially end any transition effects when the tile loads
//	                    this.events.register('loadend', this, this.resetBackBuffer);
	                    
	                    // clear transition back buffer tile only after all tiles in
	                    // this layer have loaded to avoid visual glitches
//	                    this.layer.events.register("loadend", this, this.resetBackBuffer);
	                	this.startTransition();
	                }
	                // run any transition effects

	            } else {
	                // if we aren't going to draw the tile, then the backBuffer should
	                // be hidden too!
	                if (this.backBufferTile!=null) {
	                    this.backBufferTile.clear();
	                }
	            }
	        } else {
//	            if (drawTile && this.isFirstDraw) {
////	                this.events.register('loadend', this, this.showTile);
//	                this.isFirstDraw = false;
//	            }   
	        }    

	            if (drawTile && this.backBufferTile) {
	                this.isFirstDraw = false;
	            }   	        
	        
	        this.shouldDraw = drawTile;
	        
	        //clear tile's contents and mark as not drawn
	        this.clear();
	        
//	        return drawTile;
	        if (!drawTile) {
	            return false;    
	        } 
	        
	        return this.renderTile();
	    }
	    
	    /** 
	     * Method: moveTo
	     * Reposition the tile.
	     *
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>}
	     * position - {<OpenLayers.Pixel>}
	     * redraw - {Boolean} Call draw method on tile after moving.
	     *     Default is true
	     */
	    public function moveTo(bounds:Bounds, position:Pixel, redraw:Boolean = true):void {
//	        if (redraw == null) {
//	            redraw = true;
//	        }
	
	        this.bounds = bounds.clone();
	        this.position = position.clone();
	        if (redraw) {
	            this.draw();
	        }
	    }
	
	    /** 
	     * Method: clear
	     * Clear the tile of any bounds/position-related data so that it can 
	     *     be reused in a new location. To be implemented by subclasses.
	     */
	    protected function clear():void {
	        // to be implemented by subclasses
	    }
	    
	    /**   
	     * Method: getBoundsFromBaseLayer
	     * Take the pixel locations of the corner of the tile, and pass them to 
	     *     the base layer and ask for the location of those pixels, so that 
	     *     displaying tiles over Google works fine.
	     *
	     * Parameters:
	     * position - {<OpenLayers.Pixel>}
	     *
	     * Returns:
	     * bounds - {<OpenLayers.Bounds>} 
	     */
	    protected function getBoundsFromBaseLayer(position:Pixel):Bounds {
//	        var msg = OpenLayers.i18n('reprojectDeprecated',
//	                                              {'layerName':this.layer.name});
//	        OpenLayers.Console.warn(msg);
	        var topLeft:LonLat = this.layer.map.getLonLatFromLayerPx(position); 
	        var bottomRightPx:Pixel = position.clone();
	        bottomRightPx.x += this.size.w;
	        bottomRightPx.y += this.size.h;
	        var bottomRight:LonLat = this.layer.map.getLonLatFromLayerPx(bottomRightPx); 
	        // Handle the case where the base layer wraps around the date line.
	        // Google does this, and it breaks WMS servers to request bounds in 
	        // that fashion.  
	        if (topLeft.lon > bottomRight.lon) {
	            if (topLeft.lon < 0) {
	                topLeft.lon = -180 - (topLeft.lon+180);
	            } else {
	                bottomRight.lon = 180+bottomRight.lon+180;
	            }        
	        }
	        var bounds:Bounds = new Bounds(topLeft.lon, 
	                                       bottomRight.lat, 
	                                       bottomRight.lon, 
	                                       topLeft.lat);  
	        return bounds;
	    }
	    
	    /** 
	     * Method: startTransition
	     * Prepare the tile for a transition effect.  To be
	     *     implemented by subclasses.
	     */
	    protected function startTransition():void {}
	    
	    /** 
	     * Method: resetBackBuffer
	     * Triggered by two different events, layer loadend, and tile loadend.
	     *     In any of these cases, we check to see if we can hide the 
	     *     backBufferTile yet and update its parameters to match the 
	     *     foreground tile.
	     *
	     * Basic logic:
	     *  - If the backBufferTile hasn't been drawn yet, reset it
	     *  - If layer is still loading, show foreground tile but don't hide
	     *    the backBufferTile yet
	     *  - If layer is done loading, reset backBuffer tile and show 
	     *    foreground tile
	     */
	    private function resetBackBuffer():void {
	        this.showTile();
	        var raster:Raster = this.layer as Raster;
	        if (raster) var nTiles:int = raster.numLoadingTiles;
	        
	        if (this.backBufferTile && 
	            (this.isFirstDraw || !nTiles)) { //!this.layer.numLoadingTiles)) {
	            this.isFirstDraw = false;
	            // check to see if the backBufferTile is within the max extents
	            // before rendering it 
	            var maxExtent:Bounds = this.layer.maxExtent;
	            var withinMaxExtent:Boolean = (maxExtent &&
	                                   this.bounds.intersectsBounds(maxExtent, false));
	            if (withinMaxExtent) {
	                this.backBufferTile.position = this.position;
	                this.backBufferTile.bounds = this.bounds;
	                this.backBufferTile.size = this.size;
	                this.backBufferTile.imageSize = this.layer.imageSize || this.size;
	                this.backBufferTile.imageOffset = this.layer.imageOffset;
	                this.backBufferTile.resolution = this.layer.getResolution();
	                this.backBufferTile.renderTile();
	            }
	        }
	    }
	        
	    /** 
	     * Method: showTile
	     * Show the tile only if it should be drawn.
	     */
	    private function showTile():void { 
	        if (this.shouldDraw) {
	            this.show();
	        }
	    }
	    
	    /**
	     * Method: renderTile
	     * Internal function to actually initialize the image tile,
	     *     position it correctly, and set its url.
	     */
	    protected function renderTile():Boolean {
	    	
	    	return false;
	    }
	    
	    /** 
	     * Method: show
	     * Show the tile.  To be implemented by subclasses.
	     */
	    public function show():void { }
	    
	    /** 
	     * Method: hide
	     * Hide the tile.  To be implemented by subclasses.
	     */
	    public function hide():void { }
		
	}
	
}

