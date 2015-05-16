// ActionScript file
package org.liesmars.flashwebclient.BaseTypes {
	public class Size {
		
	    /**
	     * APIProperty: w
	     * {Number} width
	     */
	    public var w:Number = 0.0;
	    
	    /**
	     * APIProperty: h
	     * {Number} height
	     */
	    public var h:Number = 0.0;
	
	
	    /**
	     * Constructor: OpenLayers.Size
	     * Create an instance of OpenLayers.Size
	     *
	     * Parameters:
	     * w - {Number} width
	     * h - {Number} height
	     */
	    public function Size(w:Number, h:Number)  {
	        this.w = w;
	        this.h = h;
	    }
	
	    /**
	     * Method: toString
	     * Return the string representation of a size object
	     *
	     * Returns:
	     * {String} The string representation of OpenLayers.Size object. 
	     * (ex. <i>"w=55,h=66"</i>)
	     */
	    public function toString():String {
	        return ("w=" + this.w + ",h=" + this.h);
	    }
	
	    /**
	     * APIMethod: clone
	     * Create a clone of this size object
	     *
	     * Returns:
	     * {<OpenLayers.Size>} A new OpenLayers.Size object with the same w and h
	     * values
	     */
	    public function clone():Size {
	        return new Size(this.w, this.h);
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
	    public function equals(sz:Size):Boolean {
	        var equals:Boolean = false;
	        if (sz != null) {
	            equals = ((this.w == sz.w && this.h == sz.h) ||
	                      (isNaN(this.w) && isNaN(this.h) && isNaN(sz.w) && isNaN(sz.h)));
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
	    
	    
	}
}