package org.liesmars.flashwebclient {
	 import flash.display.Sprite;
	 import flash.events.Event;
	 import flash.events.MouseEvent;
	 
	 import org.liesmars.flashwebclient.BaseTypes.*;

	 public class Layer extends Sprite  {
	    /**
	     * APIProperty: id
	     * {String}
	     */
	    public var id:String = null;
	
	    /** 
	     * APIProperty: name
	     * {String}
	     */
	    public var layername:String = null;
	
		public var buffer:int = 2;
	    /** 
	     * APIProperty: div
	     * {DOMElement}
	     */
	    public var sprite:Sprite = null;
	
	    /**
	     * Property: opacity
	     * {Float} The layer's opacity. Float number between 0.0 and 1.0.
	     */
	    public var opacity:Number;
	
	    /**
	     * APIProperty: map
	     * {<OpenLayers.Map>} This variable is set when the layer is added to 
	     *     the map, via the accessor function setMap().
	     */
	    public var map:GeoMap = null;
	    
	    /**
	     * APIProperty: isBaseLayer
	     * {Boolean} Whether or not the layer is a base layer. This should be set 
	     *     individually by all subclasses. Default is false
	     */
	    public var isBaseLayer:Boolean = false;
	
	    /** 
	     * APIProperty: displayInLayerSwitcher
	     * {Boolean} Display the layer's name in the layer switcher.  Default is
	     *     true.
	     */
	    public var displayInLayerSwitcher:Boolean = true;
	
	    /**
	     * APIProperty: visibility
	     * {Boolean} The layer should be displayed in the map.  Default is true.
	     */
	    public var visibility:Boolean;
	
	    /** 
	     * Property: inRange
	     * {Boolean} The current map resolution is within the layer's min/max 
	     *     range. This is set in <OpenLayers.Map.setCenter> whenever the zoom 
	     *     changes.
	     */
	    public var inRange:Boolean = false;
	    
	    /**
	     * Propery: imageSize
	     * {<OpenLayers.Size>} For layers with a gutter, the image is larger than 
	     *     the tile by twice the gutter in each dimension.
	     */
	    public var imageSize:Size = null;
	    
	    /**
	     * Propery: imageSize
	     * {<OpenLayers.Size>} For layers with a gutter, the image is larger than 
	     *     the tile by twice the gutter in each dimension.
	     */
	    public var tileSize:Size = new Size(256, 256);    
	    
	    /**
	     * Property: imageOffset
	     * {<OpenLayers.Pixel>} For layers with a gutter, the image offset 
	     *     represents displacement due to the gutter.
	     */
	    public var imageOffset:Pixel = null;
	    
	    /**
	     * APIProperty: projection
	     * {String} Set in the map options to override the default projection 
	     *          string this map - also set maxExtent, maxResolution, and 
	     *          units if appropriate.
	     */
	    public var projection:String = "EPSG:4326";
	
	    /** 
	     * Property: options
	     * {Object} An optional object whose properties will be set on the layer.
	     *     Any of the layer properties can be set as a property of the options
	     *     object and sent to the constructor when the layer is created.
	     */
	    protected var options:Object = null;
	    
	    /**
	     * APIProperty: gutter
	     * {Integer} Determines the width (in pixels) of the gutter around image
	     *     tiles to ignore.  By setting this property to a non-zero value,
	     *     images will be requested that are wider and taller than the tile
	     *     size by a value of 2 x gutter.  This allows artifacts of rendering
	     *     at tile edges to be ignored.  Set a gutter value that is equal to
	     *     half the size of the widest symbol that needs to be displayed.
	     *     Defaults to zero.  Non-tiled layers always have zero gutter.
	     */ 
	    public var gutter:int = 0;    
	    
	    /**
	     * APIProperty: units
	     * {String} The layer map units.  Defaults to 'degrees'.  Possible values
	     *     are 'degrees' (or 'dd'), 'm', 'ft', 'km', 'mi', 'inches'.
	     */
	    public var units:String = null;
	
	    /**
	     * APIProperty: scales
	     * {Array}  An array of map scales in descending order.  The values in the
	     *     array correspond to the map scale denominator.  Note that these
	     *     values only make sense if the display (monitor) resolution of the
	     *     client is correctly guessed by whomever is configuring the
	     *     application.  In addition, the units property must also be set.
	     *     Use <resolutions> instead wherever possible.
	     */
	    public var scales:Array = null;
	
	    /**
	     * APIProperty: resolutions
	     * {Array} A list of map resolutions (map units per pixel) in descending
	     *     order.  If this is not set in the layer constructor, it will be set
	     *     based on other resolution related properties (maxExtent,
	     *     maxResolution, maxScale, etc.).
	     */
	    public var resolutions:Array = null;
	    
	    /**
	     * APIProperty: maxExtent
	     * {<OpenLayers.Bounds>}  The center of these bounds will not stray outside
	     *     of the viewport extent during panning.  In addition, if
	     *     <displayOutsideMaxExtent> is set to false, data will not be
	     *     requested that falls completely outside of these bounds.
	     */
	    public var maxExtent:Bounds = null;
	    
	    
	    /**
	     * APIProperty: maxResolution
	     * {Float} Default max is 360 deg / 256 px, which corresponds to
	     *     zoom level 0 on gmaps.  Specify a different value in the layer 
	     *     options if you are not using a geographic projection and 
	     *     displaying the whole world.
	     */
	    public var maxResolution:Number;
	
	    /**
	     * APIProperty: minResolution
	     * {Float}
	     */
	    public var minResolution:Number;
	
	    /**
	     * APIProperty: numZoomLevels
	     * {Integer}
	     */
	    public var numPyramidLevels:int;
	   
	    /**
	     * APIProperty: numZoomLevels
	     * {Integer} Number of zoom levels for the map.  Defaults to 16.  Set a
	     *           different value in the map options if needed.
	     */
	    public var maxZoomLevel:int = -1;	
	    
	    /**
	     * APIProperty: numZoomLevels
	     * {Integer} Number of zoom levels for the map.  Defaults to 16.  Set a
	     *           different value in the map options if needed.
	     */
	    public var minZoomLevel:int = -1;		       
	    /**
	     *
	     * APIProperty: minScale
	     * {Float}
	     */
	    public var minScale:Number;
	    
	    /**
	     * APIProperty: maxScale
	     * {Float}
	     */
	     public var maxScale:Number;
	
	    /**
	     * APIProperty: displayOutsideMaxExtent
	     * {Boolean} Request map tiles that are completely outside of the max 
	     *     extent for this layer. Defaults to false.
	     */
	    public var displayOutsideMaxExtent:Boolean = false;
	
	    /**
	     * APIProperty: wrapDateLine
	     * {Boolean} #487 for more info.   
	     */
	    public var wrapDateLine:Boolean = false;
	      
	    /**
	     * APIProperty: transitionEffect
	     * {String} The transition effect to use when the map is panned or
	     *     zoomed.  
	     *
	     * There are currently two supported values:
	     *  - *null* No transition effect (the default).
	     *  - *resize*  Existing tiles are resized on zoom to provide a visual
	     *    effect of the zoom having taken place immediately.  As the
	     *    new tiles become available, they are drawn over top of the
	     *    resized tiles.
	     */
	    public var transitionEffect:String = null;
	    
	    /**
	     * Property: SUPPORTED_TRANSITIONS
	     * {Array} An immutable (that means don't change it!) list of supported 
	     *     transitionEffect values.
	     */
	    public var SUPPORTED_TRANSITIONS:Array = ['resize'];
	    
	     
	    /** 
	     * Constant: URL_HASH_FACTOR
	     * {Float} Used to hash URL param strings for multi-WMS server selection.
	     *         Set to the Golden Ratio per Knuth's recommendation.
	     */
	    public  const URL_HASH_FACTOR:Number = (Math.sqrt(5) - 1) / 2;
	
	    /** 
	     * Property: url
	     * {Array(String) or String} This is either an array of url strings or 
	     *                           a single url string. 
	     */
	    public var url:String = "";// here String, may both [] later
	
	    /** 
	     * Property: params
	     * {Object} Hashtable of key/value parameters
	     */
	    public var params:Object = null;
	    
	    
	    // for masking effect
		protected var maskparam:MaskParam = null;
		public var isMasked:Boolean = false;

	    
    
	    /**
	     * Constructor: OpenLayers.Layer
	     *
	     * Parameters:
	     * name - {String} The layer name
	     * options - {Object} Hashtable of extra options to tag onto the layer
	     */
	    public function Layer(name:String, url:String, params:Object, options:Object) {
			
//			this.addEventListener(MouseEvent.MOUSE_DOWN,tt);
	        this.addOptions(options);
	  
	        this.layername = name;
	        this.params = params;
	        
	        this.url = url;
	        
	        if (this.id == null) {
				this.id = Util.CreateId(Util.GetClassName(this));	
				this.sprite = this;
	        }
	
	        if (this.wrapDateLine) {
	            this.displayOutsideMaxExtent = true;
	        }
	    }
//		private function tt(e:Event):void{
//			
//		}
	    protected function setMaskparam():void {
	    	this.maskparam = null;
	    }
	    
		public function setMask(percent:Number,direction:Number):void {
			if(this.maskparam) {
				if(!this.mask)
				{
					var m:Sprite=new Sprite();
					m.graphics.beginFill(0xFF0000,1);					
					m.graphics.drawRect(0, 0, maskparam.sizeW, maskparam.sizeH);  					   					
					m.graphics.endFill();
					
					this.mask = m;					    
					this.addChild(m);
				}
				if(direction == 0)
				{
					var moveH:Number;
	 				moveH = maskparam.sizeH * percent;
	
					this.mask.x = maskparam.orignX ;				
					this.mask.y = maskparam.orignY + moveH;
					this.mask.width = maskparam.sizeW;
					this.mask.height = maskparam.sizeH;
				}
				else 
				{
					var moveV:Number;
	 				moveV = maskparam.sizeW * percent;
	
					this.mask.x = maskparam.orignX + moveV;				
					this.mask.y = maskparam.orignY ;
					this.mask.width = maskparam.sizeW;
					this.mask.height = maskparam.sizeH;
				}
			}
		} 
	    
	    public function removeMask():void {
	    	if(this.mask){
		    	this.removeChild(this.mask);
		    	this.mask = null;	
	    	}
	    }
	    
	    public function setMasked(b:Boolean):void {
	    	this.isMasked = b;
	    	if(!isMasked) removeMask();
	    }
	    
	    /**
	     * Method: destroy
	     * Destroy is a destructor: this is to alleviate cyclic references which
	     *     the Javascript garbage cleaner can not take care of on its own.
	     *
	     * Parameters:
	     * setNewBaseLayer - {Boolean} Set a new base layer when this layer has
	     *     been destroyed.  Default is true.
	     */
	    protected function destroy():void {
	    	var setNewBaseLayer:Boolean = this.isBaseLayer; 
	        
	        if (this.map != null) {
	            this.map.removeLayer(this, setNewBaseLayer);
	        }

	        this.map = null;
	        this.name = null;
	        this.options = null;
			this.url = null;
			this.params = null;
	        this.sprite = null;
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
	    protected function clone(obj:Object):Object {//Layer {
	        
	        if (obj == null) {
	            obj = new Layer(this.name, this.url, this.params, this.options);
	        } 
	        
//	        // catch any randomly tagged-on properties
//	        OpenLayers.Util.applyDefaults(obj, this);
	        
	        // a cloned layer should never have its map property set
	        //  because it has not been added to a map yet. 
	        obj.map = null;
	        
	        return obj ;//as Layer;
	    }
	    
	    /** 
	     * APIMethod: setName
	     * Sets the new layer name for this layer.  Can trigger a changelayer event
	     *     on the map.
	     *
	     * Parameters:
	     * newName - {String} The new name.
	     */
	    public function setName(newName:String):void {
	        if (newName != this.name) {
	            this.name = newName;
	            if (this.map != null) {
	            }
	        }
	    }
	    
	   /**
	    * APIMethod: addOptions
	    * 
	    * Parameters:
	    * newOptions - {Object}
	    */
	    public function addOptions(newOptions:Object):void {
	        
	        if (this.options == null) {
	            this.options = {};
	        }
	        
//	        // update our copy for clone
//	        OpenLayers.Util.extend(this.options, newOptions);
//	
//	        // add new options to this
//	        OpenLayers.Util.extend(this, newOptions);
			Util.SetOptions(this, newOptions);
	    }
	    
	    /**
	     * APIMethod: onMapResize
	     * This function can be implemented by subclasses
	     */
	    public function onMapResize():void {
	        //this function can be implemented by subclasses  

	    }
	
	    /**
	     * APIMethod: redraw
	     * Redraws the layer.  Returns true if the layer was redrawn, false if not.
	     *
	     * Returns:
	     * {Boolean} The layer was redrawn.
	     */
	    public function redraw():Boolean {
	        var redrawn:Boolean = false;
	        if (this.map) {
	            
	            // min/max Range may have changed
	            this.inRange = this.calculateInRange();
	
	            // map's center might not yet be set
	            var extent:Bounds = this.getExtent();
	
	            if (extent && this.inRange && this.visibility) {
	                this.moveTo(extent, true, false);
	                redrawn = true;
	            }
	        }
	        return redrawn;
	    }
	
	    /**
	     * APIMethod: redraw
	     * Redraws the layer.  Returns true if the layer was redrawn, false if not.
	     *
	     * Returns:
	     * {Boolean} The layer was redrawn.
	     */
	    public function clear():void {

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
	    public function moveTo(bounds:Bounds, zoomChanged:Boolean, dragging:Boolean):void {
	        this.display(true);
	        this.removeMask();
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
	    public function setMap(map:GeoMap):void {
	        if (this.map == null) {
	        
	            this.map = map;
	            
	            // grab some essential layer data from the map if it hasn't already
	            //  been set
	            this.maxExtent = this.maxExtent || this.map.maxExtent;
	            this.units = this.units || this.map.units;
	            
				//初始化当前图层的（最大/小）分辨率、缩放级别等信息 by WCZ 4-13
	            this.initResolutions();
	            
	            if (!this.isBaseLayer) {
	                this.inRange = this.calculateInRange();//返回boolean值 by WCZ 4-14
	                var show:Boolean = ((this.visibility) && (this.inRange));
	                this.sprite.visible = show;
	            }
	            
	            // deal with gutters
	            this.setTileSize(null);
	        }
	    }
	    
	    /**
	     * APIMethod: removeMap
	     * Just as setMap() allows each layer the possibility to take a 
	     *     personalized action on being added to the map, removeMap() allows
	     *     each layer to take a personalized action on being removed from it. 
	     *     For now, this will be mostly unused, except for the EventPane layer,
	     *     which needs this hook so that it can remove the special invisible
	     *     pane. 
	     * 
	     * Parameters:
	     * map - {<OpenLayers.Map>}
	     */
	    public function removeMap(map:GeoMap):void {
	        //to be overridden by subclasses
	    }
	    
	    /**
	     * APIMethod: getImageSize
	     * 
	     * Returns:
	     * {<OpenLayers.Size>} The size that the image should be, taking into 
	     *     account gutters.
	     */ 
	    public function getImageSize():Size { 
	        return (this.imageSize || this.tileSize); 
	    }
	  
	    /**
	     * APIMethod: setTileSize
	     * Set the tile size based on the map size.  This also sets layer.imageSize
	     *     and layer.imageOffset for use by Tile.Image.
	     * 
	     * Parameters:
	     * size - {<OpenLayers.Size>}
	     */
	    public function setTileSize(size:Size = null):void {
	        var tilesize:Size = (size!=null) ? size :
	                                ((this.tileSize) ? this.tileSize :
                                          this.map.getTileSize());
	        this.tileSize.w = tilesize.w;
	        this.tileSize.h = tilesize.h;
	        
	        if(this.gutter) {
	            this.imageOffset = new Pixel(-this.gutter, 
	                                                    -this.gutter); 
	            this.imageSize = new Size(tileSize.w + (2*this.gutter), 
	                                                 tileSize.h + (2*this.gutter)); 
	        }
	    }
	
	    /**
	     * APIMethod: getVisibility
	     * 
	     * Returns:
	     * {Boolean} The layer should be displayed (if in range).
	     */
	    public function getVisibility():Boolean {
	        return this.visibility;
	    }
	
	    /** 
	     * APIMethod: setVisibility
	     * Set the visibility flag for the layer and hide/show & redraw 
	     *     accordingly. Fire event unless otherwise specified
	     * 
	     * Note that visibility is no longer simply whether or not the layer's
	     *     style.display is set to "block". Now we store a 'visibility' state 
	     *     property on the layer class, this allows us to remember whether or 
	     *     not we *desire* for a layer to be visible. In the case where the 
	     *     map's resolution is out of the layer's range, this desire may be 
	     *     subverted.
	     * 
	     * Parameters:
	     * visible - {Boolean} Whether or not to display the layer (if in range)
	     */
	    public function setVisibility(visibility:Boolean):void {
	        if (visibility != this.visibility) {
	            this.visibility = visibility;
	            this.display(visibility);
	            if(!this.visibility) {
	            	this.clear();
	            } else {
	            	this.redraw();
	            }

	            if (this.map != null) {

	            }
	        }
	    }
	
	    /** 
	     * APIMethod: display
	     * Hide or show the Layer
	     * 
	     * Parameters:
	     * display - {Boolean}
	     */
	    public function display(display:Boolean):void {
	        var inRange:Boolean = this.calculateInRange();

	        if (display != (this.sprite.visible != false)) {
	        	this.sprite.visible = (display && inRange) ? true : false;
	        }
	    }
	
	
	    /** 
	     * APIMethod: setUrl
	     * 
	     * Parameters:
	     * newUrl - {String}
	     */
	    public function getURL(bounds:Bounds):String {
			return "";// unuse in this moment 
	    }
	    
	    /**
	     * Method: calculateInRange
	     * 
	     * Returns:
	     * {Boolean} The layer is displayable at the current map's current
	     *     resolution.
	     */
	    public function calculateInRange():Boolean {
	        var inRange:Boolean = false;
	        if (this.map) {
	        	if(this.isBaseLayer) inRange = true;
	        	else {
					//地图的缩放级别在当前图层的最小最大级别内 by WCZ４-14
			            inRange =  (this.map.zoom >= this.minZoomLevel) &&
			                        (this.map.zoom <= this.maxZoomLevel) ;
			            if(!inRange) return inRange;
			             
						//当前图层的最小最大分辨率存在时，地图的分辨率是否在其范围内 by WCZ 4-14
			            if(this.minResolution && this.maxResolution) {
			            	var resolution:Number = this.map.getResolution();
				            inRange = (resolution >= this.minResolution) &&
				                        (resolution <= this.maxResolution) 
			            }
		         }      		   
	        }
	        return inRange;
	    }
	
	    /** 
	     * APIMethod: setIsBaseLayer
	     * 
	     * Parameters:
	     * isBaseLayer - {Boolean}
	     */
	    public function setIsBaseLayer(isBaseLayer:Boolean):void {
	        if (isBaseLayer != this.isBaseLayer) {
	            this.isBaseLayer = isBaseLayer;
	            if (this.map != null) {
	            }
	        }
	    }
	
	  /********************************************************/
	  /*                                                      */
	  /*                 Baselayer Functions                  */
	  /*                                                      */
	  /********************************************************/
	  
	    /** 
	     * Method: initResolutions
	     * This method's responsibility is to set up the 'resolutions' array 
	     *     for the layer -- this array is what the layer will use to interface
	     *     between the zoom levels of the map and the resolution display 
	     *     of the layer.
	     * 
	     * The user has several options that determine how the array is set up.
	     *  
	     * For a detailed explanation, see the following wiki from the 
	     *     openlayers.org homepage:
	     *     http://trac.openlayers.org/wiki/SettingZoomLevels
	     */
	    private function initResolutions():void {
	
	        // These are the relevant options which are used for calculating 
	        //  resolutions information.
	        var props:Array = new Array(
	          'projection', 'units',
	          'scales', 
	          'resolutions',
	          'maxScale', 'minScale', 
	          'maxResolution', 'minResolution', 
	          'maxExtent', //'minExtent',
	          'numPyramidLevels'//, 'maxZoomLevel'
	        );
	
	        // First we create a new object where we will store all of the 
	        //  resolution-related properties that we find in either the layer's
	        //  'options' array or from the map.
	        //
	        var confProps:Object = {};//props的副本 by WCZ 
	        for(var i:int=0; i < props.length; i++) {
	            var property:String = props[i];
	            confProps[property] = this[property] ;//this.map[property];
	            //trace(property,this[property]);
	        }
	

//	        // First off, we take whatever hodge-podge of values we have and 
//	        //  calculate/distill them down into a resolutions[] array
//	        //
	        if ((confProps.scales != null) || (confProps.resolutions != null)) {

	          //preset levels
	            if (confProps.scales != null) {
	            	confProps.numPyramidLevels = confProps.scales.length;
	            	
	                confProps.resolutions = [];
	                for(var i:int = 0; i < confProps.scales.length; i++) {
	                    var scale:Number = confProps.scales[i];
	                    confProps.resolutions[i] = Util.getResolutionFromScale(scale, 
	                                                              confProps.units);
	                }
	            }
	            
	            if (confProps.resolutions != null) {
	            	confProps.numPyramidLevels = confProps.resolutions.length;
	            	
	                confProps.scales = [];
	                for(var i:int = 0; i < confProps.resolutions.length; i++) {
	                    var resolution:Number = confProps.resolutions[i];
	                    confProps.scales[i] = Util.getScaleFromResolution(resolution, 
	                                                              confProps.units);
	                }
	            }	            

	        } else {
	          //maxResolution and numZoomLevels based calculation
	
	            // determine maxResolution
	            if (confProps.minScale && !confProps.maxResolution) {
	                confProps.maxResolution = Util.getResolutionFromScale(confProps.minScale, 
	                                                           confProps.units);
	            } else if(!confProps.minScale && confProps.maxResolution) {
	                confProps.minScale = Util.getScaleFromResolution(confProps.maxResolution, 
	                                                              confProps.units);
	            }
	            
	            if (confProps.maxScale && !confProps.minResolution) {
	                confProps.minResolution = Util.getResolutionFromScale(confProps.maxScale, 
	                                                           confProps.units);
	            } else if(!confProps.maxScale && confProps.minResolution) {
	                confProps.maxScale = Util.getScaleFromResolution(confProps.minResolution, 
	                                                              confProps.units);
	            }
	            	 
	            if(confProps.maxResolution && confProps.minResolution && !numPyramidLevels) {
					//影像金字塔模型就是将原始影像数据按照行列为2N+1的准则标准化，金字塔各层以2的级数增加 by WCZ
	                var ratio:Number = confProps.maxResolution / confProps.minResolution;
	                confProps.numPyramidLevels =  Math.floor(Math.log(ratio) / Math.log(2)) + 1;	
	            }
	            
		        if(this.isBaseLayer && (! confProps.maxResolution) && this.maxExtent) {// except for minResoltuion false
		                var viewSize:Size = this.map.getSize();
		                var wRes:Number = this.maxExtent.getWidth() / viewSize.w;
		                var hRes:Number = this.maxExtent.getHeight()/ viewSize.h;
		                confProps.maxResolution = Math.max(wRes, hRes);	   
		                            
		                this.minZoomLevel = 0;
		                if(!this.numPyramidLevels) this.numPyramidLevels = 8;
		                
		                confProps.minResolution = confProps.maxResolution /  Math.pow(2, confProps.numPyramidLevels - 1);
		                this.maxZoomLevel = this.numPyramidLevels - 1;     
		        }
		        
	            var base:int = 2;  //假设金字塔各层以2（base）的级数增加   by WCZ
	            if(confProps.maxResolution && confProps.minResolution && numPyramidLevels) {
	                base = Math.pow(
	                    (confProps.maxResolution / confProps.minResolution),
	                    (1 / (confProps.numPyramidLevels - 1))
	                );
	            }	           
	            
	            // now we have numZoomLevels and maxResolution, 
	            //  we can populate the resolutions array
	            confProps.resolutions = new Array(confProps.numPyramidLevels as int);//resolutions表示有多少级 by WCZ 4-13
	            confProps.scales = new Array(confProps.numPyramidLevels as int);

	            for (var i:int=0; i < confProps.numPyramidLevels; i++) {
	                var res:Number = confProps.maxResolution / Math.pow(base, i);//获取每一级对应的分辨率==最大分辨率/(2^i)
	                confProps.resolutions[i] = res;//获取每一级的分辨率 by WCZ 4-13
	                confProps.scales[i] = Util.getScaleFromResolution(res, 
	                                                              confProps.units);//获取每一级分辨率对应的比例尺 by WCZ 4-13
	            }   
	            

			}	                        
	
	        this.resolutions = confProps.resolutions;//获取当前图层的每一级的分辨率 by WCZ 4-13
	        //trace(resolutions[0]);
	        this.scales = confProps.scales;//获取当前图层每一级的比例尺 by WCZ 4-13
	        this.numPyramidLevels = this.resolutions.length; //获取当前图层的金字塔的级数by WCZ 4-13
	        this.maxResolution = this.resolutions[0];//获取当前图层的第一级的分辨率，为最大值 by WCZ 4-13
	        this.minResolution = this.resolutions[this.numPyramidLevels - 1];//获取第17级的分辨率，为最小值 by WCZ 4-13
	        
	        this.minScale = this.scales[0];//获取当前图层的最小比例尺分母，对应最大分辨率 by WCZ 4-13
	        this.maxScale = this.scales[this.numPyramidLevels - 1];//获取当前图层的最大比例尺分母，对应最小分辨率 by WCZ 4-13
			
			if(this.isBaseLayer) {
				this.maxZoomLevel = this.numPyramidLevels - 1; //当前图层为底图时，获取金字塔的最大缩放级别  by WCZ 4-13	
				this.minZoomLevel = 0;	//当前图层为底图时，获取金字塔的最小缩放级别  by WCZ 4-13		
			}
			
			if(this.minResolution && this.maxResolution) {
				// 2009-01-18 //
				if(this.maxZoomLevel < 0) 				
				{this.maxZoomLevel = this.map.getZoomForResolution(this.minResolution); }//当前图层的最大缩放级别<0时，从最小分辨率获取最大缩放级别 by WCZ 4-13

				if(this.minZoomLevel < 0)
				{this.minZoomLevel = this.map.getZoomForResolution(this.maxResolution);}//当前图层的最小缩放级别<0时，从最大分辨率获取最小缩放级别 by WCZ 4-13
				/////////////////////// 
		
			}

			//当前图层的最小缩放级别<0而最大范围存在时，通过地图尺寸获取宽度和高度方向上的分辨率，取最大值，并由此计算出地图的最小缩放级别 by WCZ 4-13
	        if(this.minZoomLevel < 0 && this.maxExtent) {
	                var viewSize:Size = this.map.getSize();
	                var wRes:Number = this.maxExtent.getWidth() / viewSize.w;
	                var hRes:Number = this.maxExtent.getHeight()/ viewSize.h;
	                var res:Number = Math.max(wRes, hRes);	               
	                this.minZoomLevel = this.map.getZoomForResolution(res);
	        }
	        
			//当前图层的最小缩放级别<0时，将其赋值为0 by WCZ 4-13
	        if(this.minZoomLevel < 0) this.minZoomLevel = 0;
	        
			//当前图层的最大缩放级别<0时，将其赋值为地图本身的最大缩放级别 by WCZ 4-13
	        if(this.maxZoomLevel < 0) this.maxZoomLevel = this.map.getNumZoomLevels() - 1;
	    }
	
	    /**
	     * APIMethod: getResolution
	     * 
	     * Returns:
	     * {Float} The currently selected resolution of the map, taken from the
	     *     resolutions array, indexed by current zoom level.
	     */
	    public function getResolution():Number {
	        var zoom:int = this.map.getZoom();
	        return this.getResolutionForZoom(zoom);
	    }
	
	    /** 
	     * APIMethod: getExtent
	     * 
	     * Returns:
	     * {<OpenLayers.Bounds>} A Bounds object which represents the lon/lat 
	     *     bounds of the current viewPort.
	     */
	    public function getExtent():Bounds {
	        // just use stock map calculateBounds function -- passing no arguments
	        //  means it will user map's current center & resolution
	        //
	        return this.map.calculateBounds();
	    }
	
	    /**
	     * APIMethod: getZoomForExtent
	     * 
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>}
	     * closest - {Boolean} Find the zoom level that most closely fits the 
	     *     specified bounds. Note that this may result in a zoom that does 
	     *     not exactly contain the entire extent.
	     *     Default is false.
	     *
	     * Returns:
	     * {Integer} The index of the zoomLevel (entry in the resolutions array) 
	     *     for the passed-in extent. We do this by calculating the ideal 
	     *     resolution for the given extent (based on the map size) and then 
	     *     calling getZoomForResolution(), passing along the 'closest'
	     *     parameter.
	     */
	    public function getZoomForExtent(extent:Bounds, closest:Boolean):int {
	        var viewSize:Size = this.map.getSize();
	        var idealResolution:Number = Math.max( extent.getWidth()  / viewSize.w,
	                                        extent.getHeight() / viewSize.h );
	
	        return this.getZoomForResolution(idealResolution, closest);
	    }
	    
	    /** 
	     * Method: getDataExtent
	     * Calculates the max extent which includes all of the data for the layer.
	     *     This function is to be implemented by subclasses.
	     * 
	     * Returns:
	     * {<OpenLayers.Bounds>}
	     */
	    private function getDataExtent():Bounds {
	        //to be implemented by subclasses
	        return null;
	    }
	
	    /**
	     * APIMethod: getResolutionForZoom
	     * 
	     * Parameter:
	     * zoom - {Float}
	     * 
	     * Returns:
	     * {Float} A suitable resolution for the specified zoom.
	     */
	    public function getResolutionForZoom(zoom:int):Number {
	        zoom = Math.max(0, Math.min(zoom, this.resolutions.length - 1));//防止某些图层只在一定缩放级别范围内(比如3-9级)显示时出现错误 by WCZ 4-14
	        var resolution:Number;
	        if(this.map.fractionalZoom) {
	            var low:int = Math.floor(zoom);
	            var high:int = Math.ceil(zoom);
	            resolution = this.resolutions[high] +
	                ((zoom-low) * (this.resolutions[low]-this.resolutions[high]));
	        } else {
	            resolution = this.resolutions[Math.round(zoom)];
	        }
	        return resolution;
	    }
	
	    /**
	     * APIMethod: getZoomForResolution
	     * 
	     * Parameters:
	     * resolution - {Float}
	     * closest - {Boolean} Find the zoom level that corresponds to the absolute 
	     *     closest resolution, which may result in a zoom whose corresponding
	     *     resolution is actually smaller than we would have desired (if this
	     *     is being called from a getZoomForExtent() call, then this means that
	     *     the returned zoom index might not actually contain the entire 
	     *     extent specified... but it'll be close).
	     *     Default is false.
	     * 
	     * Returns:
	     * {Integer} The index of the zoomLevel (entry in the resolutions array) 
	     *     that corresponds to the best fit resolution given the passed in 
	     *     value and the 'closest' specification.
	     */
	    public function getZoomForResolution(resolution:Number, closest:Boolean):int {
	        var zoom:int;
	        if(this.map.fractionalZoom) {
	            var lowZoom:int = 0;
	            var highZoom:int = this.resolutions.length - 1;
	            var highRes:Number = this.resolutions[lowZoom];
	            var lowRes:Number = this.resolutions[highZoom];
	            var res:Number;
	            for(var i:int=0; i<this.resolutions.length; ++i) {
	                res = this.resolutions[i];
	                if(res >= resolution) {
	                    highRes = res;
	                    lowZoom = i;
	                }
	                if(res <= resolution) {
	                    lowRes = res;
	                    highZoom = i;
	                    break;
	                }
	            }
	            var dRes:Number = highRes - lowRes;
	            if(dRes > 0) {
	                zoom = lowZoom + ((resolution - lowRes) / dRes);
	            } else {
	                zoom = lowZoom;
	            }
	        } else {
	            var diff:Number;
	            var minDiff:Number = Number.POSITIVE_INFINITY;
	            for(var i:int=0; i < this.resolutions.length; i++) {            
	                if (closest) {
	                    diff = Math.abs(this.resolutions[i] - resolution);
	                    if (diff > minDiff) {
	                        break;
	                    }
	                    minDiff = diff;
	                } else {
	                    if (this.resolutions[i] < resolution) {
	                        break;
	                    }
	                }
	            }
	            zoom = Math.max(0, i-1);// i-1

	        }
	        return zoom;
	    }
	    
	    /**
	     * APIMethod: getLonLatFromViewPortPx
	     * 
	     * Parameters:
	     * viewPortPx - {<OpenLayers.Pixel>}
	     *
	     * Returns:
	     * {<OpenLayers.LonLat>} An OpenLayers.LonLat which is the passed-in 
	     *     view port <OpenLayers.Pixel>, translated into lon/lat by the layer.
	     */
	    public function getLonLatFromViewPortPx(viewPortPx:Pixel):LonLat {
	        var lonlat:LonLat = null;
	        if (viewPortPx != null) {
	            var size:Size = this.map.getSize();
	            var center:LonLat = this.map.getCenter();
	            if (center) {
	                var res:Number  = this.map.getResolution();
	        
	                var delta_x:Number = viewPortPx.x - (size.w / 2);
	                var delta_y:Number = viewPortPx.y - (size.h / 2);
	            
	                lonlat = new LonLat(center.lon + delta_x * res ,
	                                             center.lat - delta_y * res); 
	
	                if (this.wrapDateLine) {
	                    lonlat = lonlat.wrapDateLine(this.maxExtent);
	                }
	            } 
	        }
	        return lonlat;
	    }
	
	    /**
	     * APIMethod: getViewPortPxFromLonLat
	     * Returns a pixel location given a map location.  This method will return
	     *     fractional pixel values.
	     * 
	     * Parameters:
	     * lonlat - {<OpenLayers.LonLat>}
	     *
	     * Returns: 
	     * {<OpenLayers.Pixel>} An <OpenLayers.Pixel> which is the passed-in 
	     *     <OpenLayers.LonLat>,translated into view port pixels.
	     */
	    public function getViewPortPxFromLonLat(lonlat:LonLat):Pixel {
	        var px:Pixel = null; 
	        if (lonlat != null) {
	            var resolution:Number = this.map.getResolution();
	            var extent:Bounds = this.map.getExtent();
	            px = new Pixel(
  	                (1/resolution * (lonlat.lon - extent.left)),
	                (1/resolution * (extent.top - lonlat.lat))
	            );    
	        }
	        return px;
	    }
	    
	    /**
	     * APIMethod: setOpacity
	     * Sets the opacity for the entire layer (all images)
	     * 
	     * Parameter:
	     * opacity - {Float}
	     */
	    public function setOpacity(opacity:Number):void {
	        if (opacity != this.opacity) {
	            this.opacity = opacity;
	        }
	    }
	
	    /**
	     * Method: selectUrl
	     * selectUrl() implements the standard floating-point multiplicative
	     *     hash function described by Knuth, and hashes the contents of the 
	     *     given param string into a float between 0 and 1. This float is then
	     *     scaled to the size of the provided urls array, and used to select
	     *     a URL.
	     *
	     * Parameters:
	     * paramString - {String}
	     * urls - {Array(String)}
	     * 
	     * Returns:
	     * {String} An entry from the urls array, deterministically selected based
	     *          on the paramString.
	     */
	    protected function selectUrl(paramString:String, urls:Array):String {
	        var product:int = 1;
	        for (var i:int = 0; i < paramString.length; i++) { 
	            product *= paramString.charCodeAt(i) * this.URL_HASH_FACTOR; 
	            product -= Math.floor(product); 
	        }
	        return urls[Math.floor(product * urls.length)];
	    }
	
	    /** 
	     * Method: getFullRequestString
	     * Combine url with layer's params and these newParams. 
	     *   
	     *    does checking on the serverPath variable, allowing for cases when it 
	     *     is supplied with trailing ? or &, as well as cases where not. 
	     *
	     *    return in formatted string like this:
	     *        "server?key1=value1&key2=value2&key3=value3"
	     * 
	     * WARNING: The altUrl parameter is deprecated and will be removed in 3.0.
	     *
	     * Parameters:
	     * newParams - {Object}
	     * altUrl - {String} Use this as the url instead of the layer's url
	     *   
	     * Returns: 
	     * {String}
	     */
	    public function getFullRequestString(newParams:Object, altUrl:String=""):String {
	
	        // if not altUrl passed in, use layer's url
	        var url:String = altUrl || this.url;
	        
	        // create a new params hashtable with all the layer params and the 
	        // new params together. then convert to string
//	        var allParams = OpenLayers.Util.extend({}, this.params);
//	        allParams = OpenLayers.Util.extend(allParams, newParams);
//	        var paramsString = OpenLayers.Util.getParameterString(allParams);

	        var allParams:Object = Util.SetOptions({}, this.params);
	        allParams = Util.SetOptions(allParams, newParams);
	        var paramsString:String = Util.getParameterString(allParams);
	        // if url is not a string, it should be an array of strings, 
	        // in which case we will deterministically select one of them in 
	        // order to evenly distribute requests to different urls.
	        //
	        if (url is Array) {
//	            url = this.selectUrl(paramsString, url);
	        }   
	 
	        var urlParams = Util.upperCaseObject(Util.getParameters(url));   
	        for(var key:Object in allParams) {
	            if(key.toUpperCase() in urlParams) {
	                delete allParams[key];
	            }
	        }

	        paramsString = Util.getParameterString(allParams);
	        
	        // requestString always starts with url
	        var requestString:String = url;        
	        
	        if (paramsString != "") {
	            var lastServerChar:String = url.charAt(url.length - 1);
	            if ((lastServerChar == "&") || (lastServerChar == "?")) {
	                requestString += paramsString;
	            } else {
	                if (url.indexOf('?') == -1) {
	                    //serverPath has no ? -- add one
	                    requestString += '?' + paramsString;
	                } else {
	                    //serverPath contains ?, so must already have 
	                    // paramsString at the end
	                    requestString += '&' + paramsString;
	                }
	            }
	        }
	        return requestString;
	    }
 		    

	    /** 
	     * APIMethod: setUrl
	     * 
	     * Parameters:
	     * newUrl - {String}
	     */
	    public function setUrl(newUrl:String):void {
	        this.url = newUrl;
	    }
	    

	
	    /**
	     * APIMethod: mergeNewParams
	     * 
	     * Parameters:
	     * newParams - {Object}
	     *
	     * Returns:
	     * redrawn: {Boolean} whether the layer was actually redrawn.
	     */
	    public function mergeNewParams(newParams:Object):Boolean {
	        this.params = Util.SetOptions(this.params, newParams);
	        return this.redraw();
	    }
	

	    /**
	     * Method: setZIndex
	     * 
	     * Parameters: 
	     * zIndex - {Integer}
	     */    
	    public function setZIndex(zIndex:int):void {
//	        this.div.style.zIndex = zIndex;
	    }
	
	    /**
	     * Method: adjustBounds
	     * This function will take a bounds, and if wrapDateLine option is set
	     *     on the layer, it will return a bounds which is wrapped around the 
	     *     world. We do not wrap for bounds which *cross* the 
	     *     maxExtent.left/right, only bounds which are entirely to the left 
	     *     or entirely to the right.
	     * 
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>}
	     */
	    protected function adjustBounds(bounds:Bounds):Bounds {
	
	        if (this.gutter) {
	            // Adjust the extent of a bounds in map units by the 
	            // layer's gutter in pixels.
	            var mapGutter:Number = this.gutter * this.map.getResolution();
	            bounds = new Bounds(bounds.left - mapGutter,
	                                           bounds.bottom - mapGutter,
	                                           bounds.right + mapGutter,
	                                           bounds.top + mapGutter);
	        }
	
	        if (this.wrapDateLine) {
	            // wrap around the date line, within the limits of rounding error
	            var wrappingOptions:Object = {   'rightTolerance':this.getResolution() };    
	            bounds = bounds.wrapDateLine(this.maxExtent, wrappingOptions);
	                              
	        }
	        return bounds;
	    }
		
		
	}
}

