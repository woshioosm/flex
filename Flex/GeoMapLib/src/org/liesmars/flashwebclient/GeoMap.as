/* Copyright (c) 2006-2008 MetaCarta, Inc., published under the Clear BSD
* license.  See http://svn.openlayers.org/trunk/openlayers/license.txt for the
* full text of the license. */

/**
 * @requires OpenLayers/Util.js
 * @requires OpenLayers/Events.js
 * @requires OpenLayers/Tween.js
 */

/**
 * Class: OpenLayers.Map
 * Instances of OpenLayers.Map are interactive maps embedded in a web page.
 * Create a new map with the <OpenLayers.Map> constructor.
 * 
 * On their own maps do not provide much functionality.  To extend a map
 * it's necessary to add controls (<OpenLayers.Control>) and 
 * layers (<OpenLayers.Layer>) to the map. 
 */

package org.liesmars.flashwebclient {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.Security;
	
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.effects.*;
	import mx.events.CloseEvent;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	
	import org.liesmars.flashwebclient.BaseTypes.Bounds;
	import org.liesmars.flashwebclient.BaseTypes.LonLat;
	import org.liesmars.flashwebclient.BaseTypes.Pixel;
	import org.liesmars.flashwebclient.BaseTypes.Size;
	import org.liesmars.flashwebclient.Event.*;
	import org.liesmars.flashwebclient.GeoEvent.IndexEvent;
	import org.liesmars.flashwebclient.GeoEvent.MapEvent;
	import org.liesmars.flashwebclient.GeoEvent.MapReLocateEvent;
	import org.liesmars.flashwebclient.Handler.*;
	import org.liesmars.flashwebclient.Handler.Draw.*;
	import org.liesmars.flashwebclient.Handler.Edit.*;
	import org.liesmars.flashwebclient.Handler.GeoRequest.*;
	import org.liesmars.flashwebclient.Layer.*;
	import org.liesmars.flashwebclient.Layer.Raster.GeoGlobe;
	import org.liesmars.flashwebclient.Layer.Raster.Tianditu;
	import org.liesmars.flashwebclient.Layer.Raster.WMTS;
	import org.liesmars.flashwebclient.SearchImp.SearchPoint;
	import org.liesmars.flashwebclient.component.IndexProgressBar;
	
	public class GeoMap extends EventDispatcher  {
		
		
		
		//	   /**
		//	     * Constant: Z_INDEX_BASE
		//	     * {Object} Base z-indexes for different classes of thing 
		//	     */
		//	    Z_INDEX_BASE: { BaseLayer: 100, Overlay: 325, Popup: 750, Control: 1000 },
		//	
		//	    /**
		//	     * Constant: EVENT_TYPES
		//	     * {Array(String)} Supported application event types.  Register a listener
		//	     *     for a particular event with the following syntax:
		//	     * (code)
		//	     * map.events.register(type, obj, listener);
		//	     * (end)
		//	     *
		//	     * Listeners will be called with a reference to an event object.  The
		//	     *     properties of this event depends on exactly what happened.
		//	     *
		//	     * All event objects have at least the following properties:
		//	     *  - *object* {Object} A reference to map.events.object.
		//	     *  - *element* {DOMElement} A reference to map.events.element.
		//	     *
		//	     * Browser events have the following additional properties:
		//	     *  - *xy* {<OpenLayers.Pixel>} The pixel location of the event (relative
		//	     *      to the the map viewport).
		//	     *  - other properties that come with browser events
		//	     *
		//	     * Supported map event types:
		//	     *  - *preaddlayer* triggered before a layer has been added.  The event
		//	     *      object will include a *layer* property that references the layer  
		//	     *      to be added.
		//	     *  - *addlayer* triggered after a layer has been added.  The event object
		//	     *      will include a *layer* property that references the added layer.
		//	     *  - *removelayer* triggered after a layer has been removed.  The event
		//	     *      object will include a *layer* property that references the removed
		//	     *      layer.
		//	     *  - *changelayer* triggered after a layer name change, order change, or
		//	     *      visibility change (due to resolution thresholds).  Listeners will
		//	     *      receive an event object with *layer* and *property* properties.  The
		//	     *      *layer* property will be a reference to the changed layer.  The
		//	     *      *property* property will be a key to the changed property (name,
		//	     *      visibility, or order).
		//	     *  - *movestart* triggered after the start of a drag, pan, or zoom
		//	     *  - *move* triggered after each drag, pan, or zoom
		//	     *  - *moveend* triggered after a drag, pan, or zoom completes
		//	     *  - *popupopen* triggered after a popup opens
		//	     *  - *popupclose* triggered after a popup opens
		//	     *  - *addmarker* triggered after a marker has been added
		//	     *  - *removemarker* triggered after a marker has been removed
		//	     *  - *clearmarkers* triggered after markers have been cleared
		//	     *  - *mouseover* triggered after mouseover the map
		//	     *  - *mouseout* triggered after mouseout the map
		//	     *  - *mousemove* triggered after mousemove the map
		//	     *  - *dragstart* triggered after the start of a drag
		//	     *  - *drag* triggered after a drag
		//	     *  - *dragend* triggered after the end of a drag
		//	     *  - *changebaselayer* triggered after the base layer changes
		//	     */
		//	    EVENT_TYPES: [ 
		//	        "preaddlayer", "addlayer", "removelayer", "changelayer", "movestart",
		//	        "move", "moveend", "zoomend", "popupopen", "popupclose",
		//	        "addmarker", "removemarker", "clearmarkers", "mouseover",
		//	        "mouseout", "mousemove", "dragstart", "drag", "dragend",
		//	        "changebaselayer"],
		//		
		public  var mapOffsetX:int; // 地图舞台偏移 拖拽时的问题
		public  var mapOffsetY:int;
		[Embed(source="assert/pencil.png")]
		private var drawHand:Class;
		public var vectorLayer:VectorLayer;
		private var cursorID:Number=-1;
		/**
		 * Constant: TILE_WIDTH
		 * {Integer} 256 Default tile width (unless otherwise specified)
		 */
		public  const TILE_WIDTH:Number = 256;
		/**
		 * Constant: TILE_HEIGHT
		 * {Integer} 256 Default tile height (unless otherwise specified)
		 */
		public  const TILE_HEIGHT:Number = 256;
		
		/**
		 * Property: id
		 * {String} Unique identifier for the map
		 */
		private var id:String = null;
		
		private var snapShot:Image = null;
		/**
		 * Property: fractionalZoom
		 * {Boolean} For a base layer that supports it, allow the map resolution
		 *     to be set to a value between one of the values in the resolutions
		 *     array.  Default is false.
		 *
		 * When fractionalZoom is set to true, it is possible to zoom to
		 *     an arbitrary extent.  This requires a base layer from a source
		 *     that supports requests for arbitrary extents (i.e. not cached
		 *     tiles on a regular lattice).  This means that fractionalZoom
		 *     will not work with commercial layers (Google, Yahoo, VE), layers
		 *     using TileCache, or any other pre-cached data sources.
		 *
		 * If you are using fractionalZoom, then you should also use
		 *     <getResolutionForZoom> instead of layer.resolutions[zoom] as the
		 *     former works for non-integer zoom levels.
		 */
		public var fractionalZoom:Boolean = false;
		
		/**
		 * APIProperty: div
		 * {DOMElement} The element that contains the map
		 */
		public var sprite:Sprite;
		
		/**
		 * Property: dragging
		 * {Boolean} The map is currently being dragged.
		 */
		private var dragging:Boolean = false;
		
		/**
		 * Property: size
		 * {<OpenLayers.Size>} Size of the main div (this.div)
		 */
		private var size:Size = null;
		
		/**
		 * Property: viewPortDiv
		 * {HTMLDivElement} The element that represents the map viewport
		 */
		public var viewPort:Sprite = null;
		
		/**
		 * Property: layerContainerOrigin
		 * {<OpenLayers.LonLat>} The lonlat at which the later container was
		 *                       re-initialized (on-zoom)
		 */
		private var layerContainerOrigin:LonLat = null;
		
		/**
		 * Property: layerContainerDiv
		 * {HTMLDivElement} The element that contains the layers.
		 */
		public var layerContainer:Sprite = null;
		
		private var ctrLayer:Sprite = null;
		/**
		 * APIProperty: layers
		 * {Array(<OpenLayers.Layer>)} Ordered list of layers in the map
		 */
		public var layers:Array = null;
		
		/**
		 * APIProperty: baseLayer
		 * {<OpenLayers.Layer>} The currently selected base layer.  This determines
		 * min/max zoom level, projection, etc.
		 */
		public var baseLayer:Layer = null;
		
		/**
		 * Property: center
		 * {<OpenLayers.LonLat>} The current center of the map
		 */
		public var center:LonLat = null;
		
		/**
		 * Property: resolution
		 * {Float} The resolution of the map.
		 */
		public var resolution:Number;
		
		/**
		 * Property: zoom
		 * {Integer} The current zoom level of the map
		 */
		public var zoom:int = 0;
		
		/**
		 * Property: viewRequestID
		 * {String} Used to store a unique identifier that changes when the map 
		 *          view changes. viewRequestID should be used when adding data 
		 *          asynchronously to the map: viewRequestID is incremented when 
		 *          you initiate your request (right now during changing of 
		 *          baselayers and changing of zooms). It is stored here in the 
		 *          map and also in the data that will be coming back 
		 *          asynchronously. Before displaying this data on request 
		 *          completion, we check that the viewRequestID of the data is 
		 *          still the same as that of the map. Fix for #480
		 */
		public var viewRequestID:int = 0;
		
		/**
		 * APIProperty: tileSize
		 * {<OpenLayers.Size>} Set in the map options to override the default tile
		 *                     size for this map.
		 */
		public var tileSize:Size = null;
		
		/**
		 * APIProperty: projection
		 * {String} Set in the map options to override the default projection 
		 *          string this map - also set maxExtent, maxResolution, and 
		 *          units if appropriate.
		 */
		public var projection:String = "EPSG:4326";    
		
		/**
		 * APIProperty: units
		 * {String} The map units.  Defaults to 'degrees'.  Possible values are
		 *          'degrees' (or 'dd'), 'm', 'ft', 'km', 'mi', 'inches'.
		 */
		public var units:String = 'degrees';
		
		/**
		 * APIProperty: resolutions
		 * {Array(Float)} A list of map resolutions (map units per pixel) in 
		 *     descending order.  If this is not set in the layer constructor, it 
		 *     will be set based on other resolution related properties 
		 *     (maxExtent, maxResolution, maxScale, etc.).
		 */
		public var resolutions:Array = null;
		
		
		public var scales:Array = null;
		
		/**
		 * APIProperty: maxResolution
		 * {Float} Default max is 360 deg / 256 px, which corresponds to
		 *          zoom level 0 on gmaps.  Specify a different value in the map 
		 *          options if you are not using a geographic projection and 
		 *          displaying the whole world.
		 */
		public var maxResolution:Number = 1.40625;
		
		/**
		 * APIProperty: minResolution
		 * {Float}
		 */
		public var minResolution:Number;
		
		/**
		 * APIProperty: maxScale
		 * {Float}
		 */
		public var maxScale:Number;
		
		/**
		 * APIProperty: minScale
		 * {Float}
		 */
		public var minScale:Number;
		
		/**
		 * APIProperty: maxExtent
		 * {<OpenLayers.Bounds>} The maximum extent for the map.  Defaults to the
		 *                       whole world in decimal degrees 
		 *                       (-180, -90, 180, 90).  Specify a different
		 *                        extent in the map options if you are not using a 
		 *                        geographic projection and displaying the whole 
		 *                        world.
		 */
		public var maxExtent:Bounds = new Bounds(-180, -90, 180, 90);
		
		/**
		 * APIProperty: minExtent
		 * {<OpenLayers.Bounds>}
		 */
		public var minExtent:Bounds = null;
		
		/**
		 * APIProperty: restrictedExtent
		 * {<OpenLayers.Bounds>} Limit map navigation to this extent where possible.
		 *     If a non-null restrictedExtent is set, panning will be restricted
		 *     to the given bounds.  In addition, zooming to a resolution that
		 *     displays more than the restricted extent will center the map
		 *     on the restricted extent.  If you wish to limit the zoom level
		 *     or resolution, use maxResolution.
		 */
		public var restrictedExtent:Bounds = null;
		
		/**
		 * APIProperty: numZoomLevels
		 * {Integer} Number of zoom levels for the map.  Defaults to 16.  Set a
		 *           different value in the map options if needed.
		 */
		public var numZoomLevels:int = 17;
		
		/**
		 * APIProperty: numZoomLevels
		 * {Integer} Number of zoom levels for the map.  Defaults to 16.  Set a
		 *           different value in the map options if needed.
		 */
		public var maxZoomLevel:int = 16;
		
		/**
		 * APIProperty: numZoomLevels
		 * {Integer} Number of zoom levels for the map.  Defaults to 16.  Set a
		 *           different value in the map options if needed.
		 */
		public var handler:Handler;    
		
		public var dHandler:Draw;    
		
		public var eHandler:Handler;
		
		public var pHandler:lkRequest;
		public var drHandler:DrawRect;
		public var coord:Pixel;
		
		
		public var evtObj:Sprite=null;//用于接收所有的鼠标事件，它不在this.canvas里头
		
		/**
		 * Constructor: OpenLayers.Map
		 * Constructor for a new OpenLayers.Map instance.
		 *
		 * Parameters:
		 * div - {String} Id of an element in your page that will contain the map.
		 * options - {Object} Optional object with properties to tag onto the map.
		 *
		 * Examples:
		 * (code)
		 * // create a map with default options in an element with the id "map1"
		 * var map = new OpenLayers.Map("map1");
		 *
		 * // create a map with non-default options in an element with id "map2"
		 * var options = {
		 *     maxExtent: new OpenLayers.Bounds(-200000, -200000, 200000, 200000),
		 *     maxResolution: 156543,
		 *     units: 'm',
		 *     projection: "EPSG:41001"
		 * };
		 * var map = new OpenLayers.Map("map2", options);
		 * (end)
		 */    
		
		public function GeoMap(mapcontainer:Sprite, options:Object) {
			// Simple-type defaults are set in class definition. 
			//  Now set complex-type defaults 
			this.tileSize = new  Size(this.TILE_WIDTH, this.TILE_HEIGHT);
			
			this.maxExtent = new Bounds(-180, -90, 180, 90);
			
			// now override default options 
			Util.SetOptions(this, options);
			
			this.id = Util.CreateId("liesmars.Map_");
			
			
			this.sprite = mapcontainer;
			
			// the viewPortDiv is the outermost div we modify
			this.viewPort = new Sprite();
			this.sprite.addChild(this.viewPort);
			
			this.layerContainer = new Sprite();
			this.viewPort.addChild(layerContainer);
			
			this.updateSize();
//			this.SetEvtObj();
			
			var key:KeyMoveMap=new KeyMoveMap(this,{});
			key.Active();
			
			var wheel:WheelZoom=new WheelZoom(this,{});
			wheel.Active();	
			
//			this.EvtObjMoveAway();
			this.drag();
			
			this.layers = [];
			
			
			
			//this.sprite.addEventListener(MouseEvent.MOUSE_OVER,tt);
		}
		
		/**
		 * APIMethod: setOptions
		 * Change the map options
		 *
		 * Parameters:
		 * options - {Object} Hashtable of options to tag to the map
		 */
		public function setOptions(options:Object):void {
			Util.SetOptions(this, options);
		}
		
		/**
		 * APIMethod: getTileSize
		 * Get the tile size for the map
		 *
		 * Returns:
		 * {<OpenLayers.Size>}
		 */
		public function getTileSize():Size {
			return this.tileSize;
		}
		
		/********************************************************/
		/*                                                      */
		/*                  Layer Functions                     */
		/*                                                      */
		/*     The following functions deal with adding and     */
		/*        removing Layers to and from the Map           */
		/*                                                      */
		/********************************************************/         
		
		/**
		 * APIMethod: getLayer
		 * Get a layer based on its id
		 *
		 * Parameter:
		 * id - {String} A layer id
		 *
		 * Returns:
		 * {<OpenLayers.Layer>} The Layer with the corresponding id from the map's 
		 *                      layer collection, or null if not found.
		 */
		public function getLayer(id:String):Layer {
			var foundLayer:Layer = null;
			for (var i:int = 0; i < this.layers.length; i++) {
				var layer:Layer = this.layers[i];
				if (layer.id == id) {
					foundLayer = layer;
					break;
				}
			}
			return foundLayer;
		}
		
		/**
		 * APIMethod: getLayer
		 * Get a layer based on its id
		 *
		 * Parameter:
		 * id - {String} A layer id
		 *
		 * Returns:
		 * {<OpenLayers.Layer>} The Layer with the corresponding id from the map's 
		 *                      layer collection, or null if not found.
		 */
		public function getLayerByName(name:String):Layer {
			var foundLayer:Layer = null;
			for (var i:int = 0; i < this.layers.length; i++) {
				var layer:Layer = this.layers[i];
				if (layer.layername == name) {
					foundLayer = layer;
					break;
				}
			}
			return foundLayer;
		}
		
		/**
		 * APIMethod: addLayer
		 *
		 * Parameters:
		 * layer - {<OpenLayers.Layer>} 
		 */    
		public function addLayer(layer:Layer):void {
//			if(layer is VectorLayer){
//				this.evtObj.addChild(layer);
//			}
			if(layer is VectorLayer){
				this.vectorLayer=layer as VectorLayer;
			}
			for(var i:int=0; i < this.layers.length; i++) {
				if (this.layers[i] == layer) {
					trace('layerAlreadyAdded'+ 'layerName:'+layer.layername);
					return ;
				}
			}    
			
			if (false){
				this.viewPort.addChild(layer.sprite);
			} else {
				this.layerContainer.addChild(layer.sprite);
			}
			this.layers.push(layer);
			layer.setMap(this);
			//如果当前图层为底图（基图），但是当前地图容器中没有基图，则把当前图层设置为容器中的底图 by WCZ 4-13
			if (layer.isBaseLayer)  {
				if (this.baseLayer == null) {
					// set the first baselaye we add as the baselayer
					this.setBaseLayer(layer);
				} else {
					layer.setVisibility(false);
				}
			} else {
				// layer.redraw();
			}
			trace(layer.x+" "+layer.y+" "+layer.width+" "+layer.height);
		}
		
		/**
		 * APIMethod: addLayers 
		 *
		 * Parameters:
		 * layers - {Array(<OpenLayers.Layer>)} 
		 */    
		public function addLayers(layers:Array):void {
			for (var i:int = 0; i <  layers.length; i++) {
				this.addLayer(layers[i] as Layer);
			}
		}
		
		public function AddControl(control:Control):void
		{
			if(!this.ctrLayer)
			{this.ctrLayer=new Sprite();this.sprite.stage.addChild(this.ctrLayer);}
			
			this.ctrLayer.addChild(control);//控件的位置由控件的x,y坐标控制		
		}
		public function AddControls(ctrs:Array):void
		{
			for(var i:int=0;i<ctrs.length;i++)
			{
				this.AddControl(ctrs[i] as Control);
			}
		}
		
		public function setMaskMarkImage(percent:Number,direction:Number):void
		{
			for(var i:Number = 0;i < layers.length;i++)
			{
				var layer:Layer = layers[i] as Layer;
				if(layer.isMasked)	{
					
					layer.setMask(percent,direction);
				}
			}
		}
		
		/** 
		 * APIMethod: removeLayer
		 * Removes a layer from the map by removing its visual element (the 
		 *   layer.div property), then removing it from the map's internal list 
		 *   of layers, setting the layer's map property to null. 
		 * 
		 *   a "removelayer" event is triggered.
		 * 
		 *   very worthy of mention is that simply removing a layer from a map
		 *   will not cause the removal of any popups which may have been created
		 *   by the layer. this is due to the fact that it was decided at some
		 *   point that popups would not belong to layers. thus there is no way 
		 *   for us to know here to which layer the popup belongs.
		 *    
		 *     A simple solution to this is simply to call destroy() on the layer.
		 *     the default OpenLayers.Layer class's destroy() function
		 *     automatically takes care to remove itself from whatever map it has
		 *     been attached to. 
		 * 
		 *     The correct solution is for the layer itself to register an 
		 *     event-handler on "removelayer" and when it is called, if it 
		 *     recognizes itself as the layer being removed, then it cycles through
		 *     its own personal list of popups, removing them from the map.
		 * 
		 * Parameters:
		 * layer - {<OpenLayers.Layer>} 
		 * setNewBaseLayer - {Boolean} Default is true
		 */
		public function removeLayer(layer:Layer, setNewBaseLayer:Boolean = true):void {
			
			if (false) {
				this.viewPort.removeChild(layer.sprite);
			} else {
				this.layerContainer.removeChild(layer.sprite);
			}
			Util.RemoveItem(this.layers, layer);
			layer.removeMap(this);
			layer.map = null;
			
			// if we removed the base layer, need to set a new one
			if(this.baseLayer == layer) {
				this.baseLayer = null;
				if(setNewBaseLayer) {
					for(var i:int=0; i < this.layers.length; i++) {
						var iLayer:Layer = this.layers[i];
						if (iLayer.isBaseLayer) {
							this.setBaseLayer(iLayer);
							break;
						}
					}
				}
			}
		}
		
		/**
		 * APIMethod: getNumLayers
		 * 
		 * Returns:
		 * {Int} The number of layers attached to the map.
		 */
		public function getNumLayers():int {
			return this.layers.length;
		}
		
		/** 
		 * APIMethod: setBaseLayer
		 * Allows user to specify one of the currently-loaded layers as the Map's
		 *     new base layer.
		 * 
		 * Parameters:
		 * newBaseLayer - {<OpenLayers.Layer>}
		 */
		public function setBaseLayer(newBaseLayer:Layer):void {
			var oldExtent:Bounds = null;
			//如果当前底图存在，那么获取当前地图的范围为上一级范围 by WCZ 4-13
			if (this.baseLayer) {
				oldExtent = this.baseLayer.getExtent();
			}
			
			//如果新的底图和当前底图不同时，则需要将当前底图设置为不可见,并把新的底图赋值给当前底图 by WCZ 4-13
			if (newBaseLayer != this.baseLayer) {    
				
				// make the old base layer invisible 
				if (this.baseLayer != null) {
					this.baseLayer.setVisibility(false);
				}
				
				// set new baselayer
				this.baseLayer = newBaseLayer;
				
				// Increment viewRequestID since the baseLayer is 
				// changing. This is used by tiles to check if they should 
				// draw themselves.
				this.viewRequestID++;
				//this.baseLayer.visibility = true;
				
				//redraw all layers
				var center:LonLat = this.getCenter();
				if (center != null) {
					
					//either get the center from the old Extent or just from
					// the current center of the map. 
					var newCenter:LonLat = (oldExtent) 
						? oldExtent.getCenterLonLat()
						: center;
					
					//the new zoom will either come from the old Extent or 
					// from the current resolution of the map                                                
					var newZoom:int = (oldExtent)  
						? this.getZoomForExtent(oldExtent, true) 
						: this.getZoomForResolution(this.resolution, true);
					
					// zoom and force zoom change
					this.setCenter(newCenter, newZoom, false, true);
				}
			}        
		}    
		
		/**
		 * APIMethod: getSize
		 * 
		 * Returns:
		 * {<OpenLayers.Size>} An <OpenLayers.Size> object that represents the 
		 *                     size, in pixels, of the div into which OpenLayers 
		 *                     has been loaded. 
		 *                     Note - A clone() of this locally cached variable is
		 *                     returned, so as not to allow users to modify it.
		 */
		public function getSize():Size {
			var size:Size = null;
			if (this.size != null) {
				size = this.size.clone();
			}
			return size;
		}
		
		/**
		 * APIMethod: updateSize
		 * This function should be called by any external code which dynamically
		 *     changes the size of the map div (because mozilla wont let us catch 
		 *     the "onresize" for an element)
		 */
		public function updateSize():void {
			// the div might have moved on the page, also
			//        this.events.element.offsets = null;
			this.sprite.width=this.sprite.parent.width;
			this.sprite.height=this.sprite.parent.height;
			var newSize:Size = this.getCurrentSize();
			var oldSize:Size = this.getSize();
			if (oldSize == null) {
				this.size = oldSize = newSize;
				
				this.sprite.scrollRect = new Rectangle(0, 0, this.size.w, this.size.h );            
				//			this.viewPort.scrollRect = new Rectangle(0, 0, this.size.w, this.size.h );
			}
			if (!newSize.equals(oldSize)) {
				
				// store the new size
				this.size = newSize;
				
				this.sprite.scrollRect = new Rectangle(0, 0, this.size.w, this.size.h );            
				//			this.viewPort.scrollRect = new Rectangle(0, 0, this.size.w, this.size.h );
				
				//notify layers of mapresize
				for(var i:int=0; i < this.layers.length; i++) {
					this.layers[i].onMapResize();                
				}
				
				if (this.baseLayer != null) {
					var center:Pixel = new Pixel(newSize.w /2, newSize.h / 2);
					var centerLL:LonLat = this.getLonLatFromViewPortPx(center);
					var zoom:int = this.getZoom();
					this.zoom = -1;
					this.setCenter(this.getCenter(), zoom);
				}
				
			}
		}
		
		/**
		 * APIMethod: useRemoteMode
		 * This function set the param UseLocalMode(typeof boolean) in Util
		 * to decide the mode of drawing vectors
		 * if the UseLocalMode is false, each time when user do the operation of pan or zoom
		 * flash client will send request to the server to get new data
		 */
		public function useRemoteMode():void{
			Util.UseLocalMode = false;
		}
		
		/**
		 * APIMethod: useRemoteMode
		 * This function set the param UseLocalMode(typeof boolean) in Util
		 * to decide the mode of drawing vectors
		 * if the UseLocalMode is true, the flash client will ask for all data at the first time
		 * and build the index of each vector layer
		 * when user do the operation of pan or zoom, the flash client will get data from the local memory
		 */
		public function useLocalMode():void{
			Util.UseLocalMode = true;
			for(var i:int=0;i<this.layers.length;i++){
				if(this.layers[i] instanceof Vector){
					if((this.layers[i] as Vector).index == null){
						Alert.yesLabel = "确定";
						Alert.noLabel  = "取消";
						Alert.show("第一次使用本地方法，索引未建立，是否现在建立索引？","消息提示",Alert.NO|Alert.YES,null,alertHandler);
						//Alert.buttonWidth = 120;
						break;
					}
				}
			}
		}
		private var progressComponent:IndexProgressBar;
		private var date1:Date,date2:Date;
		private function alertHandler(e:CloseEvent):void{
			if(e.detail == Alert.YES){
				date1 = new Date();
				var creator:IndexCreator = new IndexCreator(this);
				this.sprite.addEventListener(IndexEvent.ALL_INDEX_FINISHED, IndexHandler);
				creator.createIndexForAllLayers();
				progressComponent = new IndexProgressBar();
				PopUpManager.addPopUp(progressComponent,this.sprite,true);
				PopUpManager.centerPopUp(progressComponent);
			}
			else{
				// do nothing
			}
		}  	
		
		private function IndexHandler(e:IndexEvent):void{
			this.sprite.removeEventListener(IndexEvent.ALL_INDEX_FINISHED,IndexHandler);
			PopUpManager.removePopUp(progressComponent);
			date2 = new Date();
			Alert.yesLabel = "确定";
			Alert.show("索引建立完成，共耗时"+(date2.getTime()-date1.getTime())+"毫秒","消息提示",Alert.YES);
			
		}
		/**
		 * Refresh all the vector layers
		 */
		public function Refresh():void{
			
		}
		
		/**
		 * Method: getCurrentSize
		 * 
		 * Returns:
		 * {<OpenLayers.Size>} A new <OpenLayers.Size> object with the dimensions 
		 *                     of the map div
		 */
		private function getCurrentSize():Size {
			var size:Size;
			
			size = new Size(this.sprite.width, this.sprite.height);
			return size;
		}
		
		/** 
		 * Method: calculateBounds
		 * 
		 * Parameters:
		 * center - {<OpenLayers.LonLat>} Default is this.getCenter()
		 * resolution - {float} Default is this.getResolution() 
		 * 
		 * Returns:
		 * {<OpenLayers.Bounds>} A bounds based on resolution, center, and 
		 *                       current mapsize.
		 */
		public function calculateBounds(center:LonLat = null, resolution:Number = -1):Bounds {
			
			var extent:Bounds = null;
			
			if (center == null) {
				center = this.getCenter();
			}   
			
			resolution = this.getResolution();
			
			if ((center != null)) { 
				
				var size:Size = this.getSize();
				var w_deg:Number = size.w * resolution;
				var h_deg:Number = size.h * resolution;
				
				extent = new Bounds(center.lon - w_deg / 2,
					center.lat - h_deg / 2,
					center.lon + w_deg / 2,
					center.lat + h_deg / 2);
				
			}
			
			return extent;
		}
		
		
		/********************************************************/
		/*                                                      */
		/*            Zoom, Center, Pan Functions               */
		/*                                                      */
		/*    The following functions handle the validation,    */
		/*   getting and setting of the Zoom Level and Center   */
		/*       as well as the panning of the Map              */
		/*                                                      */
		/********************************************************/
		/**
		 * APIMethod: getCenter
		 * 
		 * Returns:
		 * {<OpenLayers.LonLat>}
		 */
		public function getCenter():LonLat {
			return this.center;
		}
		
		
		/**
		 * APIMethod: getZoom
		 * 
		 * Returns:
		 * {Integer}
		 */
		public function getZoom():int {
			return this.zoom;
		}
		
		/** 
		 * APIMethod: pan
		 * Allows user to pan by a value of screen pixels
		 * 
		 * Parameters:
		 * dx - {Integer}
		 * dy - {Integer}
		 * options - {Object} Options to configure panning:
		 *  - *animate* {Boolean} Use panTo instead of setCenter. Default is true.
		 *  - *dragging* {Boolean} Call setCenter with dragging true.  Default is
		 *    false.
		 */
		public function pan(dx:int, dy:int, options:Object):void {
			// this should be pushed to applyDefaults and extend
			if (!options) {
				options = {};
			}
			
			Util.SetOptions(options,{animate:true, dragging:false});
			
			// getCenter
			var centerPx:Pixel = this.getViewPortPxFromLonLat(this.getCenter());
			
			// adjust
			var newCenterPx:Pixel = centerPx.add(dx, dy);
			
			// only call setCenter if not dragging or there has been a change
			if (!options.dragging || !newCenterPx.equals(centerPx)) {
				var newCenterLonLat:LonLat = this.getLonLatFromViewPortPx(newCenterPx);
				if (options.animate) {
					this.panTo(newCenterLonLat);
				} else {
					this.setCenter(newCenterLonLat, options.dragging);
				}    
			}
			
		}
		
		public function panLeft(p:int = - 150):void {
			this.pan(p, 0, {});
		}
		
		public function panRight(p:int =  150):void {
			this.pan(p, 0, {}); 	
		}
		
		public function panUp(p:int =  -150):void {
			this.pan(0, p, {});
		}
		
		public function panBottom(p:int =  150):void {
			this.pan(0, p, {});
		}
		/** 
		 * APIMethod: panTo
		 * Allows user to pan to a new lonlat
		 * If the new lonlat is in the current extent the map will slide smoothly
		 * 
		 * Parameters:
		 * lonlat - {<OpenLayers.Lonlat>}
		 */
		public function panTo(lonlat:LonLat):void {
			this.setCenter(lonlat, this.zoom);
		}
		
		/**
		 * APIMethod: setCenter
		 * 
		 * Parameters:
		 * lonlat - {<OpenLayers.LonLat>}
		 * zoom - {Integer}
		 * dragging - {Boolean} Specifies whether or not to trigger 
		 *                      movestart/end events
		 * forceZoomChange - {Boolean} Specifies whether or not to trigger zoom 
		 *                             change events (needed on baseLayer change)
		 *
		 * TBD: reconsider forceZoomChange in 3.0
		 */
		public function setCenter(lonlat:LonLat, zoom:int = 0, dragging:Boolean = false, forceZoomChange:Boolean = false):void {
			this.dispatchEvent(new MapReLocateEvent(MapReLocateEvent.MAP_RELOCATE,lonlat,zoom));
			this.moveTo(lonlat, zoom, {
				'dragging': dragging,
				'forceZoomChange': forceZoomChange,
				'caller': 'setCenter'
			});
			
			//this.Redraw();
		}
		
		/**
		 * Method: moveTo
		 *
		 * Parameters:
		 * lonlat - {<OpenLayers.LonLat>}
		 * zoom - {Integer}
		 * options - {Object}
		 */
		private function moveTo(lonlat:LonLat, zoom:int, options:Object):void {
			
			// 2009-01-18 case: the map has no baselayer; return reason hints//
			if(zoom < 0)
			{
				zoom = 0;
			}
			
			if(!this.baseLayer) 
			{
				trace("error: this map no baselayer for display");
				return;
			}
			
			
			if (!options) { 
				options = {};
			}    
			// dragging is false by default
			var dragging:Boolean = options.dragging;
			// forceZoomChange is false by default
			var forceZoomChange:Boolean = options.forceZoomChange;
			// noEvent is false by default
			var noEvent:Boolean = options.noEvent;    
			
			if (!this.center && !this.isValidLonLat(lonlat)) {
				lonlat = this.maxExtent.getCenterLonLat();
			}
			
			if(this.restrictedExtent != null) {
				// In 3.0, decide if we want to change interpretation of maxExtent.
				if(lonlat == null) { 
					lonlat = this.getCenter(); 
				}
				zoom = this.getZoom(); 
				
				var resolution:Number = this.getResolutionForZoom(zoom);
				var extent:Bounds = this.calculateBounds(lonlat, resolution); 
				if(!this.restrictedExtent.containsBounds(extent)) {
					var maxCenter:LonLat = this.restrictedExtent.getCenterLonLat(); 
					if(extent.getWidth() > this.restrictedExtent.getWidth()) { 
						lonlat = new LonLat(maxCenter.lon, lonlat.lat); 
					} else if(extent.left < this.restrictedExtent.left) {
						lonlat = lonlat.add(this.restrictedExtent.left -
							extent.left, 0); 
					} else if(extent.right > this.restrictedExtent.right) { 
						lonlat = lonlat.add(this.restrictedExtent.right -
							extent.right, 0); 
					} 
					if(extent.getHeight() > this.restrictedExtent.getHeight()) { 
						lonlat = new LonLat(lonlat.lon, maxCenter.lat); 
					} else if(extent.bottom < this.restrictedExtent.bottom) { 
						lonlat = lonlat.add(0, this.restrictedExtent.bottom -
							extent.bottom); 
					} 
					else if(extent.top > this.restrictedExtent.top) { 
						lonlat = lonlat.add(0, this.restrictedExtent.top -
							extent.top); 
					} 
				}
			}
			trace(zoom +" : "+this.getZoom()+" "+this.isValidZoomLevel(zoom));
			var zoomChanged:Boolean = forceZoomChange || (
				(this.isValidZoomLevel(zoom)) && 
				(zoom != this.getZoom()) );
			
			//在不同的缩放级别上，地图的中心点是不会发生改变的 by WCZ 4-14
			var centerChanged:Boolean = (this.isValidLonLat(lonlat)) && 
				(!lonlat.equals(this.center));
			
			
			// if neither center nor zoom will change, no need to do anything
			if (zoomChanged || centerChanged || !dragging) {
				
				if (!this.dragging && !noEvent) {
					//                this.events.triggerEvent("movestart");
				}
				
				if (centerChanged) {
					if ((!zoomChanged) && (this.center)) { 
						// if zoom hasnt changed, just slide layerContainer
						//  (must be done before setting this.center to new value)
						this.centerLayerContainer(lonlat);
					}
					this.center = lonlat.clone();
				}
				
				// (re)set the layerContainerDiv's location
				if ((zoomChanged) || (this.layerContainerOrigin == null)) {
					this.layerContainerOrigin = this.center.clone();
					this.layerContainer.x = 0;
					this.layerContainer.y = 0;
				}
				
				if (zoomChanged) {
					
					var dzoom:int = zoom - this.zoom;//计算缩放级别的偏移量 by WCZ 4-14
					//            	this.showSnapShot(dzoom);
					
					this.zoom = zoom;//将缩放到的级别赋值给当前图层 by WCZ 4-14
					this.resolution = this.getResolutionForZoom(zoom);//从缩放级别获取分辨率 by WCZ 4-14
					// zoom level has changed, increment viewRequestID.
					this.viewRequestID++;
				}  else {
					//            	if(this.snapShot) this.snapShot.visible = false;
				}  
				
				var bounds:Bounds = this.getExtent();
				
				//send the move call to the baselayer and all the overlays    
				if(this.baseLayer.visibility){
					this.baseLayer.moveTo(bounds, zoomChanged, dragging);
				}
				
				bounds = this.baseLayer.getExtent();
				
				for (var i:int = 0; i < this.layers.length; i++) {
					var layer:Layer = this.layers[i] as Layer;
					if (!layer.isBaseLayer) {
						
						var inRange:Boolean = layer.calculateInRange();//从比例尺和分辨率方面判断 by WCZ 4-18
						if (layer.inRange != inRange) {
							// the inRange property has changed. If the layer is
							// no longer in range, we turn it off right away. If
							// the layer is no longer out of range, the moveTo
							// call below will turn on the layer.
							layer.inRange = inRange;
							
							if(!inRange) layer.display(inRange);
						}
						if (inRange && layer.visibility) {
							// edit by chzx 
							if(layer is GeoGlobe || layer is Tianditu || layer is WMTS){
								trace(Util.SendingState);
								if(!Util.oldLayer){
									Util.oldLayer = layer;
									layer.moveTo(bounds, zoomChanged, dragging);
								}
								else if(layer != Util.oldLayer && Util.SendingState){
									Util.LayerChanged = true;
									Util.oldLayer = layer;
									//lj--武汉影像
									Util.SendingState = false;
									layer.dispatchEvent(new LoaderEvent(LoaderEvent.LoaderComplete,2)); 	
									//lj--武汉影像
								}
								else {
									//                        		layer.moveTo(bounds, zoomChanged, dragging);
									layer.moveTo(bounds, true, dragging);
								}
							}
							else{
								layer.moveTo(bounds, zoomChanged, dragging);
							}
						}
					}                
				}
				
				
				if (zoomChanged) {
					//redraw popups
					//                for (var i = 0; i < this.popups.length; i++) {
					//                    this.popups[i].updatePosition();
					//                }
				}    
				
			}
			
			// even if nothing was done, we want to notify of this
			if (!dragging && !noEvent) {
				//            this.events.triggerEvent("moveend");
			}
			
			// Store the map dragging state for later use
			this.dragging = !!dragging; 
			
			if(this.snapShot) this.snapShot.visible = false;
		
			this.sprite.dispatchEvent(new MapEvent(MapEvent.MAP_ZOOM,false,false));
			
		}
		
		public function showSnapShot(dz:int):void
		{
			/**
			 * date: 	2008-07-03
			 * 
			 * zoom effect
			 * (1) move the snapshot 
			 * (2) resize it by scale 
			 * 
			 * results:
			 * (1) resize time controlled within 100-200-250ms, can appear closely to the loading data time
			 * larger than that, may feel loading data quicker than the resize
			 * slower than that, may feel resizing so quick that when it ends the data not loaded finished yet
			 * (2) need let no one feel the image before moving && the moving process
			 *  especially when zooming in
			 *  zooming out seems fine
			 */
			
			
			if(!this.snapShot)
			{
				this.snapShot=new Image();
				this.sprite.addChild(this.snapShot);
				this.snapShot.width=this.sprite.width;
				this.snapShot.height=this.sprite.height;	
				this.sprite.setChildIndex(this.snapShot,0);
			}
			
			this.snapShot.visible = true;
			var img:Image=this.snapShot;
			
			var s:Snapshot=new Snapshot();
			s.setLayer(this.sprite);// just raster, or the whole map (this.canvas)
			// if use this.raster as image, image location incorrect && error when no raster data
			if(!s.print(50))return;
			img.source=s.print(50);
			img.x = 0;
			img.y = 0;
			img.width = this.sprite.width;
			img.height = this.sprite.height;
			
			var scale:Number=Math.pow(2,dz);
			
			//			trace("img.width: " + img.width + " img.height: " + img.height);
			var dx:Number= -(img.width * scale - img.width) / 2;//this.canvas.width*(1-scale)/2;
			var dy:Number= -(img.height * scale - img.height) / 2;//this.canvas.height*(1-scale)/2;
			
			
			var m:Move=new Move(img);
			m.xFrom = img.x;
			m.yFrom = img.y;
			m.xTo = img.x + dx;
			m.yTo = img.x + dy;
			m.duration=5;
			m.end();
			m.play();
			
			var r:Resize=new Resize(img);
			r.widthFrom = img.width;
			r.widthTo = img.width * scale;
			r.heightFrom = img.height;
			r.heightTo = img.height * scale;
			r.duration = 100;
			r.end();
			r.play();
			
		}
		
		/** 
		 * Method: centerLayerContainer
		 * This function takes care to recenter the layerContainerDiv.
		 * 
		 * Parameters:
		 * lonlat - {<OpenLayers.LonLat>}
		 */
		private function centerLayerContainer(lonlat:LonLat):void {
			
			var originPx:Pixel = this.getViewPortPxFromLonLat(this.layerContainerOrigin);
			var newPx:Pixel = this.getViewPortPxFromLonLat(lonlat);
			
			if ((originPx != null) && (newPx != null)) {
				this.layerContainer.x = Math.round(originPx.x - newPx.x);
				this.layerContainer.y = Math.round(originPx.y - newPx.y);
			}
		}
		
		/**
		 * Method: isValidZoomLevel
		 * 
		 * Parameters:
		 * zoomLevel - {Integer}
		 * 
		 * Returns:
		 * {Boolean} Whether or not the zoom level passed in is non-null and 
		 *           within the min/max range of zoom levels.
		 */
		private function isValidZoomLevel(zoomLevel:int):Boolean {
			return ( (zoomLevel >= 0) && 
				(zoomLevel < this.getNumZoomLevels()) );
		}
		
		/**
		 * Method: isValidLonLat
		 * 
		 * Parameters:
		 * lonlat - {<OpenLayers.LonLat>}
		 * 
		 * Returns:
		 * {Boolean} Whether or not the lonlat passed in is non-null and within
		 *           the maxExtent bounds
		 */
		private function isValidLonLat(lonlat:LonLat):Boolean {
			var valid:Boolean = false;
			if (lonlat != null) {
				var maxExtent:Bounds = this.getMaxExtent();
				valid = maxExtent.containsLonLat(lonlat);        
			}
			return valid;
		}
		
		/********************************************************/
		/*                                                      */
		/*                 Layer Options                        */
		/*                                                      */
		/*    Accessor functions to Layer Options parameters    */
		/*                                                      */
		/********************************************************/
		
		/**
		 * APIMethod: getMaxResolution
		 * 
		 * Returns:
		 * {String} The Map's Maximum Resolution
		 */
		public function getMaxResolution():Number {
			var maxResolution:Number = -1;
			if (this.baseLayer != null) {
				maxResolution = this.baseLayer.maxResolution;
			}
			return maxResolution;
		}
		
		/**
		 * APIMethod: getMaxExtent
		 * 
		 * Returns:
		 * {<OpenLayers.Bounds>}
		 */
		public function getMaxExtent():Bounds {
			var maxExtent:Bounds = null;
			if (this.baseLayer != null) {
				maxExtent = this.baseLayer.maxExtent;
			}        
			return maxExtent;
		}
		
		/**
		 * APIMethod: getNumZoomLevels
		 * 
		 * Returns:
		 * {Integer} The total number of zoom levels that can be displayed by the 
		 *           current baseLayer.
		 */
		public function getNumZoomLevels():int {
			var numZoomLevels:int = -1;
			if (this.baseLayer != null) {
				numZoomLevels = this.baseLayer.numPyramidLevels;
			}
			return numZoomLevels;
		}
		
		/********************************************************/
		/*                                                      */
		/*                 Baselayer Functions                  */
		/*                                                      */
		/*    The following functions, all publicly exposed     */
		/*       in the API?, are all merely wrappers to the    */
		/*       the same calls on whatever layer is set as     */
		/*                the current base layer                */
		/*                                                      */
		/********************************************************/
		
		/**
		 * APIMethod: getExtent
		 * 
		 * Returns:
		 * {<OpenLayers.Bounds>} A Bounds object which represents the lon/lat 
		 *                       bounds of the current viewPort. 
		 *                       If no baselayer is set, returns null.
		 */
		public function getExtent():Bounds {
			var extent:Bounds = null;
			if (this.baseLayer != null) {
				extent = this.baseLayer.getExtent();
			}
			return extent;
		}
		
		/**
		 * APIMethod: getResolution
		 * 
		 * Returns:
		 * {Float} The current resolution of the map. 
		 *         If no baselayer is set, returns null.
		 */
		public function getResolution():Number {
			var resolution:Number = -1;
			if (this.baseLayer != null) {
				resolution = this.baseLayer.getResolution();
			}
			return resolution;
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
		 * {Integer} A suitable zoom level for the specified bounds.
		 *           If no baselayer is set, returns null.
		 */
		public function getZoomForExtent(bounds:Bounds, closest:Boolean = false):int {
			var zoom:int = -1;
			if (this.baseLayer != null) {
				zoom = this.baseLayer.getZoomForExtent(bounds, closest);
			}
			return zoom;
		}
		
		/**
		 * APIMethod: getResolutionForZoom
		 * 
		 * Parameter:
		 * zoom - {Float}
		 * 
		 * Returns:
		 * {Float} A suitable resolution for the specified zoom.  If no baselayer
		 *     is set, returns null.
		 */
		public function getResolutionForZoom(zoom:int):Number {
			var resolution:Number = -1;
			if(this.baseLayer) {
				resolution = this.baseLayer.getResolutionForZoom(zoom);
			}
			return resolution;
		}
		
		/**
		 * APIMethod: getZoomForResolution
		 * 
		 * Parameter:
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
		 * {Integer} A suitable zoom level for the specified resolution.
		 *           If no baselayer is set, returns null.
		 */
		public function getZoomForResolution(resolution:Number, closest:Boolean = false):int {
			var zoom:int = -1;
			if (this.baseLayer != null) {
				zoom = this.baseLayer.getZoomForResolution(resolution, closest);
			}
			return zoom;
		}
		
		/********************************************************/
		/*                                                      */
		/*                  Zooming Functions                   */
		/*                                                      */
		/*    The following functions, all publicly exposed     */
		/*       in the API, are all merely wrappers to the     */
		/*               the setCenter() function               */
		/*                                                      */
		/********************************************************/
		
		/** 
		 * APIMethod: zoomTo
		 * Zoom to a specific zoom level
		 * 
		 * Parameters:
		 * zoom - {Integer}
		 */
		public function zoomTo(zoom:int):void {
			
			//判断其是否在地图规定的缩放级别内 by WCZ 4-14
			if (this.isValidZoomLevel(zoom)) {
				// 判断图层有无改变，edit by chzx
				if(Util.arr_layers){
					
					var lastlayers:Array = Util.arr_layers[this.zoom] as Array;//表示上一次操作时的图层缩放级别 by WCZ 4-14
					var curlayers:Array = Util.arr_layers[zoom] as Array;//获取要缩放到的级别对应的图层 by WCZ 4-14				
					if(lastlayers && curlayers){
						if(lastlayers[0] == curlayers[0]){
							this.setCenter(null, zoom);
						}
							
						else{
							var targetLayerName:String = curlayers[0] as String;
							var targetLayer:Layer = this.getLayerByName(targetLayerName);
							
							var targetLonLat:LonLat = new LonLat((targetLayer.getExtent().left+targetLayer.getExtent().right)/2,(targetLayer.getExtent().bottom+targetLayer.getExtent().top)/2);
							targetLayer.visibility = true;
							this.setCenter(targetLonLat,zoom);
							
							modifyTree(Util.vir_xml,targetLayerName);
						}
					}
						//2011-3-19临时改动
					else{
						this.setCenter(null, zoom,false,true);
					}
				}
			}
			this.sprite.dispatchEvent(new MapEvent(MapEvent.MAP_ZOOM,null,null));
		}
		
		public function modifyTree(xml:XML,layername:String):void{
			var list:XMLList = xml.children();
			for(var i:int=0;i<list.length();i++){
				var tmpxml:XML = list[i] as XML;
				if(tmpxml.children().length() == 0){
					if(tmpxml.@label == layername){
						tmpxml.@state = "checked";
						tmpxml.@masked = "checked";
					}
				}
				else{
					modifyTree(tmpxml,layername);
				}
			}
		}
		
		/**
		 * APIMethod: zoomIn
		 * 
		 * Parameters:
		 * zoom - {int}
		 */
		public function zoomIn():void {
			this.zoomTo(this.getZoom() + Util.CELL);
		}
		
		/**
		 * APIMethod: zoomOut
		 * 
		 * Parameters:
		 * zoom - {int}
		 */
		public function zoomOut():void {
			this.zoomTo(this.getZoom() - Util.CELL);
		}
		
		/**
		 * APIMethod: zoomToExtent
		 * Zoom to the passed in bounds, recenter
		 * 
		 * Parameters:
		 * bounds - {<OpenLayers.Bounds>}
		 */
		public function zoomToExtent(bounds:Bounds):void {
			var center:LonLat = bounds.getCenterLonLat();
			if (this.baseLayer.wrapDateLine) {
				var maxExtent:Bounds = this.getMaxExtent();
				
				//fix straddling bounds (in the case of a bbox that straddles the 
				// dateline, it's left and right boundaries will appear backwards. 
				// we fix this by allowing a right value that is greater than the
				// max value at the dateline -- this allows us to pass a valid 
				// bounds to calculate zoom)
				//
				bounds = bounds.clone();
				while (bounds.right < bounds.left) {
					bounds.right += maxExtent.getWidth();
				}
				//if the bounds was straddling (see above), then the center point 
				// we got from it was wrong. So we take our new bounds and ask it
				// for the center. Because our new bounds is at least partially 
				// outside the bounds of maxExtent, the new calculated center 
				// might also be. We don't want to pass a bad center value to 
				// setCenter, so we have it wrap itself across the date line.
				//
				center = bounds.getCenterLonLat().wrapDateLine(maxExtent);
			}
			this.setCenter(center, this.getZoomForExtent(bounds));
		}
		
		/** 
		 * APIMethod: zoomToMaxExtent
		 * Zoom to the full extent and recenter.
		 */
		public function zoomToMaxExtent():void {
			this.zoomToExtent(this.getMaxExtent());
		}
		
		/** 
		 * APIMethod: zoomToScale
		 * Zoom to a specified scale 
		 * 
		 * Parameters:
		 * scale - {float}
		 */
		public function zoomToScale(scale:Number):void {
			//        var res = OpenLayers.Util.getResolutionFromScale(scale, 
			//                                                         this.baseLayer.units);
			//        var size:Size = this.getSize();
			//        var w_deg:Number = size.w * res;
			//        var h_deg:Number = size.h * res;
			//        var center:LonLat = this.getCenter();
			//
			//        var extent:Bounds = new Bounds(center.lon - w_deg / 2,
			//                                           center.lat - h_deg / 2,
			//                                           center.lon + w_deg / 2,
			//                                           center.lat + h_deg / 2);
			//        this.zoomToExtent(extent);
		}
		
		public function SetEvtObj():void
		{
			this.evtObj=new Sprite();
			this.evtObj.graphics.beginFill(0xbbb,0);
			this.evtObj.graphics.drawRect(0,0,this.size.w,this.size.h);
			this.evtObj.graphics.endFill();			
			this.sprite.addChild(this.evtObj);
//			this.evtObj.doubleClickEnabled=true;
//			this.evtObj.addEventListener(MouseEvent.DOUBLE_CLICK,this.EmptyFn,false,0,true);
		} 
		
		
		public function EmptyFn(e:Event):void
		{
			/*该函数是用于给this.evtObj绑定处理事件的，本身不做任何处理*/
			
		}
		
		public function EvtObjMoveAway():void
		{			
			if(this.evtObj)this.evtObj.x=-10000;			
		}
		public function EvtObjRecover():void
		{
		//	if(this.evtObj)this.evtObj.x=0;
		}   
		public function stopDrag():void{
			this.handler=new Drag(this,null);
			this.handler.Deactive();
		}
		public function drag():void
		{
			if(this.eHandler){
				this.eHandler.Deactive();
				this.eHandler.Destroy();
			}
			if(this.dHandler){
				this.dHandler.Deactive();
				this.dHandler.Destroy();
			}
			this.handler=new Drag(this,null);
			this.handler.Active();
		}
		
		public function doPtReq():void
		{
			if(this.evtObj.x<0)this.EvtObjRecover();
			
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			this.pHandler = new lkRequest(this,null);
			this.pHandler.Active();
		}
		public function setEvt():void{
			this.SetEvtObj();
			if(this.evtObj.x<0)this.EvtObjRecover();
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			//if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
		}
		
		public function DrawPt():void
		{
			this.SetEvtObj();
			if(this.evtObj.x<0)this.EvtObjRecover();
			
			//this.DeactiveAllControl();
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			this.dHandler=new DrawPoint(this,null);			
			this.dHandler.Active();
		}
		public function DrawLn():void
		{
			this.SetEvtObj();
			if(this.evtObj.x<0)this.EvtObjRecover();
			
			//this.DeactiveAllControl();
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}			
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			this.dHandler=new DrawLine(this,null);
			this.dHandler.Active();
		}

		public function StopDraw():void{
//			CursorManager.removeCursor(cursorID);
//			cursorID=-1;
			this.EvtObjMoveAway();
			if(this.dHandler){
				this.dHandler.Deactive();
				this.dHandler.Destroy();
			}
			drag();
		}
		public function EditVector():void
		{
			this.EvtObjMoveAway();
			
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			this.eHandler=new EditShape(this,{});
			this.eHandler.Active();
			//Util.SetContextMenu(["exit edit"],[ExitEdit],this.canvas);			
		}
		
		public function EditCtrPts():void{
			this.EvtObjMoveAway();
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			this.eHandler=new EditPoint(this,{});
			this.eHandler.Active();
		}
		
		public function Rotate():void{
			this.EvtObjMoveAway();
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			this.eHandler=new RotateVector(this,{});
			this.eHandler.Active();
		}
		
		public function Enlarge():void{
			this.EvtObjMoveAway();
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			this.eHandler=new EnlargeVector(this,{});
			this.eHandler.Active();
		}
		
		
		
		public function Narrow():void{
			this.EvtObjMoveAway();
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			this.eHandler=new NarrowVector(this,{});
			this.eHandler.Active();
		}
		
		public function StopEdit():void{
			this.EvtObjMoveAway();
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			Redraw();
		}
		
		// 当结束编辑后，将所有适量对象进行重绘，即 使所有适量对象的外观为编辑前的状态
		private function Redraw():void{
			var vectors:Sprite=this.layerContainer;			
			var lcount:int=vectors.numChildren;//矢量图层数			
			var slayer:Vector;//图层是Sprite
			var shape:GeoShape;
			
			for(var i:int=0;i<lcount;i++){
				slayer = vectors.getChildAt(i) as Vector;
				if(slayer) {
					if(!slayer.url){
						slayer.Redraw();
					}
				}
			}
			
		}		
		
		public function ExitEdit():void
		{
			this.sprite.contextMenu=null;
			
			this.eHandler.Deactive();			
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			
			this.handler=new Drag(this,null);
			this.handler.Active();
		}
		
		public function DrawLns(shape:GeoShape,arr:Array,symbol:Symbol):void
		{
			var g:Graphics=shape.graphics;
			
			g.clear();
			for(var i:int=0;i<arr.length;i++)
			{
				DLine(shape,arr[i] as Array,symbol);
			}
		}
		public function DrawRectangular():void{
		//	if(this.evtObj.x<0)this.EvtObjRecover();
			//this.DeactiveAllControl();
//			if(cursorID!=-1)
//				CursorManager.removeCursor(cursorID);
//			cursorID=CursorManager.setCursor(drawHand);
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}			
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			this.dHandler=new DrawRect(this,null);
			this.dHandler.Active();
		}
		public function clear(){
			this.dHandler.clear();
		}
		public function DrawPl():void
		{
//			if(cursorID!=-1)
//				CursorManager.removeCursor(cursorID);
//			cursorID=CursorManager.setCursor(drawHand);
			this.SetEvtObj();
			if(this.evtObj.x<0)this.EvtObjRecover();
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}			
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.eHandler){this.eHandler.Deactive();}
			
			//this.DeactiveAllControl();
			this.dHandler=new DrawPolygon(this,{"color":0xcc5599,"transLevel":0.6});
			this.dHandler.Active();
		}
		
		public function DLine(shape:GeoShape,arr:Array,symbol:Symbol):void
		{
			if(arr.length<2)return;
			var g:Graphics=shape.graphics;		
			
			symbol.DrawLine(shape,arr);
		}
		
		//和EditPanel中重复了
		public function DrawRings(shape:GeoShape,lineRings:Array,symbol:Symbol):void
		{
			var g:Graphics=shape.graphics;
			
			g.clear();
			
			for(var i:int=0;i<lineRings.length;i++)
			{
				DrawRing(shape,lineRings[i],symbol);
			}
		}
		
		public function DrawRing(shape:GeoShape,lineRing:Array,symbol:Symbol):void
		{
			if(lineRing.length<2)return;
			var g:Graphics=shape.graphics;
			
			for(var m:int=0;m<(shape.coords as Array).length;m++){
				var tmp:Array = shape.coords[m] as Array;
				for(var n:int=0;n<tmp.length;n=n+2){
					trace("!! "+tmp[n],tmp[n+1]);
				}
			} 
			symbol.DrawPolygon(shape,lineRing);
		}    
		
		/********************************************************/
		/*                                                      */
		/*             Translation Functions                    */
		/*                                                      */
		/*      The following functions translate between       */
		/*           LonLat, LayerPx, and ViewPortPx            */
		/*                                                      */
		/********************************************************/
		
		/**
		 * Method: getLonLatFromViewPortPx
		 * 
		 * Parameters:
		 * viewPortPx - {<OpenLayers.Pixel>}
		 * 
		 * Returns:
		 * {<OpenLayers.LonLat>} An OpenLayers.LonLat which is the passed-in view 
		 *                       port <OpenLayers.Pixel>, translated into lon/lat
		 *                       by the current base layer.
		 */
		private function getLonLatFromViewPortPx(viewPortPx:Pixel):LonLat {
			var lonlat:LonLat = null; 
			if (this.baseLayer != null) {
				lonlat = this.baseLayer.getLonLatFromViewPortPx(viewPortPx);
			}
			return lonlat;
		}
		
		/**
		 * APIMethod: getViewPortPxFromLonLat
		 * 
		 * Parameters:
		 * lonlat - {<OpenLayers.LonLat>}
		 * 
		 * Returns:
		 * {<OpenLayers.Pixel>} An OpenLayers.Pixel which is the passed-in 
		 *                      <OpenLayers.LonLat>, translated into view port 
		 *                      pixels by the current base layer.
		 */
		public function getViewPortPxFromLonLat(lonlat:LonLat):Pixel {
			var px:Pixel = null; 
			if (this.baseLayer != null) {
				px = this.baseLayer.getViewPortPxFromLonLat(lonlat);
			}
			return px;
		}
		
		
		//
		// CONVENIENCE TRANSLATION FUNCTIONS FOR API
		//
		
		/**
		 * APIMethod: getLonLatFromPixel
		 * 
		 * Parameters:
		 * px - {<OpenLayers.Pixel>}
		 *
		 * Returns:
		 * {<OpenLayers.LonLat>} An OpenLayers.LonLat corresponding to the given
		 *                       OpenLayers.Pixel, translated into lon/lat by the 
		 *                       current base layer
		 */
		public function getLonLatFromPixel(px:Pixel):LonLat {
			return this.getLonLatFromViewPortPx(px);
		}
		
		/**
		 * APIMethod: getPixelFromLonLat
		 * Returns a pixel location given a map location.  The map location is
		 *     translated to an integer pixel location (in viewport pixel
		 *     coordinates) by the current base layer.
		 * 
		 * Parameters:
		 * lonlat - {<OpenLayers.LonLat>} A map location.
		 * 
		 * Returns: 
		 * {<OpenLayers.Pixel>} An OpenLayers.Pixel corresponding to the 
		 *     <OpenLayers.LonLat> translated into view port pixels by the current
		 *     base layer.
		 */
		public function getPixelFromLonLat(lonlat:LonLat):Pixel {
			var px:Pixel = this.getViewPortPxFromLonLat(lonlat);
			px.x = Math.round(px.x);
			px.y = Math.round(px.y);
			return px;
		}
		
		
		
		//
		// TRANSLATION: ViewPortPx <-> LayerPx
		//
		
		/**
		 * APIMethod: getViewPortPxFromLayerPx
		 * 
		 * Parameters:
		 * layerPx - {<OpenLayers.Pixel>}
		 * 
		 * Returns:
		 * {<OpenLayers.Pixel>} Layer Pixel translated into ViewPort Pixel 
		 *                      coordinates
		 */
		public function getViewPortPxFromLayerPx(layerPx:Pixel):Pixel {
			var viewPortPx:Pixel = null;
			if (layerPx != null) {
				var dX:int = this.layerContainer.x;
				var dY:int = this.layerContainer.y;
				viewPortPx = layerPx.add(dX, dY);            
			}
			return viewPortPx;
		}
		
		/**
		 * APIMethod: getLayerPxFromViewPortPx
		 * 
		 * Parameters:
		 * viewPortPx - {<OpenLayers.Pixel>}
		 * 
		 * Returns:
		 * {<OpenLayers.Pixel>} ViewPort Pixel translated into Layer Pixel 
		 *                      coordinates
		 */
		public function getLayerPxFromViewPortPx(viewPortPx:Pixel):Pixel {
			var layerPx:Pixel = null;
			if (viewPortPx != null) {
				var dX:int = -this.layerContainer.x;
				var dY:int = -this.layerContainer.y;
				layerPx = viewPortPx.add(dX, dY);
			}
			return layerPx;
		}
		
		//
		// TRANSLATION: LonLat <-> LayerPx
		//
		
		/**
		 * Method: getLonLatFromLayerPx
		 * 
		 * Parameters:
		 * px - {<OpenLayers.Pixel>}
		 *
		 * Returns:
		 * {<OpenLayers.LonLat>}
		 */
		public function getLonLatFromLayerPx(px:Pixel):LonLat {
			//adjust for displacement of layerContainerDiv
			px = this.getViewPortPxFromLayerPx(px);
			return this.getLonLatFromViewPortPx(px);         
		}
		
		/**
		 * APIMethod: getLayerPxFromLonLat
		 * 
		 * Parameters:
		 * lonlat - {<OpenLayers.LonLat>} lonlat
		 *
		 * Returns:
		 * {<OpenLayers.Pixel>} An OpenLayers.Pixel which is the passed-in 
		 *                      <OpenLayers.LonLat>, translated into layer pixels 
		 *                      by the current base layer
		 */
		public function getLayerPxFromLonLat(lonlat:LonLat):Pixel {
			//adjust for displacement of layerContainerDiv
			var px:Pixel = this.getPixelFromLonLat(lonlat);
			return this.getLayerPxFromViewPortPx(px);         
		}     
		
		//点位搜索
		public function doPtSearch(layername:String,featureName:String):void
		{
			var searchPt:SearchPoint = new SearchPoint(this,layername,featureName);
			searchPt.Active();
		}
		
		
	}
}

