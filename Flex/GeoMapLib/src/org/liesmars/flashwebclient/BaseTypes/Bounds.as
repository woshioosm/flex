// ActionScript file
package org.liesmars.flashwebclient.BaseTypes {
	public class Bounds {
	   /**
	     * Property: left
	     * {Number} Minimum horizontal coordinate.
	     */
	    public var left:Number;
	
	    /**
	     * Property: bottom
	     * {Number} Minimum vertical coordinate.
	     */
	    public var bottom:Number;
	
	    /**
	     * Property: right
	     * {Number} Maximum horizontal coordinate.
	     */
	    public var right:Number;
	
	    /**
	     * Property: top
	     * {Number} Maximum vertical coordinate.
	     */
	    public var top:Number;    
	
	    /**
	     * Constructor: OpenLayers.Bounds
	     * Construct a new bounds object.
	     *
	     * Parameters:
	     * left - {Number} The left bounds of the box.  Note that for width
	     *        calculations, this is assumed to be less than the right value.
	     * bottom - {Number} The bottom bounds of the box.  Note that for height
	     *          calculations, this is assumed to be more than the top value.
	     * right - {Number} The right bounds.
	     * top - {Number} The top bounds.
	     */
	    public function Bounds(left:Number, bottom:Number, right:Number, top:Number) {
//	        if (left != null) {
	            this.left = left;
//	        }
//	        if (bottom != null) {
	            this.bottom = bottom;
//	        }
//	        if (right != null) {
	            this.right = right;
//	        }
//	        if (top != null) {
	            this.top = top;
//	        }
	    }
	
	    /**
	     * Method: clone
	     * Create a cloned instance of this bounds.
	     *
	     * Returns:
	     * {<OpenLayers.Bounds>} A fresh copy of the bounds
	     */
	    public function clone():Bounds {
	        return new Bounds(this.left, this.bottom, 
	                                     this.right, this.top);
	    }
	
	    /**
	     * Method: equals
	     * Test a two bounds for equivalence.
	     *
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>}
	     *
	     * Returns:
	     * {Boolean} The passed-in bounds object has the same left,
	     *           right, top, bottom components as this.  Note that if bounds 
	     *           passed in is null, returns false.
	     */
	    public function equals(bounds:Bounds):Boolean {
	        var equals:Boolean = false;
	        if (bounds != null) {
	            equals = ((this.left == bounds.left) && 
	                      (this.right == bounds.right) &&
	                      (this.top == bounds.top) && 
	                      (this.bottom == bounds.bottom));
	        }
	        return equals;
	    }
	
	    /** 
	     * APIMethod: toString
	     * 
	     * Returns:
	     * {String} String representation of bounds object. 
	     *          (ex.<i>"left-bottom=(5,42) right-top=(10,45)"</i>)
	     */
	    public function toString():String {
	        return ( "left-bottom=(" + this.left + "," + this.bottom + ")"
	                 + " right-top=(" + this.right + "," + this.top + ")" );
	    }
	
	    /**
	     * APIMethod: toArray
	     *
	     * Returns:
	     * {Array} array of left, bottom, right, top
	     */
	    public function toArray():Array {
	        return [this.left, this.bottom, this.right, this.top];
	    } 
	
	    /** 
	     * APIMethod: toBBOX
	     * 
	     * Parameters:
	     * decimal - {Integer} How many significant digits in the bbox coords?
	     *                     Default is 6
	     * 
	     * Returns:
	     * {String} Simple String representation of bounds object.
	     *          (ex. <i>"5,42,10,45"</i>)
	     */
	    public function toBBOX(decimal:int = 6):String {
	        if (!decimal) {
	            decimal = 6; 
	        }
	        var mult:Number = Math.pow(10, decimal);
	        var bbox:String = Math.round(this.left * mult) / mult + "," + 
	                   Math.round(this.bottom * mult) / mult + "," + 
	                   Math.round(this.right * mult) / mult + "," + 
	                   Math.round(this.top * mult) / mult;
	
	        return bbox;
	    }
	    
//	    /**
//	     * APIMethod: toGeometry
//	     * Create a new polygon geometry based on this bounds.
//	     *
//	     * Returns:
//	     * {<OpenLayers.Geometry.Polygon>} A new polygon with the coordinates
//	     *     of this bounds.
//	     */
//	    toGeometry: function() {
//	        return new OpenLayers.Geometry.Polygon([
//	            new OpenLayers.Geometry.LinearRing([
//	                new OpenLayers.Geometry.Point(this.left, this.bottom),
//	                new OpenLayers.Geometry.Point(this.right, this.bottom),
//	                new OpenLayers.Geometry.Point(this.right, this.top),
//	                new OpenLayers.Geometry.Point(this.left, this.top)
//	            ])
//	        ]);
//	    },
	    
	    /**
	     * APIMethod: getWidth
	     * 
	     * Returns:
	     * {Float} The width of the bounds
	     */
	    public function getWidth():Number {
	        return (this.right - this.left);
	    }
	
	    /**
	     * APIMethod: getHeight
	     * 
	     * Returns:
	     * {Float} The height of the bounds (top minus bottom).
	     */
	    public function getHeight():Number {
	        return (this.top - this.bottom);
	    }
	
	    /**
	     * APIMethod: getSize
	     * 
	     * Returns:
	     * {<OpenLayers.Size>} The size of the box.
	     */
	    public function getSize():Size {
	        return new Size(this.getWidth(), this.getHeight());
	    }
	
	    /**
	     * APIMethod: getCenterPixel
	     * 
	     * Returns:
	     * {<OpenLayers.Pixel>} The center of the bounds in pixel space.
	     */
	    public function getCenterPixel():Pixel {
	        return new Pixel( (this.left + this.right) / 2,
	                                     (this.bottom + this.top) / 2);
	    }
	
	    /**
	     * APIMethod: getCenterLonLat
	     * 
	     * Returns:
	     * {<OpenLayers.LonLat>} The center of the bounds in map space.
	     */
	    public function getCenterLonLat():LonLat {
	        return new LonLat( (this.left + this.right) / 2,
	                                      (this.bottom + this.top) / 2);
	    }
	
	    /**
	     * APIMethod: add
	     * 
	     * Parameters:
	     * x - {Float}
	     * y - {Float}
	     * 
	     * Returns:
	     * {<OpenLayers.Bounds>} A new bounds whose coordinates are the same as
	     *     this, but shifted by the passed-in x and y values.
	     */
	    public function add(x:Number, y:Number):Bounds {
	        if (false) {//( (x == null) || (y == null) ) {
	            trace("boundsAddError");
	            return null;
	        }
	        return new Bounds((this.left + x), (this.bottom + y),
	                                     (this.right + x), (this.top + y));
	    }
	    
//	    /**
//	     * APIMethod: extend
//	     * Extend the bounds to include the point, lonlat, or bounds specified.
//	     *     Note, this function assumes that left < right and bottom < top.
//	     * 
//	     * Parameters: 
//	     * object - {Object} Can be LonLat, Point, or Bounds
//	     */
//	    public function extend(object:Object) {
//	        var bounds = null;
//	        if (object) {
//	            switch(object.CLASS_NAME) {
//	                case "OpenLayers.LonLat":    
//	                    bounds = new OpenLayers.Bounds(object.lon, object.lat,
//	                                                    object.lon, object.lat);
//	                    break;
//	                case "OpenLayers.Geometry.Point":
//	                    bounds = new OpenLayers.Bounds(object.x, object.y,
//	                                                    object.x, object.y);
//	                    break;
//	                    
//	                case "OpenLayers.Bounds":    
//	                    bounds = object;
//	                    break;
//	            }
//	    
//	            if (bounds) {
//	                if ( (this.left == null) || (bounds.left < this.left)) {
//	                    this.left = bounds.left;
//	                }
//	                if ( (this.bottom == null) || (bounds.bottom < this.bottom) ) {
//	                    this.bottom = bounds.bottom;
//	                } 
//	                if ( (this.right == null) || (bounds.right > this.right) ) {
//	                    this.right = bounds.right;
//	                }
//	                if ( (this.top == null) || (bounds.top > this.top) ) { 
//	                    this.top = bounds.top;
//	                }
//	            }
//	        }
//		}  	
//	}	 
	
	    /**
	     * APIMethod: containsLonLat
	     * 
	     * Parameters:
	     * ll - {<OpenLayers.LonLat>}
	     * inclusive - {Boolean} Whether or not to include the border.
	     *     Default is true.
	     *
	     * Returns:
	     * {Boolean} The passed-in lonlat is within this bounds.
	     */
	    public function containsLonLat(ll:LonLat, inclusive:Boolean = true):Boolean {
	        return this.contains(ll.lon, ll.lat, inclusive);
	    }
	
	    /**
	     * APIMethod: containsPixel
	     * 
	     * Parameters:
	     * px - {<OpenLayers.Pixel>}
	     * inclusive - {Boolean} Whether or not to include the border. Default is
	     *     true.
	     *
	     * Returns:
	     * {Boolean} The passed-in pixel is within this bounds.
	     */
	    public function containsPixel(px:Pixel, inclusive:Boolean):Boolean {
	        return this.contains(px.x, px.y, inclusive);
	    }
	    
	    /**
	     * APIMethod: contains
	     * 
	     * Parameters:
	     * x - {Float}
	     * y - {Float}
	     * inclusive - {Boolean} Whether or not to include the border. Default is
	     *     true.
	     *
	     * Returns:
	     * {Boolean} Whether or not the passed-in coordinates are within this
	     *     bounds.
	     */
	    public function contains(x:Number, y:Number, inclusive:Boolean = true):Boolean {
	    
	        //set default
//	        if (inclusive == null) {
//	            inclusive = true;
//	        }
	        
	        var contains:Boolean = false;
	        if (inclusive) {
	            contains = ((x >= this.left) && (x <= this.right) && 
	                        (y >= this.bottom) && (y <= this.top));
	        } else {
	            contains = ((x > this.left) && (x < this.right) && 
	                        (y > this.bottom) && (y < this.top));
	        }              
	        return contains;
	    }
	
	    /**
	     * APIMethod: intersectsBounds
	     * 
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>}
	     * inclusive - {Boolean} Whether or not to include the border.  Default
	     *     is true.
	     *
	     * Returns:
	     * {Boolean} The passed-in OpenLayers.Bounds object intersects this bounds.
	     *     Simple math just check if either contains the other, allowing for
	     *     partial.
	     */
	    public function intersectsBounds(bounds:Bounds, inclusive:Boolean = true):Boolean {
	
//	        if (inclusive == null) {
//	            inclusive = true;
//	        }
	        var inBottom:Boolean = (bounds.bottom == this.bottom && bounds.top == this.top) ?
	                    true : (((bounds.bottom > this.bottom) && (bounds.bottom < this.top)) || 
	                           ((this.bottom > bounds.bottom) && (this.bottom < bounds.top))); 
	        var inTop:Boolean = (bounds.bottom == this.bottom && bounds.top == this.top) ?
	                    true : (((bounds.top > this.bottom) && (bounds.top < this.top)) ||
	                           ((this.top > bounds.bottom) && (this.top < bounds.top))); 
	        var inRight:Boolean = (bounds.right == this.right && bounds.left == this.left) ?
	                    true : (((bounds.right > this.left) && (bounds.right < this.right)) ||
	                           ((this.right > bounds.left) && (this.right < bounds.right))); 
	        var inLeft:Boolean = (bounds.right == this.right && bounds.left == this.left) ?
	                    true : (((bounds.left > this.left) && (bounds.left < this.right)) || 
	                           ((this.left > bounds.left) && (this.left < bounds.right))); 
	
	        return (this.containsBounds(bounds, true, inclusive) ||
	                bounds.containsBounds(this, true, inclusive) ||
	                ((inTop || inBottom ) && (inLeft || inRight )));
	    }
	    
	    /**
	     * APIMethod: containsBounds
	     * 
	     * bounds - {<OpenLayers.Bounds>}
	     * partial - {Boolean} If true, only part of passed-in bounds needs be
	     *     within this bounds.  If false, the entire passed-in bounds must be
	     *     within. Default is false
	     * inclusive - {Boolean} Whether or not to include the border. Default is
	     *     true.
	     *
	     * Returns:
	     * {Boolean} The passed-in bounds object is contained within this bounds. 
	     */
	    public function containsBounds(bounds:Bounds, partial:Boolean = false, inclusive:Boolean = true):Boolean {
	
//	        //set defaults
//	        if (partial == null) {
//	            partial = false;
//	        }
//	        if (inclusive == null) {
//	            inclusive = true;
//	        }
	
	        var inLeft:Boolean;
	        var inTop:Boolean;
	        var inRight:Boolean;
	        var inBottom:Boolean;
	        
	        if (inclusive) {
	            inLeft = (bounds.left >= this.left) && (bounds.left <= this.right);
	            inTop = (bounds.top >= this.bottom) && (bounds.top <= this.top);
	            inRight= (bounds.right >= this.left) && (bounds.right <= this.right);
	            inBottom = (bounds.bottom >= this.bottom) && (bounds.bottom <= this.top);
	        } else {
	            inLeft = (bounds.left > this.left) && (bounds.left < this.right);
	            inTop = (bounds.top > this.bottom) && (bounds.top < this.top);
	            inRight= (bounds.right > this.left) && (bounds.right < this.right);
	            inBottom = (bounds.bottom > this.bottom) && (bounds.bottom < this.top);
	        }
	        
	        return (partial) ? (inTop || inBottom ) && (inLeft || inRight ) 
	                         : (inTop && inLeft && inBottom && inRight);
	    }
	
	    /** 
	     * APIMethod: determineQuadrant
	     * 
	     * Parameters:
	     * lonlat - {<OpenLayers.LonLat>}
	     * 
	     * Returns:
	     * {String} The quadrant ("br" "tr" "tl" "bl") of the bounds in which the
	     *     coordinate lies.
	     */
	    public function determineQuadrant(lonlat:LonLat):String {
	    
	        var quadrant:String = "";
	        var center:LonLat = this.getCenterLonLat();
	        
	        quadrant += (lonlat.lat < center.lat) ? "b" : "t";
	        quadrant += (lonlat.lon < center.lon) ? "l" : "r";
	    
	        return quadrant; 
	    }
	    
//	    /**
//	     * APIMethod: transform
//	     * Transform the Bounds object from source to dest. 
//	     *
//	     * Parameters: 
//	     * source - {<OpenLayers.Projection>} Source projection. 
//	     * dest   - {<OpenLayers.Projection>} Destination projection. 
//	     *
//	     * Returns:
//	     * {<OpenLayers.Bounds>} Itself, for use in chaining operations.
//	     */
//	    transform: function(source, dest) {
//	        var ll = OpenLayers.Projection.transform(
//	            {'x': this.left, 'y': this.bottom}, source, dest);
//	        var lr = OpenLayers.Projection.transform(
//	            {'x': this.right, 'y': this.bottom}, source, dest);
//	        var ul = OpenLayers.Projection.transform(
//	            {'x': this.left, 'y': this.top}, source, dest);
//	        var ur = OpenLayers.Projection.transform(
//	            {'x': this.right, 'y': this.top}, source, dest);
//	        this.left   = Math.min(ll.x, ul.x);
//	        this.bottom = Math.min(ll.y, lr.y);
//	        this.right  = Math.max(lr.x, ur.x);
//	        this.top    = Math.max(ul.y, ur.y);
//	        return this;
//	    },
	
	    /**
	     * APIMethod: wrapDateLine
	     *  
	     * Parameters:
	     * maxExtent - {<OpenLayers.Bounds>}
	     * options - {Object} Some possible options are:
	     *                    leftTolerance - {float} Allow for a margin of error 
	     *                                            with the 'left' value of this 
	     *                                            bound.
	     *                                            Default is 0.
	     *                    rightTolerance - {float} Allow for a margin of error 
	     *                                             with the 'right' value of 
	     *                                             this bound.
	     *                                             Default is 0.
	     * 
	     * Returns:
	     * {<OpenLayers.Bounds>} A copy of this bounds, but wrapped around the 
	     *                       "dateline" (as specified by the borders of 
	     *                       maxExtent). Note that this function only returns 
	     *                       a different bounds value if this bounds is 
	     *                       *entirely* outside of the maxExtent. If this 
	     *                       bounds straddles the dateline (is part in/part 
	     *                       out of maxExtent), the returned bounds will be 
	     *                       merely a copy of this one.
	     */
	    public function wrapDateLine(maxExtent:Bounds, options:Object):Bounds {    
	        options = options || {};
	        
	        var leftTolerance:Number = options.leftTolerance || 0;
	        var rightTolerance:Number = options.rightTolerance || 0;
	
	        var newBounds:Bounds = this.clone();
	    
	        if (maxExtent) {
	
	           //shift right?
	           while ( newBounds.left < maxExtent.left && 
	                   (newBounds.right - rightTolerance) <= maxExtent.left ) { 
	                newBounds = newBounds.add(maxExtent.getWidth(), 0);
	           }
	
	           //shift left?
	           while ( (newBounds.left + leftTolerance) >= maxExtent.right && 
	                   newBounds.right > maxExtent.right ) { 
	                newBounds = newBounds.add(-maxExtent.getWidth(), 0);
	           }
	        }
	                
	        return newBounds;
	    }
	
//		/** 
//		 * APIFunction: fromString
//		 * Alternative constructor that builds a new OpenLayers.Bounds from a 
//		 *     parameter string
//		 * 
//		 * Parameters: 
//		 * str - {String}Comma-separated bounds string. (ex. <i>"5,42,10,45"</i>)
//		 * 
//		 * Returns:
//		 * {<OpenLayers.Bounds>} New bounds object built from the 
//		 *                       passed-in String.
//		 */
//		OpenLayers.Bounds.fromString = function(str) {
//		    var bounds = str.split(",");
//		    return OpenLayers.Bounds.fromArray(bounds);
//		};
//		
//		/** 
//		 * APIFunction: fromArray
//		 * Alternative constructor that builds a new OpenLayers.Bounds
//		 *     from an array
//		 * 
//		 * Parameters:
//		 * bbox - {Array(Float)} Array of bounds values (ex. <i>[5,42,10,45]</i>)
//		 *
//		 * Returns:
//		 * {<OpenLayers.Bounds>} New bounds object built from the passed-in Array.
//		 */
//		OpenLayers.Bounds.fromArray = function(bbox) {
//		    return new OpenLayers.Bounds(parseFloat(bbox[0]),
//		                                 parseFloat(bbox[1]),
//		                                 parseFloat(bbox[2]),
//		                                 parseFloat(bbox[3]));
//		};
//		
//		/** 
//		 * APIFunction: fromSize
//		 * Alternative constructor that builds a new OpenLayers.Bounds
//		 *     from a size
//		 * 
//		 * Parameters:
//		 * size - {<OpenLayers.Size>} 
//		 *
//		 * Returns:
//		 * {<OpenLayers.Bounds>} New bounds object built from the passed-in size.
//		 */
//		OpenLayers.Bounds.fromSize = function(size) {
//		    return new OpenLayers.Bounds(0,
//		                                 size.h,
//		                                 size.w,
//		                                 0);
//		};
//		
//		/**
//		 * Function: oppositeQuadrant
//		 * Get the opposite quadrant for a given quadrant string.
//		 *
//		 * Parameters:
//		 * quadrant - {String} two character quadrant shortstring
//		 *
//		 * Returns:
//		 * {String} The opposing quadrant ("br" "tr" "tl" "bl"). For Example, if 
//		 *          you pass in "bl" it returns "tr", if you pass in "br" it 
//		 *          returns "tl", etc.
//		 */
//		OpenLayers.Bounds.oppositeQuadrant = function(quadrant) {
//		    var opp = "";
//		    
//		    opp += (quadrant.charAt(0) == 't') ? 'b' : 't';
//		    opp += (quadrant.charAt(1) == 'l') ? 'r' : 'l';
//		    
//		    return opp;
//		};

		
	}
}