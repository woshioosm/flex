// ActionScript file
/* Copyright (c) 2006-2008 MetaCarta, Inc., published under the Clear BSD
 * license.  See http://svn.openlayers.org/trunk/openlayers/license.txt for the
 * full text of the license. */


/**
 * @requires OpenLayers/Tile.js
 */

/**
 * Class: OpenLayers.Tile.Image
 * Instances of OpenLayers.Tile.Image are used to manage the image tiles
 * used by various layers.  Create a new image tile with the
 * <OpenLayers.Tile.Image> constructor.
 *
 * Inherits from:
 *  - <OpenLayers.Tile>
 */
 
 package org.liesmars.flashwebclient.Tile {
 	import fl.transitions.easing.*;
 	
 	import flash.display.Bitmap;
 	import flash.display.Loader;
 	import flash.display.Sprite;
 	import flash.events.Event;
 	import flash.events.IOErrorEvent;
 	import flash.events.TimerEvent;
 	import flash.filters.*;
 	import flash.net.URLRequest;
 	import flash.net.URLRequestMethod;
 	
 	import org.liesmars.flashwebclient.BaseTypes.*;
 	import org.liesmars.flashwebclient.Layer;
 	import org.liesmars.flashwebclient.Tile;
 	import org.liesmars.flashwebclient.Util;
 	import org.liesmars.flashwebclient.Layer.Raster;
 	
 	public class ImageTile extends Tile {
	    /** 
	     * Property: url
	     * {String} The URL of the image being requested. No default. Filled in by
	     * layer.getURL() function. 
	     */
	    private var url:String = null;
	    
	    private var errorUrl:String = null;
//	    /** 
//	     * Property: imgDiv
//	     * {DOMElement} The div element which wraps the image.
//	     */
//	    private var imgDiv: null,
	
	    /** 
	     * Property: imgDiv
	     * {DOMElement} The div element which wraps the image.
	     */
	    public var loader:Loader = null;
	    
	    private var bitmap:Bitmap = null;
	
	    /**
	     * Property: frame
	     * {DOMElement} The image element is appended to the frame.  Any gutter on
	     * the image will be hidden behind the frame. 
	     */ 
	    private var frame:Sprite = null; 
	
		private  const TIMES:int = 30;
//		/**
//		 * The Timer that acts like a heartbeat for the application.
//		 */
//		public var ticker:Timer = null;
//	    
//		/**
//		 * The Timer that acts like a heartbeat for the application.
//		 */
//		public var blurer:Timer = null;
//			    
//        public var blurX:Number;
//        public var blurY:Number ;

		private var loaded:Boolean = false;
	    
	    private var times:int = 0;
//	    /**
//	     * Property: layerAlphaHack
//	     * {Boolean} True if the png alpha hack needs to be applied on the layer's div.
//	     */
//	    layerAlphaHack: null,
	
	    /** TBD 3.0 - reorder the parameters to the init function to remove 
	     *             URL. the getUrl() function on the layer gets called on 
	     *             each draw(), so no need to specify it here.
	     * 
	     * Constructor: OpenLayers.Tile.Image
	     * Constructor for a new <OpenLayers.Tile.Image> instance.
	     * 
	     * Parameters:
	     * layer - {<OpenLayers.Layer>} layer that the tile will go in.
	     * position - {<OpenLayers.Pixel>}
	     * bounds - {<OpenLayers.Bounds>}
	     * url - {<String>} Deprecated. Remove me in 3.0.
	     * size - {<OpenLayers.Size>}
	     */   
	    public function ImageTile(layer:Layer, position:Pixel, bounds:Bounds, url:String, size:Size) {
//	        OpenLayers.Tile.prototype.initialize.apply(this, arguments);
			super(layer, position, bounds, url, size);
	        this.url = url; //deprecated remove me
	        
//	        this.frame = document.createElement('div'); 
//	        this.frame.style.overflow = 'hidden'; 
//	        this.frame.style.position = 'absolute'; 
//			this.frame = new Sprite();
//	        this.layerAlphaHack = this.layer.alpha && OpenLayers.Util.alphaHack();
	    }
	
	    /** 
	     * APIMethod: destroy
	     * nullify references to prevent circular references and memory leaks
	     */
	    public override function destroy():void {
	        if (this.loader != null)  {
//	            if (this.layerAlphaHack) {
//	                OpenLayers.Event.stopObservingElement(this.imgDiv.childNodes[0].id);                
//	            } else {
//	                OpenLayers.Event.stopObservingElement(this.imgDiv.id);
//	            }
//	            if (this.imgDiv.parentNode == this.frame) {
//	                this.frame.removeChild(this.loader);
//	                this.imgDiv.map = null;
//	            }

	            this.layer.sprite.removeChild(this.loader); 
				//this.layer.map.sprite.removeChild(this.loader);
	        	this.loader.unload();
	        }
	        
	        this.loader = null;
//	        if ((this.frame != null) ) {//&& (this.frame.parentNode == this.layer.div)) { 
//	            this.layer.sprite.removeChild(this.loader); 
//	        }
	        this.frame = null; 
//	        OpenLayers.Tile.prototype.destroy.apply(this, arguments);
			super.destroy();
	    }
	
	    /**
	     * Method: clone
	     *
	     * Parameters:
	     * obj - {<OpenLayers.Tile.Image>} The tile to be cloned
	     *
	     * Returns:
	     * {<OpenLayers.Tile.Image>} An exact clone of this <OpenLayers.Tile.Image>
	     */
	    protected override function clone(obj:Object):Object {
	        if (obj == null) {
	            obj = new ImageTile(this.layer, 
	                                            this.position, 
	                                            this.bounds, 
	                                            this.url,          
	                                            this.size);        
	        } 
	        
	        //pick up properties from superclass
//	        obj = OpenLayers.Tile.prototype.clone.apply(this, [obj]);
	        obj = super.clone(obj);
	        //dont want to directly copy the image div
	        obj.loader = null;
 
	        
	        return obj;
	    }
	    
	    /**
	     * Method: draw
	     * Check that a tile should be drawn, and draw it.
	     * 
	     * Returns:
	     * {Boolean} Always returns true.
	     */
	    public override function draw():Boolean {
//	        if (this.layer != this.layer.map.baseLayer)  {//&& this.layer.reproject) {
//	            this.bounds = this.getBoundsFromBaseLayer(this.position);
//	        }
	        if (!super.draw()) {
	            return false;    
	        }
	        
	        if (this.isLoading) {
	            //if we're already loading, send 'reload' instead of 'loadstart'.
//	            this.events.triggerEvent("reload"); 
	        } else {
	            this.isLoading = true;
//	            this.events.triggerEvent("loadstart");
	        }
//	        this.renderTile();
	        return true;
	    }
	    
	    /**
	     * Method: renderTile
	     * Internal function to actually initialize the image tile,
	     *     position it correctly, and set its url.
	     */
	    protected override function renderTile():Boolean {
	        if (this.loader == null) {
	            this.initImgDiv();
	        }
	
//	        this.imgDiv.viewRequestID = this.layer.map.viewRequestID;
	                
	        //20090703，当为Get方法时，保持原有不变，当用post时，新添方法处理，目前只实现了WMS层的post方法，其它层暂时
	        //只能使用Get方法	    
		        this.url = this.layer.getURL(this.bounds);
	//			trace(url);
	//	    	trace(this.bounds + this.layer.map.getExtent() + " size: " + this.layer.map.getSize());
	//	    	trace(this.layer.layername + "bounds: " + bounds + " position: " + position);
	//	    	trace(this.bounds + " " + this.url);
		        // position the frame 
	//	        OpenLayers.Util.modifyDOMElement(this.frame, 
	//	                                         null, this.position, this.size);   
	//			this.frame.scrollRect = new Rectangle(0, 0, this.size.w, this.size.h );
	//			this.frame.x = this.position.x;
	//			this.frame.y = this.position.y;
	//			this.loader.x = this.position.x;
	//			this.loader.y = this.position.y;
	//			this.loader.width = this.size.w;
	//			this.loader.height = this.size.h;	
	//			this.loader.scrollRect = new Rectangle(0, 0, this.size.w, this.size.h );		
				this.loader.visible = true;
				
	//	        trace(url + this.position.x + ": " + this.position.y );
		        			
	//	        var imageSize:Size = this.layer.getImageSize(); 
	//	        if (this.layerAlphaHack) {
	//	            OpenLayers.Util.modifyAlphaImageDiv(this.imgDiv,
	//	                    null, null, imageSize, this.url);
	//	        } else {
	//	            OpenLayers.Util.modifyDOMElement(this.imgDiv,
	//	                    null, null, imageSize) ;
					
	//	            this.imgDiv.src = this.url;
	//				if(!this.isFirstDraw) {
	//        			ticker = new Timer(300, 1); 
	//		        	
	//		        	// Designates the onTick() method to handle Timer events
	//		            ticker.addEventListener(TimerEvent.TIMER, onTick);
	//		            
	//		            // Starts the clock ticking
	//		            ticker.start();;
	//				}
	//				else {
	//					onTick(null);
	//				}
	//	        }
	//					var request:URLRequest = new URLRequest(url);
	//					loader.load(request);
				loadImage(this.url);



	        return true;
	    }
	
	    /** 
	     * Method: clear
	     *  Clear the tile of any bounds/position-related data so that it can 
	     *   be reused in a new location.
	     */
	    protected override function clear():void {
	        if(this.loader) {
	            this.hide();
//	            if (ImageTile.useBlankTile) { 
//	                this.imgDiv.src = OpenLayers.Util.getImagesLocation() + "blank.gif";
//	            }    
	            
	        }
	    }
	
	    /**
	     * Method: initImgDiv
	     * Creates the imgDiv property on the tile.
	     */
	    private function initImgDiv():void {
	        
	        var offset:Pixel = this.layer.imageOffset; 
	        var size:Size = this.layer.getImageSize(); 
	     
//	        if (this.layerAlphaHack) {
//	            this.imgDiv = OpenLayers.Util.createAlphaImageDiv(null,
//	                                                           offset,
//	                                                           size,
//	                                                           null,
//	                                                           "relative",
//	                                                           null,
//	                                                           null,
//	                                                           null,
//	                                                           true);
//	        } else {
//	            this.imgDiv = OpenLayers.Util.createImage(null,
//	                                                      offset,
//	                                                      size,
//	                                                      null,
//	                                                      "relative",
//	                                                      null,
//	                                                      null,
//	                                                      true);
				this.loader = new Loader();
				
//				this.loader.scrollRect = new Rectangle(0,0,this.size.w, this.size.h);
				this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
				this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
				this.loader.contentLoaderInfo.addEventListener(Event.INIT, onInit);
				
				
//	        }
	        
//	        this.imgDiv.className = 'olTileImage';
	
	        /* checkImgURL used to be used to called as a work around, but it
	           ended up hiding problems instead of solving them and broke things
	           like relative URLs. See discussion on the dev list:
	           http://openlayers.org/pipermail/dev/2007-January/000205.html
	
	        OpenLayers.Event.observe( this.imgDiv, "load",
	            OpenLayers.Function.bind(this.checkImgURL, this) );
	        */
//	        this.frame.style.zIndex = this.isBackBuffer ? 0 : 1;
//	        this.frame.visible = this.isBackBuffer ? 0 : 1;
//	        this.frame.appendChild(this.imgDiv); 
//	        this.layer.div.appendChild(this.frame); 
//			this.frame.addChild(this.loader);
//			this.layer.sprite.addChild(this.frame);
		
	        this.loader.visible = this.isBackBuffer ? 0 : 1;
			this.layer.sprite.addChild(this.loader);		
			
			
//	        if(this.layer.opacity != null) {
//	            this.loader.
//	            OpenLayers.Util.modifyDOMElement(this.imgDiv, null, null, null,
//	                                             null, null, null, 
//	                                             this.layer.opacity);
//	        }
	
	        // we need this reference to check back the viewRequestID
//	        this.imgDiv.map = this.layer.map;
	
	        //bind a listener to the onload of the image div so that we 
	        // can register when a tile has finished loading.
	        var onload = function() {
	            
	            //normally isLoading should always be true here but there are some 
	            // right funky conditions where loading and then reloading a tile
	            // with the same url *really*fast*. this check prevents sending 
	            // a 'loadend' if the msg has already been sent
	            //
	            if (this.isLoading) { 
	                this.isLoading = false; 
//	                this.events.triggerEvent("loadend"); 
	            }
	        };
	        
//	        if (this.layerAlphaHack) { 
//	            OpenLayers.Event.observe(this.imgDiv.childNodes[0], 'load', 
//	                                     OpenLayers.Function.bind(onload, this));    
//	        } else { 
//	            OpenLayers.Event.observe(this.imgDiv, 'load', 
//	                                 OpenLayers.Function.bind(onload, this)); 
//	        } 
	        
	
	        // Bind a listener to the onerror of the image div so that we
	        // can registere when a tile has finished loading with errors.
//	        var onerror = function() {
	
	            // If we have gone through all image reload attempts, it is time
	            // to realize that we are done with this image. Since
	            // OpenLayers.Util.onImageLoadError already has taken care about
	            // the error, we can continue as if the image was loaded
	            // successfully.
//	            if (this.imgDiv._attempts > OpenLayers.IMAGE_RELOAD_ATTEMPTS) {
//	                onload.call(this);
//	            }
//	        };
//	        OpenLayers.Event.observe(this.imgDiv, "error",
//	                                 OpenLayers.Function.bind(onerror, this));
	    }
	
	
		private function onComplete(e:Event):void {
				// 2009-02-20
//			trace(this.url + " has been loaded  " + (times + 1) + " times, sucessful"  );
			this.loaded = true;
			this.times = 0;
			
			
//						if(this.backBufferTile) {
//							this.backBufferTile.destroy();
//							this.layer.removeChild(this.bitmap);
//							this.bitmap = null;
//							this.backBufferTile = null;
//						}
//	                if (this.loader) {//!this.backBufferTile) {
////	                    this.backBufferTile = this.clone(this) as Tile;
//
////	                    var imagetile:ImageTile;
////						imagetile = this.backBufferTile as ImageTile;
////						if(imagetile) imagetile.destroy();
////						
////	                    imagetile = new ImageTile(this.layer, this.position, this.bounds, this.url, this.size) as ImageTile;
////		                imagetile.loader = this.loader;
////	                    imagetile.layer.map.sprite.addChild(imagetile.loader);     
////	                                
//////	                    this.backBufferTile.hide();
////	                    // this is important.  It allows the backBuffer to place itself
////	                    // appropriately in the DOM.  The Image subclass needs to put
////	                    // the backBufferTile behind the main tile so the tiles can
////	                    // load over top and display as soon as they are loaded.
////	                    this.backBufferTile = imagetile;
//
//						this.backBufferTile = new ImageTile(this.layer, this.position, this.bounds, this.url, this.size);
//	                    this.backBufferTile.isBackBuffer = true;
////	                    this.backBufferTile.resolution = this.layer.getResolution();
//	                    this.backBufferTile.resolution = this.layer.map.zoom;
//	                    var content:Bitmap = this.loader.content as Bitmap;
//	                    this.bitmap = new Bitmap(content.bitmapData as BitmapData);
//	                    this.layer.addChild(this.bitmap);
//	                    this.bitmap.visible = false;
////	                    // potentially end any transition effects when the tile loads
////	                    this.events.register('loadend', this, this.resetBackBuffer);
//	                    
//	                    // clear transition back buffer tile only after all tiles in
//	                    // this layer have loaded to avoid visual glitches
////	                    this.layer.events.register("loadend", this, this.resetBackBuffer);
//	                }
		}
		
		private function onIoError(e:Event):void {
			if(!loaded && times < this.TIMES) 			// three times request image		
			{
				loadImage(url);
			}
			else { // end image request, load error image locally
//				loadImage("Assets/blank.gif");//E:/_projects/GeoMapLib/src/
//				trace("error image");
				// 2009-02-20
				trace(this.url + " has been loaded  " +  this.TIMES  + " times, unsucessful"  );
			}
//			trace(url + " ---load times: " + times);
//			trace(e + " loader: " + loader.toString());
		}

		private function onInit(e:Event):void {
			// 2009-02-20
			if(this.loader)
			{
				this.loader.x = this.position.x;
				this.loader.y = this.position.y;
				this.loader.width = this.size.w;
				this.loader.height = this.size.h;		
			}

			
//			var layer:Raster = this.layer as Raster;
//			if(layer)
//				if(!layer.singleTile)
//				{
//        	blurer = new Timer(2, 3); 
//		       	
//		    // Designates the onTick() method to handle Timer events
//		    blurer.addEventListener(TimerEvent.TIMER, onBlur);
//		    this.blurX = blurY = 6;    
//		    // Starts the clock ticking
//		    blurer.start();	
//				}

		}		

	    /**
	     * Method: checkImgURL
	     * Make sure that the image that just loaded is the one this tile is meant
	     * to display, since panning/zooming might have changed the tile's URL in
	     * the meantime. If the tile URL did change before the image loaded, set
	     * the imgDiv display to 'none', as either (a) it will be reset to visible
	     * when the new URL loads in the image, or (b) we don't want to display
	     * this tile after all because its new bounds are outside our maxExtent.
	     * 
	     * This function should no longer  be neccesary with the improvements to
	     * Grid.js in OpenLayers 2.3. The lack of a good isEquivilantURL function
	     * caused problems in 2.2, but it's possible that with the improved 
	     * isEquivilant URL function, this might be neccesary at some point.
	     * 
	     * See discussion in the thread at 
	     * http://openlayers.org/pipermail/dev/2007-January/000205.html
	     */
	    private function checkImgURL():void {
	        // Sometimes our image will load after it has already been removed
	        // from the map, in which case this check is not needed.  
	        if (this.layer) {
//	            var loaded = this.layerAlphaHack ? this.imgDiv.firstChild.src : this.imgDiv.src;
//	            if (!OpenLayers.Util.isEquivalentUrl(loaded, this.url)) {
//	                this.hide();
//	            }

	        } 
	    }
	    
	    /**
	     * Method: startTransition
	     * This method is invoked on tiles that are backBuffers for tiles in the
	     *     grid.  The grid tile is about to be cleared and a new tile source
	     *     loaded.  This is where the transition effect needs to be started
	     *     to provide visual continuity.
	     */
	    protected override function startTransition():void {
	        // backBufferTile has to be valid and ready to use
	        var imagetile:ImageTile = this.backBufferTile as ImageTile; 
	        
	        if (!this.backBufferTile) {
	            return;
	        }
	
	        // calculate the ratio of change between the current resolution of the
	        // backBufferTile and the layer.  If several animations happen in a
	        // row, then the backBufferTile will scale itself appropriately for
	        // each request.
	        var ratio:Number = 1;
	        	        if (this.backBufferTile.resolution) {
//	            ratio = this.backBufferTile.resolution / this.layer.getResolution();
				ratio = this.layer.map.zoom - this.backBufferTile.resolution;
				ratio = Math.pow(2, ratio);
//	            trace("back reso: " + this.backBufferTile.resolution + " this reso: " + this.layer.map.zoom);
	        }
	        
	        // if the ratio is not the same as it was last time (i.e. we are
	        // zooming), then we need to adjust the backBuffer tile
	        if (ratio != 1 && this.loader) {
	            if (this.layer.transitionEffect == 'resize') {
	                // In this case, we can just immediately resize the 
	                // backBufferTile.
	                var upperLeft:LonLat = new LonLat(
	                    this.backBufferTile.bounds.left, 
	                    this.backBufferTile.bounds.top
	                );
	                var size:Size = new Size(
	                    this.backBufferTile.size.w * ratio,
	                    this.backBufferTile.size.h * ratio
	                );
	                
//	                var size:Size = new Size(
//	                    this.loader.width * ratio,
//	                    this.loader.height * ratio
//	                );	
	                var px:Pixel = this.layer.map.getLayerPxFromLonLat(upperLeft);
////	                OpenLayers.Util.modifyDOMElement(this.backBufferTile.frame, 
////	                                                 null, px, size);
//					//this.backBufferTile.frame.scrollRect = new Rectangle(0, 0, this.size.w, this.size.h );
//					var imagetile:ImageTile = this.backBufferTile as ImageTile
//					if(imagetile) {
////////					this.backBufferTile.frame.width = this.size.w;
////////					this.backBufferTile.frame.height = this.size.h;					
////////					this.backBufferTile.frame.x = px.x;
////////					this.backBufferTile.frame.y = px.y;	 
//////					imagetile.frame.width = this.size.w;
//////					imagetile.frame.height = this.size.h;					
//////					imagetile.frame.x = px.x;
//////					imagetile.frame.y = px.y;	
////					imagetile.loader.x = px.x;
////					imagetile.loader.y = px.y;	
////					imagetile.loader.width = size.w;
////					imagetile.loader.height = size.h;
//					this.loader.x = px.x;
//					this.loader.y = px.y;
////					var tweenx:Tween = new Tween(this.loader, "x", Elastic.easeOut, this.loader.x, px.x, 3, true);
////					var tweeny:Tween = new Tween(this.loader, "x", Elastic.easeOut, this.loader.y, px.y, 3, true);
////					var tweenw:Tween = new Tween(this.loader, "width", Elastic.easeOut, this.loader.width, size.w, 0.1, true);
////					var tweenh:Tween = new Tween(this.loader, "height", Elastic.easeOut, this.loader.height, size.h, 0.1, true);
////					var tweenw:Tween = new Tween(this.loader, "width", Elastic.easeIn, this.loader.width , this.loader.width + 35, 0.5, true);
////					var tweenh:Tween = new Tween(this.loader, "height", Elastic.easeIn, this.loader.height ,  this.loader.height + 35, 0.5, true);															
//					this.loader.width = size.w;
//					this.loader.height = size.h;
//       				 }	
//					this.bitmap.x = px.x;
//					this.bitmap.y = px.y;
//					this.bitmap.width = size.w;
//					this.bitmap.height = size.h;					
//					this.bitmap.visible = true;
//					if(this.layer.layername == "SiChuan Disaster Radar")
//					trace("backtile x: " + bitmap.x + "Y:" + bitmap.y + " width: " + bitmap.width + " height:" + bitmap.height );
					//trace("backtile x: " + imagetile.loader.x + "Y:" + imagetile.loader.y);											
//					}
              
	                                   
//	                var imageSize:Size = this.backBufferTile.imageSize;
//	                imageSize = new Size(imageSize.w * ratio, 
//	                                                imageSize.h * ratio);
//	                var imageOffset:Pixel = this.backBufferTile.imageOffset;
//	                if(imageOffset) {
//	                    imageOffset = new Pixel(
//	                        imageOffset.x * ratio, imageOffset.y * ratio
//	                    );
//	                }
	
//	                OpenLayers.Util.modifyDOMElement(//	                    this.backBufferTile.imgDiv, null, imageOffset, imageSize
//	                ) ;
//					if(imagetile) {					
//					this.backBufferTile.loader.x = imageOffset.x;					
//					this.backBufferTile.loader.y = imageOffset.y;					
//					this.backBufferTile.loader.width = imageSize.w;
//					this.backBufferTile.loader.height = imageSize.h;	
//					imagetile.loader.x = imageOffset.x;
//					imagetile.loader.y = imageOffset.y;					
//					imagetile.loader.width = imageSize.w;
//					imagetile.loader.height = imageSize.h;						
//					}

					
	                this.backBufferTile.show();
	            }
	        } else {
	            // default effect is just to leave the existing tile
	            // until the new one loads if this is a singleTile and
	            // there was no change in resolution.  Otherwise we
	            // don't bother to show the backBufferTile at all
	            var raster:Raster = this.layer as Raster;
	            
	            if (raster.singleTile) {//(this.layer.singleTile) {
	                this.backBufferTile.show();
	            } else {
	                this.backBufferTile.hide();
	            }
	        }
	        this.lastRatio = ratio;
	
	    }
	    
	    /** 
	     * Method: show
	     * Show the tile by showing its frame.
	     */
	    public override function show():void {
//	        this.frame.style.display = '';
//	        this.frame.visible = true;

			if(this.loader) this.loader.visible = true;	        
	        
	        // Force a reflow on gecko based browsers to actually show the element
	        // before continuing execution.
	        if (Util.indexOf(this.layer.SUPPORTED_TRANSITIONS, 
	                this.layer.transitionEffect) != -1) {
//	            if (navigator.userAgent.toLowerCase().indexOf("gecko") != -1) { 
//	                this.frame.scrollLeft = this.frame.scrollLeft; 
//	            } 
	        }
	    }
	    
	    /** 
	     * Method: hide
	     * Hide the tile by hiding its frame.
	     */
	    public override function hide():void {
//	        this.frame.style.display = 'none';
//	        this.frame.visible = false;
			if(this.loader) this.loader.visible = false;	        
	    }
    
		/**
		 * Called once per second when the Timer event is received.
		 */
        public function loadImage(url:String):void 
        {
			times++;	
			var request:URLRequest = new URLRequest(url);
			if(loader!=null)
			{
				loader.load(request);
  			}else{
  				trace("loader not initialized");
  			}
        }	
        /**
		 * Called once per second when the Timer event is received,use post 20090703
		 */
        public function loadImageForPost(url:String,data:String):void 
        {
			times++;	
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			request.data = data;
			loader.visible = true;
			loader.load(request);
        }	
 		/**
		 * Called once per second when the Timer event is received.
		 */
        public function onBlur(evt:TimerEvent):void 
        {
//        	this.blurX -= 2;
//			loader.filters = [new BlurFilter(blurX, blurX, BitmapFilterQuality.HIGH), 
//			                  new GradientGlowFilter(0,45,[0xFFFFFF, 0xFF0000, 0xFFFF00, 0x00CCFF],[0, 0, 0, 0], [0, 63, 126, 255], 
//			                  blurX, blurY, 1, BitmapFilterQuality.HIGH, BitmapFilterType.OUTER, false)];

        }	       			

//		
 	}
 }
