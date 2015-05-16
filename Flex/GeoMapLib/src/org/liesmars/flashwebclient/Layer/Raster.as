// ActionScript file
/* Copyright (c) 2006-2008 MetaCarta, Inc., published under the Clear BSD
 * license.  See http://svn.openlayers.org/trunk/openlayers/license.txt for the
 * full text of the license. */


/**
 * @requires OpenLayers/Layer/HTTPRequest.js
 */

/**
 * Class: OpenLayers.Layer.Grid
 * Base class for layers that use a lattice of tiles.  Create a new grid
 * layer with the <OpenLayers.Layer.Grid> constructor.
 *
 * Inherits from:
 *  - <OpenLayers.Layer.HTTPRequest>
 */
 
 package org.liesmars.flashwebclient.Layer {
 	import org.liesmars.flashwebclient.BaseTypes.*;
 	import org.liesmars.flashwebclient.Layer;
 	import org.liesmars.flashwebclient.Tile;
 	import org.liesmars.flashwebclient.Util; 	
 	
 	public class Raster extends Layer {
//	    /**
//	     * APIProperty: tileSize
//	     * {<OpenLayers.Size>}
//	     */
//	    public var tileSize:Size = new Size(256, 256);
	    
	    /**
	     * APIProperty: tileSize
	     * {<OpenLayers.Size>}
	     */
	    private var origin:Pixel = null;	    
	    
	    /**
	     * Property: grid
	     * {Array(Array(<OpenLayers.Tile>))} This is an array of rows, each row is 
	     *     an array of tiles.
	     */
	    protected var grid:Array = null;
	
	    /**
	     * APIProperty: singleTile
	     * {Boolean} Moves the layer into single-tile mode, meaning that one tile 
	     *     will be loaded. The tile's size will be determined by the 'ratio'
	     *     property. When the tile is dragged such that it does not cover the 
	     *     entire viewport, it is reloaded.
	     */
	    public var singleTile:Boolean;
	
	    /** APIProperty: ratio
	     *  {Float} Used only when in single-tile mode, this specifies the 
	     *          ratio of the size of the single tile to the size of the map.
	     */
	    public var ratio:Number = 1.0;
	
	    /**
	     * APIProperty: buffer
	     * {Integer} Used only when in gridded mode, this specifies the number of 
	     *           extra rows and colums of tiles on each side which will
	     *           surround the minimum grid tiles to cover the map.
	     */

	
	    /**
	     * APIProperty: numLoadingTiles
	     * {Integer} How many tiles are still loading?
	     */
	    public var numLoadingTiles:int = 0;
	
	    /**
	     * Constructor: OpenLayers.Layer.Grid
	     * Create a new grid layer
	     *
	     * Parameters:
	     * name - {String}
	     * url - {String}
	     * params - {Object}
	     * options - {Object} Hashtable of extra options to tag onto the layer
	     */
	    public function Raster(name:String, url:String, params:Object, options:Object):void {
//	        OpenLayers.Layer.HTTPRequest.prototype.initialize.apply(this, 
//	                                                                arguments);
			this.transitionEffect = "resize";
	        
	        super(name, url, params, options);
	        //grid layers will trigger 'tileloaded' when each new tile is 
	        // loaded, as a means of progress update to listeners.
	        // listeners can access 'numLoadingTiles' if they wish to keep track
	        // of the loading progress
	        //
//	        this.events.addEventType("tileloaded");
	
	        this.grid = [];
	    }
	
	    /**
	     * APIMethod: destroy
	     * Deconstruct the layer and clear the grid.
	     */
	    protected override function destroy():void {
	        this.clearGrid();
	        this.grid = null;
	        this.tileSize = null;
//	        OpenLayers.Layer.HTTPRequest.prototype.destroy.apply(this, arguments); 
	        super.destroy();
	    }
	
	    /**
	     * Method: clearGrid
	     * Go through and remove all tiles from the grid, calling
	     *    destroy() on each of them to kill circular references
	     */
	    private function clearGrid():void {
	        if (this.grid) {
	            for(var iRow:int=0; iRow < this.grid.length; iRow++) {
	                var row:Array = this.grid[iRow];
	                for(var iCol:int=0; iCol < row.length; iCol++) {
	                    var tile:Tile = row[iCol];
	                    this.removeTileMonitoringHooks(tile);
	                    tile.destroy();
	                }
	            }
	            this.grid = [];
	        }
	    }
	
	    /**
	     * APIMethod: clone
	     * Create a clone of this layer
	     *
	     * Parameters:
	     * obj - {Object} Is this ever used?
	     * 
	     * Returns:
	     * {<OpenLayers.Layer.Grid>} An exact clone of this OpenLayers.Layer.Grid
	     */
	    protected override function clone(obj:Object):Object {
	        
	        if (obj == null) {
	            obj = new Raster(this.name, this.url, this.params, this.options);
	        }
	
	        //get all additions from superclasses
//	        obj = OpenLayers.Layer.HTTPRequest.prototype.clone.apply(this, [obj]);
			obj = super.clone(obj);
	        // copy/set any non-init, non-simple values here
	        if (this.tileSize != null) {
	            obj.tileSize = this.tileSize.clone();
	        }
	        
	        // we do not want to copy reference to grid, so we make a new array
	        obj.grid = [];
	
	        return obj;
	    }
	
	    /**
	     * Method: moveTo
	     * This function is called whenever the map is moved. All the moving
	     * of actual 'tiles' is done by the map, but moveTo's role is to accept
	     * a bounds and make sure the data that that bounds requires is pre-loaded.
	     *
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>}
	     * zoomChanged - {Boolean}
	     * dragging - {Boolean}
	     */
	    public override function moveTo(bounds:Bounds, zoomChanged:Boolean, dragging:Boolean):void {
//	        OpenLayers.Layer.HTTPRequest.prototype.moveTo.apply(this, arguments);
	        super.moveTo(bounds, zoomChanged, dragging);
	        bounds = bounds || this.map.getExtent();
	
	        if (bounds != null) {
	            this.setMaskparam(); 
	             
//	            this.setTileSize(); 
	            // if grid is empty or zoom has changed, we *must* re-tile
	            var forceReTile:Boolean = !this.grid.length || zoomChanged;
	
	            // total bounds of the tiles
	            var tilesBounds:Bounds = this.getTilesBounds();            
	      
	            if (this.singleTile) {
	                
	                // We want to redraw whenever even the slightest part of the 
	                //  current bounds is not contained by our tile.
	                //  (thus, we do not specify partial -- its default is false)
	                if ( forceReTile || 
	                     (!dragging && !tilesBounds.containsBounds(bounds))) {
	                    this.initSingleTile(bounds, forceReTile);
	                }
	            } else {
	             
	                // if the bounds have changed such that they are not even 
	                //  *partially* contained by our tiles (IE user has 
	                //  programmatically panned to the other side of the earth) 
	                //  then we want to reTile (thus, partial true).  
	                //
	                if (forceReTile || !tilesBounds.containsBounds(bounds, true)) {
	                    this.initGriddedTiles(bounds);
//	                    trace("layername: " + this.layername + " map zoom: " + this.map.zoom + " bounds: " + bounds.toString());
	                } else {
	                    //we might have to shift our buffer tiles
	                    this.moveGriddedTiles(bounds);
	                }
	            }
	        }
	    }
	    
	    protected override function setMaskparam():void {
			var lefttop00:Pixel = this.map.getLayerPxFromViewPortPx(new Pixel(0, 0));
			var masksize:Size = this.map.getSize();
			
	    	if(maskparam) maskparam = null;
	    	this.maskparam = new MaskParam(lefttop00.x, lefttop00.y, masksize.w, masksize.h);
	    }
	    
	    /**
	     * APIMethod: setTileSize
	     * Check if we are in singleTile mode and if so, set the size as a ratio
	     *     of the map size (as specified by the layer's 'ratio' property).
	     * 
	     * Parameters:
	     * size - {<OpenLayers.Size>}
	     */
	    public override function setTileSize(size:Size = null):void { 
	        if (this.singleTile) {
	            size = this.map.getSize().clone();
	            size.h = (size.h + 2 * buffer * this.map.TILE_HEIGHT) * this.ratio;
	            size.w = (size.w + 2 * buffer * this.map.TILE_WIDTH)* this.ratio;
	        } 
//	        OpenLayers.Layer.HTTPRequest.prototype.setTileSize.apply(this, [size]);
	        super.setTileSize(size);
	    }
	        
	    /**
	     * Method: getGridBounds
	     * Deprecated. This function will be removed in 3.0. Please use 
	     *     getTilesBounds() instead.
	     * 
	     * Returns:
	     * {<OpenLayers.Bounds>} A Bounds object representing the bounds of all the
	     * currently loaded tiles (including those partially or not at all seen 
	     * onscreen)
	     */
	    private function getGridBounds():Bounds {
//	        var msg = "The getGridBounds() function is deprecated. It will be " +
//	                  "removed in 3.0. Please use getTilesBounds() instead.";
//	        OpenLayers.Console.warn(msg);
	        return this.getTilesBounds();
	    }
	
	    /**
	     * APIMethod: getTilesBounds
	     * Return the bounds of the tile grid.
	     *
	     * Returns:
	     * {<OpenLayers.Bounds>} A Bounds object representing the bounds of all the
	     *     currently loaded tiles (including those partially or not at all seen 
	     *     onscreen).
	     */
	    public function getTilesBounds():Bounds {    
	        var bounds:Bounds = null; 
	        
	        if (this.grid.length) {
	            var bottom:int = this.grid.length - 1;
	            var bottomLeftTile:Tile = this.grid[bottom][0];
	    
	            var right:int = this.grid[0].length - 1; 
	            var topRightTile:Tile = this.grid[0][right];
	    
	            bounds = new Bounds(bottomLeftTile.bounds.left, 
	                                           bottomLeftTile.bounds.bottom,
	                                           topRightTile.bounds.right, 
	                                           topRightTile.bounds.top);
	            
	        }   
	        return bounds;
	    }
	
	    /**
	     * Method: initSingleTile
	     * 
	     * Parameters: 
	     * bounds - {<OpenLayers.Bounds>}
	     */
	    private function initSingleTile(bounds:Bounds, zoomChanged:Boolean):void {
	
	        //determine new tile bounds
	        var center:LonLat = bounds.getCenterLonLat();
	        var tileWidth:Number = bounds.getWidth() * this.ratio;
	        var tileHeight:Number = bounds.getHeight() * this.ratio;
		        var resolution:Number = this.map.getResolution();
		        var tilelon:Number = resolution * this.map.TILE_WIDTH;
		        var tilelat:Number = resolution * this.map.TILE_HEIGHT;
		        	                                       
	        var tileBounds:Bounds = 
	            new Bounds(center.lon - (tileWidth/2 + buffer * tilelon),
	                                  center.lat - (tileHeight/2+ buffer * tilelat),
	                                  center.lon + (tileWidth/2 + buffer * tilelon),
	                                  center.lat + (tileHeight/2+ buffer * tilelat));
	  
	        var ul:LonLat = new LonLat(tileBounds.left, tileBounds.top);
	        var px:Pixel = this.map.getLayerPxFromLonLat(ul);
	
	        if (!this.grid.length) {
	            this.grid[0] = [];
	        }
	
	        var tile:Tile = this.grid[0][0];
	        if (!tile) {
	            tile = this.addTile(tileBounds, px);
	            
	            this.addTileMonitoringHooks(tile);
	            tile.draw();
	            this.grid[0][0] = tile;
	        } else {
	            var tlLayer:Pixel = this.grid[0][0].position;
	            var tlViewPort:Pixel = 
	                this.map.getViewPortPxFromLayerPx(tlLayer);
				
	            if (tlViewPort.x > 0 || tlViewPort.y > 0 || tlViewPort.x < -buffer * this.map.TILE_WIDTH || tlViewPort.y < -buffer * this.map.TILE_HEIGHT ) {
	           	 	tile.moveTo(tileBounds, px);
	            } 
	            
	            if(zoomChanged) tile.moveTo(tileBounds, px);

	        }           
	        
	        //remove all but our single tile
	        this.removeExcessTiles(1,1);
	    }
	
	    /** 
	     * Method: calculateGridLayout
	     * Generate parameters for the grid layout. This  
	     *
	     * Parameters:
	     * bounds - {<OpenLayers.Bound>}
	     * extent - {<OpenLayers.Bounds>}
	     * resolution - {Number}
	     *
	     * Returns:
	     * Object containing properties tilelon, tilelat, tileoffsetlat,
	     * tileoffsetlat, tileoffsetx, tileoffsety
	     */
	    private function calculateGridLayout(bounds:Bounds, extent:Bounds, resolution:Number):Object {
	        var tilelon:Number = resolution * this.tileSize.w;
	        var tilelat:Number = resolution * this.tileSize.h;
	        
	        var offsetlon:Number = bounds.left - extent.left;
	        var tilecol:int = Math.floor(offsetlon/tilelon) - this.buffer;
//	        tilecol--;// move to the left col
	        var tilecolremain:Number = offsetlon/tilelon - tilecol;
	        var tileoffsetx:Number = -tilecolremain * this.tileSize.w;
	        var tileoffsetlon:Number = extent.left + tilecol * tilelon;
	        
	        var offsetlat:Number = bounds.top - (extent.bottom + tilelat);  
	        var tilerow:int = Math.ceil(offsetlat/tilelat) + this.buffer;
	        var tilerowremain:Number = tilerow - offsetlat/tilelat;
	        var tileoffsety:Number = -tilerowremain * this.tileSize.h;
	        var tileoffsetlat:Number = extent.bottom + tilerow * tilelat;
	        
//	        tileoffsetx = -59;
//	        tileoffsety = -14;
	        
	        return { 	"tilelon": tilelon, "tilelat": tilelat, 
	        			"tileoffsetlon": tileoffsetlon, "tileoffsetlat": tileoffsetlat,
						"tileoffsetx": tileoffsetx, "tileoffsety": tileoffsety
	        		};
	
	    }
	
	    /**
	     * Method: initGriddedTiles
	     * 
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>}
	     */
	    private function initGriddedTiles(bounds:Bounds):void {
	        
	        // work out mininum number of rows and columns; this is the number of
	        // tiles required to cover the viewport plus at least one for panning
	
	        var viewSize:Size = this.map.getSize();
	        var minRows:int = Math.ceil(viewSize.h/this.tileSize.h) + 
	                      Math.max(1, 2 * this.buffer);
	        var minCols:int = Math.ceil(viewSize.w/this.tileSize.w) +
	                      Math.max(1, 2 * this.buffer);
//	        var minRows:int = Math.ceil(viewSize.h/this.tileSize.h) +  2 * this.buffer;
//	        var minCols:int = Math.ceil(viewSize.w/this.tileSize.w) +  2 * this.buffer;	                      
	                      
	        
	        var extent:Bounds = this.map.getMaxExtent();
	        var resolution:Number = this.map.getResolution();
	        
	        var tileLayout:Object = this.calculateGridLayout(bounds, extent, resolution);
	
	        var tileoffsetx:Number = Math.round(tileLayout.tileoffsetx); // heaven help us
	        var tileoffsety:Number = Math.round(tileLayout.tileoffsety);
	
	        var tileoffsetlon:Number = tileLayout.tileoffsetlon;
	        var tileoffsetlat:Number = tileLayout.tileoffsetlat;
	        
	        var tilelon:Number = tileLayout.tilelon;
	        var tilelat:Number = tileLayout.tilelat;
	
	        this.origin = new Pixel(tileoffsetx, tileoffsety);
	
	        var startX:Number = tileoffsetx; 
	        var startLon:Number = tileoffsetlon;
	
	        var rowidx:int = 0;
	        
	        var layerContainerLeft:Number = this.map.layerContainer.x;
	        var layerContainerTop:Number =  this.map.layerContainer.y;
	        
	    
	        do {
	            var row:Array = this.grid[rowidx++];
	            if (!row) {
	                row = [];
	                this.grid.push(row);
	            }
	
	            tileoffsetlon = startLon;
	            tileoffsetx = startX;
	            var colidx:int = 0;
	 
	            do {
	                var tileBounds:Bounds = 
	                    new Bounds(tileoffsetlon, 
	                                          tileoffsetlat, 
	                                          tileoffsetlon + tilelon,
	                                          tileoffsetlat + tilelat);
	
	                var x:Number = tileoffsetx;
	                x -= layerContainerLeft;
	
	                var y:Number = tileoffsety;
	                y -= layerContainerTop;
	
	                var px:Pixel = new Pixel(x, y);
	                var tile:Tile = row[colidx++];
	                if (!tile) {
	                    tile = this.addTile(tileBounds, px);
	                    this.addTileMonitoringHooks(tile);
	                    row.push(tile);
	                } else {
	                    tile.moveTo(tileBounds, px, true);
//	                    tile.moveTo(tileBounds, px, false);	                    
	                }
	     
	                tileoffsetlon += tilelon;       
	                tileoffsetx += this.tileSize.w;
	            } while ((tileoffsetlon <= bounds.right + tilelon * this.buffer)
	                     || colidx < minCols)  
	             
	            tileoffsetlat -= tilelat;
	            tileoffsety += this.tileSize.h;
	        } while((tileoffsetlat >= bounds.bottom - tilelat * this.buffer)
	                || rowidx < minRows)
	        
	        //shave off exceess rows and colums
	        this.removeExcessTiles(rowidx, colidx);
	
	        //now actually draw the tiles
	        this.spiralTileLoad();
	    }
	    
	    /**
	     * Method: spiralTileLoad
	     *   Starts at the top right corner of the grid and proceeds in a spiral 
	     *    towards the center, adding tiles one at a time to the beginning of a 
	     *    queue. 
	     * 
	     *   Once all the grid's tiles have been added to the queue, we go back 
	     *    and iterate through the queue (thus reversing the spiral order from 
	     *    outside-in to inside-out), calling draw() on each tile. 
	     */
	    private function spiralTileLoad():void {
	        var tileQueue:Array = [];
	 
	        var directions:Array = ["right", "down", "left", "up"];
	
	        var iRow:int = 0;
	        var iCell:int = -1;
	        var direction:int = Util.indexOf(directions, "right");
	        var directionsTried:int = 0;
	        
	        while( directionsTried < directions.length) {
	
	            var testRow:int = iRow;
	            var testCell:int = iCell;
	
	            switch (directions[direction]) {
	                case "right":
	                    testCell++;
	                    break;
	                case "down":
	                    testRow++;
	                    break;
	                case "left":
	                    testCell--;
	                    break;
	                case "up":
	                    testRow--;
	                    break;
	            } 
	    
	            // if the test grid coordinates are within the bounds of the 
	            //  grid, get a reference to the tile.
	            var tile:Tile = null;
	            if ((testRow < this.grid.length) && (testRow >= 0) &&
	                (testCell < this.grid[0].length) && (testCell >= 0)) {
	                tile = this.grid[testRow][testCell];
	            }
	            
	            if ((tile != null) && (!tile.queued)) {
	                //add tile to beginning of queue, mark it as queued.
	                tileQueue.unshift(tile);
	                tile.queued = true;
	                
	                //restart the directions counter and take on the new coords
	                directionsTried = 0;
	                iRow = testRow;
	                iCell = testCell;
	            } else {
	                //need to try to load a tile in a different direction
	                direction = (direction + 1) % 4;
	                directionsTried++;
	            }
	        } 
	        
	        // now we go through and draw the tiles in forward order
	        for(var i:int=0; i < tileQueue.length; i++) {
	            var tile:Tile = tileQueue[i];
	            tile.draw();
	            //mark tile as unqueued for the next time (since tiles are reused)
	            tile.queued = false;       
	        }
	    }
	
	    /**
	     * APIMethod: addTile
	     * Gives subclasses of Grid the opportunity to create an 
	     * OpenLayer.Tile of their choosing. The implementer should initialize 
	     * the new tile and take whatever steps necessary to display it.
	     *
	     * Parameters
	     * bounds - {<OpenLayers.Bounds>}
	     * position - {<OpenLayers.Pixel>}
	     *
	     * Returns:
	     * {<OpenLayers.Tile>} The added OpenLayers.Tile
	     */
	    protected function addTile(bounds:Bounds, position:Pixel):Tile {
	        // Should be implemented by subclasses
	        return null;
	    }
	    
	    /** 
	     * Method: addTileMonitoringHooks
	     * This function takes a tile as input and adds the appropriate hooks to 
	     *     the tile so that the layer can keep track of the loading tiles.
	     * 
	     * Parameters: 
	     * tile - {<OpenLayers.Tile>}
	     */
	    private function addTileMonitoringHooks(tile:Tile):void {
	        
//	        tile.onLoadStart = function() {
//	            //if that was first tile then trigger a 'loadstart' on the layer
//	            if (this.numLoadingTiles == 0) {
////	                this.events.triggerEvent("loadstart");
//	            }
//	            this.numLoadingTiles++;
//	        };
//	        tile.events.register("loadstart", this, tile.onLoadStart);
	      
//	        tile.onLoadEnd = function() {
//	            this.numLoadingTiles--;
////	            this.events.triggerEvent("tileloaded");
//	            //if that was the last tile, then trigger a 'loadend' on the layer
//	            if (this.numLoadingTiles == 0) {
////	                this.events.triggerEvent("loadend");
//	            }
//	        };
//	        tile.events.register("loadend", this, tile.onLoadEnd);
//	        tile.events.register("unload", this, tile.onLoadEnd);
	    }
	
	    /** 
	     * Method: removeTileMonitoringHooks
	     * This function takes a tile as input and removes the tile hooks 
	     *     that were added in addTileMonitoringHooks()
	     * 
	     * Parameters: 
	     * tile - {<OpenLayers.Tile>}
	     */
	    private function removeTileMonitoringHooks(tile:Tile):void {
	        tile.unload();
//	        tile.events.un({
//	            "loadstart": tile.onLoadStart,
//	            "loadend": tile.onLoadEnd,
//	            "unload": tile.onLoadEnd,
//	            scope: this
//	        });
	    }
	    
	    /**
	     * Method: moveGriddedTiles
	     * 
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>}
	     */
	    private function moveGriddedTiles(bounds:Bounds):void {
	        var buffer:int = this.buffer || 1;
	        while (true) {
	            var tlLayer:Pixel = this.grid[0][0].position;
	            var tlViewPort:Pixel = 
	                this.map.getViewPortPxFromLayerPx(tlLayer);
//	                trace("**grid0.x: " + tlLayer.x + " grid0.y: " + tlLayer.x);
//	                trace("**tlViewPort.x: " + tlViewPort.x + " tlViewPort.y: " + tlViewPort.x);
//	                trace("**layer.x: " + (tlViewPort.x - tlLayer.x) + " layer.y: " + (tlViewPort.y - tlLayer.y));
	            if (tlViewPort.x > -this.tileSize.w * (buffer - 1)) {
	                this.shiftColumn(true);
	                trace("drag++: moving columns to right, updating left colum");
	            } else if (tlViewPort.x < -this.tileSize.w * buffer) {
	                this.shiftColumn(false);
	                trace("drag--: moving columns to left, updating right colum");	                
	            } else if (tlViewPort.y > -this.tileSize.h * (buffer - 1)) {
	                this.shiftRow(true);
	                trace("drag++: moving rows to bottom, updating top colum");	  	                
	            } else if (tlViewPort.y < -this.tileSize.h * buffer) {
	                this.shiftRow(false);
	                trace("drag--: moving rows to up, updating bottom colum");	  	  	                
	            } else {
	                break;
	            }

				var row:int = this.grid.length;
				var row0:Array = this.grid[0] as Array;
				var column:int = row0.length;
				
//	            if (tlViewPort.x > 0) {
//	                this.shiftColumn(true);
////	                trace("----drag++: moving columns to right, updating left colum");
//	            } else if (tlViewPort.x + column * this.tileSize.w < this.map.getSize().w) {
//	                this.shiftColumn(false);
////	                trace("----drag--: moving columns to left, updating right colum");	   
//	            } else if (tlViewPort.y > 0) {
//	                this.shiftRow(true);
////	                trace("----drag++: moving rows to bottom, updating top colum");	 	                
//	            } else if (tlViewPort.y + row * this.tileSize.h < this.map.getSize().h) {
//	                this.shiftRow(false);
////	                trace("----drag--: moving rows to up, updating bottom colum");	                
//	            } else {
//	                break;
//	            }	            
	            
	        };
	    }
	
	    /**
	     * Method: shiftRow
	     * Shifty grid work
	     *
	     * Parameters:
	     * prepend - {Boolean} if true, prepend to beginning.
	     *                          if false, then append to end
	     */
	    private function shiftRow(prepend:Boolean):void {
	        var modelRowIndex:int = (prepend) ? 0 : (this.grid.length - 1);
	        var grid:Array = this.grid;
	        var modelRow:Array = grid[modelRowIndex];
	
	        var resolution:Number = this.map.getResolution();
	        var deltaY:Number = (prepend) ? -this.tileSize.h : this.tileSize.h;
	        var deltaLat:Number = resolution * -deltaY;
	
	        var row:Array = (prepend) ? grid.pop() : grid.shift();
	
	        for (var i:int=0; i < modelRow.length; i++) {
	            var modelTile:Tile = modelRow[i];
	            var bounds:Bounds = modelTile.bounds.clone();
	            var position:Pixel = modelTile.position.clone();
	            bounds.bottom = bounds.bottom + deltaLat;
	            bounds.top = bounds.top + deltaLat;
	            position.y = position.y + deltaY;
	            row[i].moveTo(bounds, position);
	        }
	
	        if (prepend) {
	            grid.unshift(row);
	        } else {
	            grid.push(row);
	        }
	    }
	
	    /**
	     * Method: shiftColumn
	     * Shift grid work in the other dimension
	     *
	     * Parameters:
	     * prepend - {Boolean} if true, prepend to beginning.
	     *                          if false, then append to end
	     */
	    private function shiftColumn(prepend:Boolean):void {
	        var deltaX:Number = (prepend) ? -this.tileSize.w : this.tileSize.w;
	        var resolution:Number = this.map.getResolution();
	        var deltaLon:Number = resolution * deltaX;
	
	        for (var i:int=0; i<this.grid.length; i++) {
	            var row:Array = this.grid[i];
	            var modelTileIndex:int = (prepend) ? 0 : (row.length - 1);
	            var modelTile:Tile = row[modelTileIndex];
	            
	            var bounds:Bounds = modelTile.bounds.clone();
	            var position:Pixel = modelTile.position.clone();
	            bounds.left = bounds.left + deltaLon;
	            bounds.right = bounds.right + deltaLon;
	            position.x = position.x + deltaX;
	
	            var tile:Tile = prepend ? this.grid[i].pop() : this.grid[i].shift();
	            tile.moveTo(bounds, position);
	            if (prepend) {
	                row.unshift(tile);
	            } else {
	                row.push(tile);
	            }
	        }
	    }
	    
	    /**
	     * Method: removeExcessTiles
	     * When the size of the map or the buffer changes, we may need to
	     *     remove some excess rows and columns.
	     * 
	     * Parameters:
	     * rows - {Integer} Maximum number of rows we want our grid to have.
	     * colums - {Integer} Maximum number of columns we want our grid to have.
	     */
	    private function removeExcessTiles(rows:int , columns:int):void {
	        
	        // remove extra rows
	        while (this.grid.length > rows) {
	            var row:Array = this.grid.pop();
	            for (var i:int=0, l:int=row.length; i<l; i++) {
	                var tile:Tile = row[i];
	                this.removeTileMonitoringHooks(tile);
	                tile.destroy();
	            }
	        }
	        
	        // remove extra columns
	        while (this.grid[0].length > columns) {
	            for (var i:int=0, l:int=this.grid.length; i<l; i++) {
	                var row:Array = this.grid[i];
	                var tile:Tile = row.pop();
	                this.removeTileMonitoringHooks(tile);
	                tile.destroy();
	            }
	        }
	    }
	
	    /**
	     * Method: onMapResize
	     * For singleTile layers, this will set a new tile size according to the
	     * dimensions of the map pane.
	     */
	    public override function onMapResize():void {
	    	super.onMapResize();
	        if (this.singleTile) {
	            this.clearGrid();
	            this.setTileSize();
	        }
	    }
	    
	    /**
	     * APIMethod: getTileBounds
	     * Returns The tile bounds for a layer given a pixel location.
	     *
	     * Parameters:
	     * viewPortPx - {<OpenLayers.Pixel>} The location in the viewport.
	     *
	     * Returns:
	     * {<OpenLayers.Bounds>} Bounds of the tile at the given pixel location.
	     */
	    public function getTileBounds(viewPortPx:Pixel):Bounds {
	        var maxExtent:Bounds = this.map.getMaxExtent();
	        var resolution:Number = this.getResolution();
	        var tileMapWidth:Number = resolution * this.tileSize.w;
	        var tileMapHeight:Number = resolution * this.tileSize.h;
	        var mapPoint:LonLat = this.getLonLatFromViewPortPx(viewPortPx);
	        var tileLeft:Number = maxExtent.left + (tileMapWidth *
	                                         Math.floor((mapPoint.lon -
	                                                     maxExtent.left) /
	                                                    tileMapWidth));
	        var tileBottom:Number = maxExtent.bottom + (tileMapHeight *
	                                             Math.floor((mapPoint.lat -
	                                                         maxExtent.bottom) /
	                                                        tileMapHeight));
	        return new Bounds(tileLeft, tileBottom,
	                                     tileLeft + tileMapWidth,
	                                     tileBottom + tileMapHeight);
	    }
 		
 	}
 	
 }

