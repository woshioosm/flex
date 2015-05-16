// ActionScript file
package org.liesmars.flashwebclient.BaseTypes {
	
	
	public class Pixel {
	    /**
	     * APIProperty: x
	     * {Number} The x coordinate
	     */
	    public var x:Number = 0.0;
	
	    /**
	     * APIProperty: y
	     * {Number} The y coordinate
	     */
	    public var y:Number = 0.0;
	    
	    /**
	     * Constructor: OpenLayers.Pixel
	     * Create a new OpenLayers.Pixel instance
	     *
	     * Parameters:
	     * x - {Number} The x coordinate
	     * y - {Number} The y coordinate
	     *
	     * Returns:
	     * An instance of OpenLayers.Pixel
	     */
	    public function Pixel(x:Number, y:Number) {
	        this.x = x;
	        this.y = y;
	    }
	    
	    /**
	     * Method: toString
	     * Cast this object into a string
	     *
	     * Returns:
	     * {String} The string representation of Pixel. ex: "x=200.4,y=242.2"
	     */
	    public function toString():String {
	        return ("x=" + this.x + ",y=" + this.y);
	    }
	
	    /**
	     * APIMethod: clone
	     * Return a clone of this pixel object
	     *
	     * Returns:
	     * {<OpenLayers.Pixel>} A clone pixel
	     */
	    public function clone():Pixel {
	        return new Pixel(this.x, this.y); 
	    }
	    
	    /**
	     * APIMethod: equals
	     * Determine whether one pixel is equivalent to another
	     *
	     * Parameters:
	     * px - {<OpenLayers.Pixel>}
	     *
	     * Returns:
	     * {Boolean} The point passed in as parameter is equal to this. Note that
	     * if px passed in is null, returns false.
	     */
	    public function equals(px:Pixel):Boolean {
	        var equals:Boolean = false;
	        if (px != null) {
	            equals = ((this.x == px.x && this.y == px.y) ||
	                      (isNaN(this.x) && isNaN(this.y) && isNaN(px.x) && isNaN(px.y)));
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
	        if (true) {//sz != null) {
	            equals = (sz == NaN);
	        }
	        return equals;
	    }
	
	    /**
	     * APIMethod: add
	     *
	     * Parameters:
	     * x - {Integer}
	     * y - {Integer}
	     *
	     * Returns:
	     * {<OpenLayers.Pixel>} A new Pixel with this pixel's x&y augmented by the 
	     * values passed in.
	     */
	    public function add(x:int, y:int):Pixel {
	        if ( false ) {
	            trace("pixelAddError");
	            return null;
	        }
	        return new Pixel(this.x + x, this.y + y);
	    }
	
	    /**
	    * APIMethod: offset
	    * 
	    * Parameters
	    * px - {<OpenLayers.Pixel>}
	    * 
	    * Returns:
	    * {<OpenLayers.Pixel>} A new Pixel with this pixel's x&y augmented by the 
	    *                      x&y values of the pixel passed in.
	    */
	    public function offset(px:Pixel):Pixel {
	        var newPx:Pixel = this.clone();
	        if (px) {
	            newPx = this.add(px.x, px.y);
	        }
	        return newPx;
	    }

		
	}
}