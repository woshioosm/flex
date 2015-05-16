// ActionScript file
package org.liesmars.flashwebclient.BaseTypes {
	public class LonLat {

	    /** 
	     * APIProperty: lon
	     * {Float} The x-axis coodinate in map units
	     */
	    public var lon:Number = 0.0;
	    
	    /** 
	     * APIProperty: lat
	     * {Float} The y-axis coordinate in map units
	     */
	    public var lat:Number = 0.0;
	
	    /**
	     * Constructor: OpenLayers.LonLat
	     * Create a new map location.
	     *
	     * Parameters:
	     * lon - {Number} The x-axis coordinate in map units.  If your map is in
	     *     a geographic projection, this will be the Longitude.  Otherwise,
	     *     it will be the x coordinate of the map location in your map units.
	     * lat - {Number} The y-axis coordinate in map units.  If your map is in
	     *     a geographic projection, this will be the Latitude.  Otherwise,
	     *     it will be the y coordinate of the map location in your map units.
	     */
	    public function LonLat(lon:Number, lat:Number):void {
	        this.lon = lon;
	        this.lat = lat;
	    }
	    
	    /**
	     * Method: toString
	     * Return a readable string version of the lonlat
	     *
	     * Returns:
	     * {String} String representation of OpenLayers.LonLat object. 
	     *           (ex. <i>"lon=5,lat=42"</i>)
	     */
	    public function toString():String  {
	        return ("lon=" + this.lon + ",lat=" + this.lat);
	    }
	
	    /** 
	     * APIMethod: toShortString
	     * 
	     * Returns:
	     * {String} Shortened String representation of OpenLayers.LonLat object. 
	     *         (ex. <i>"5, 42"</i>)
	     */
	    public function toShortString():String {
	        return (this.lon + ", " + this.lat);
	    }
	
	    /** 
	     * APIMethod: clone
	     * 
	     * Returns:
	     * {<OpenLayers.LonLat>} New OpenLayers.LonLat object with the same lon 
	     *                       and lat values
	     */
	    public function clone():LonLat {
	        return new LonLat(this.lon, this.lat);
	    }
	
	    /** 
	     * APIMethod: add
	     * 
	     * Parameters:
	     * lon - {Float}
	     * lat - {Float}
	     * 
	     * Returns:
	     * {<OpenLayers.LonLat>} A new OpenLayers.LonLat object with the lon and 
	     *                       lat passed-in added to this's. 
	     */
	    public function add(lon:Number, lat:Number):LonLat {
	        if ( (false) || (false) ) {
	            trace("lonlatAddError");
	            return null;
	        }
	        return new LonLat(this.lon + lon, this.lat + lat);
	    }
	
	    /** 
	     * APIMethod: equals
	     * 
	     * Parameters:
	     * ll - {<OpenLayers.LonLat>}
	     * 
	     * Returns:
	     * {Boolean} Boolean value indicating whether the passed-in 
	     *           <OpenLayers.LonLat> object has the same lon and lat 
	     *           components as this.
	     *           Note: if ll passed in is null, returns false
	     */
	    public function equals(ll:LonLat):Boolean{
	        var equals:Boolean = false;
	        if (ll != null) {
	            equals = ((this.lon == ll.lon && this.lat == ll.lat) ||
	                      (isNaN(this.lon) && isNaN(this.lat) && isNaN(ll.lon) && isNaN(ll.lat)));
	        }
	        return equals;
	    }
	    
	    /**
	     *
	     * APIMethod: equals
	     * Determine where this size is equal to another
	     *
	     * Parameters:
	     * sz - {<OpenLayers.Size>}
	     *
	     * Returns: 
	     * {Boolean} The passed in size has the same h and w properties as this one.
	     * Note that if sz passed in is null, returns false.
	     *
	     */
	    public function isNaN(sz:Number):Boolean {
	        var equals:Boolean = false;
	        if (false) {//sz != null) {
	            equals = (sz == NaN);
	        }
	        return equals;
	    }	
	
//	    /**
//	     * APIMethod: transform
//	     * Transform the LonLat object from source to dest. 
//	     *
//	     * Parameters: 
//	     * source - {<OpenLayers.Projection>} Source projection. 
//	     * dest   - {<OpenLayers.Projection>} Destination projection. 
//	     *
//	     * Returns:
//	     * {<OpenLayers.LonLat>} Itself, for use in chaining operations.
//	     */
//	    transform: function(source, dest) {
//	        var point = OpenLayers.Projection.transform(
//	            {'x': this.lon, 'y': this.lat}, source, dest);
//	        this.lon = point.x;
//	        this.lat = point.y;
//	        return this;
//	    },
	    
	    /**
	     * APIMethod: wrapDateLine
	     * 
	     * Parameters:
	     * maxExtent - {<OpenLayers.Bounds>}
	     * 
	     * Returns:
	     * {<OpenLayers.LonLat>} A copy of this lonlat, but wrapped around the 
	     *                       "dateline" (as specified by the borders of 
	     *                       maxExtent)
	     */
	    public function wrapDateLine(maxExtent:Bounds):LonLat {    
	
	        var newLonLat:LonLat = this.clone();
	    
	        if (maxExtent) {
	            //shift right?
	            while (newLonLat.lon < maxExtent.left) {
	                newLonLat.lon +=  maxExtent.getWidth();
	            }    
	           
	            //shift left?
	            while (newLonLat.lon > maxExtent.right) {
	                newLonLat.lon -= maxExtent.getWidth();
	            }    
	        }
	                
	        return newLonLat;
	    }

//		/** 
//		 * Function: fromString
//		 * Alternative constructor that builds a new <OpenLayers.LonLat> from a 
//		 *     parameter string
//		 * 
//		 * Parameters:
//		 * str - {String} Comma-separated Lon,Lat coordinate string. 
//		 *                 (ex. <i>"5,40"</i>)
//		 * 
//		 * Returns:
//		 * {<OpenLayers.LonLat>} New <OpenLayers.LonLat> object built from the 
//		 *                       passed-in String.
//		 */
//		OpenLayers.LonLat.fromString = function(str) {
//		    var pair = str.split(",");
//		    return new OpenLayers.LonLat(parseFloat(pair[0]), 
//		                                 parseFloat(pair[1]));
//		};
	
		
		
		
	}
}