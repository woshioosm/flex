package org.liesmars.flashwebclient.Layer
{
	import org.liesmars.flashwebclient.BaseTypes.Bounds;
	import org.liesmars.flashwebclient.BaseTypes.LonLat;
	import org.liesmars.flashwebclient.BaseTypes.MaskParam;
	import org.liesmars.flashwebclient.BaseTypes.Pixel;
	import org.liesmars.flashwebclient.BaseTypes.Size;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.Layer;
	import org.liesmars.flashwebclient.Tile;
	import org.liesmars.flashwebclient.Tile.ImageTile;
	
	public class MarkImage extends Layer
	{
		private var extent:Bounds = null;
		private var size:Size = null;
		private var tile:Tile = null;
		private var pXY:Pixel = null;
		
		public function MarkImage(name:String, extent:Bounds, dimension:Size, url:String, params:Object, options:Object)
		{
			super(name, url, params, options);
			
			this.extent = extent;
			this.size = dimension;
		}
		
		protected override function destroy():void {
			if(this.tile) {
				this.tile.destroy();
				this.tile = null;
			}
			super.destroy();
		}
		
	   /**
	    * Method: clone
	    *
	    * Parameters:
	    * obj - {<OpenLayers.Layer>} The layer to be cloned
	    *
	    * Returns:
	    * {<OpenLayers.Layer>} An exact clone of this <OpenLayers.Layer>
	    */
	    protected override function clone(obj:Object):Object {//Layer {
	        
	        if (obj == null) {
	            obj = new MarkImage(this.name, this.extent, this.size, this.url, this.params, this.options);
	        } 
	        
	       //
	        
	        return obj ;//as Layer;
	    }
	    
	    /**
	     * Method: setMap
	     * Set the map property for the layer. This is done through an accessor
	     *     so that subclasses can override this and take special action once 
	     *     they have their map variable set. 
	     * 
	     *     Here we take care to bring over any of the necessary default 
	     *     properties from the map. 
	     * 
	     * Parameters:
	     * map - {<OpenLayers.Map>}
	     */
	    public override function setMap(map:GeoMap):void {
	    	this.minResolution = Math.min(this.extent.getWidth() / this.size.w, this.extent.getHeight() / this.size.h);
	    	trace(minResolution);
	    	super.setMap(map);	
	    }    
	    
	    /**
	     * Method: moveTo
	     * 
	     * Parameters:
	     * bound - {<OpenLayers.Bounds>}
	     * zoomChanged - {Boolean} Tells when zoom has changed, as layers have to
	     *     do some init work in that case.
	     * dragging - {Boolean}
	     */
	    public override function moveTo(bounds:Bounds, zoomChanged:Boolean, dragging:Boolean):void {
	        super.moveTo(bounds, zoomChanged, dragging);
	
	        var firstRendering:Boolean = (this.tile == null);
	
	        if(zoomChanged || firstRendering) {
	
	            //determine new tile size
	            this.setTileSize();
	
	            //determine new position (upper left corner of new bounds)
	            var ul:LonLat = new LonLat(this.extent.left, this.extent.top);
	            this.pXY = this.map.getLayerPxFromLonLat(ul);
				trace(pXY);
				
				this.setMaskparam();
			
            if(firstRendering) {
	                //create the new tile
	                this.tile = new ImageTile(this, pXY, this.extent, 
	                                                      null, this.tileSize);                                 
	            } else {
	                //just resize the tile and set it's new position
	                this.tile.size = this.tileSize.clone();
	                this.tile.position = pXY.clone();	                
	            }
	            this.tile.draw();  

	        }
	    }
	    
	    protected override function setMaskparam():void {
	    	if(maskparam) maskparam = null;
	    	this.maskparam = new MaskParam(pXY.x, pXY.y, tileSize.w, tileSize.h);
	    }
	    
	    	    
	    /**
	     * APIMethod: setTileSize
	     * Set the tile size based on the map size.  This also sets layer.imageSize
	     *     and layer.imageOffset for use by Tile.Image.
	     * 
	     * Parameters:
	     * size - {<OpenLayers.Size>}
	     */
	    public override function setTileSize(size:Size = null):void {
	        var tileWidth:Number = this.extent.getWidth() / this.map.getResolution();
	        var tileHeight:Number = this.extent.getHeight() / this.map.getResolution();
	        this.tileSize = new Size(tileWidth, tileHeight);
	    }
	    
	    /** 
	     * APIMethod: setUrl
	     * 
	     * Parameters:
	     * newUrl - {String}
	     */
	    public override function getURL(bounds:Bounds):String {
			return url;
	    }
	}
}