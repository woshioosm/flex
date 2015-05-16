/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - AdvancedDoubleMinMaxDescribe.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_AdvancedDoubleMinMaxDescribe extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.frame.AdvancedDoubleMinMaxDescribe") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.frame.AdvancedDoubleMinMaxDescribe", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.frame.AdvancedDoubleMinMaxDescribe", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
    }

	model_internal var _dminternal_model : _AdvancedDoubleMinMaxDescribeEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_oriMinVal : Number;
	private var _internal_oriMaxVal : Number;
	private var _internal_unitType : String;
	private var _internal_maxDoubleValue : Number;
	private var _internal_expressRule : ArrayCollection;
	private var _internal_minDoubleValue : Number;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_AdvancedDoubleMinMaxDescribe() 
	{	
		_model = new _AdvancedDoubleMinMaxDescribeEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get oriMinVal() : Number    
    {
            return _internal_oriMinVal;
    }    
	[Bindable(event="propertyChange")] 
    public function get oriMaxVal() : Number    
    {
            return _internal_oriMaxVal;
    }    
	[Bindable(event="propertyChange")] 
    public function get unitType() : String    
    {
            return _internal_unitType;
    }    
	[Bindable(event="propertyChange")] 
    public function get maxDoubleValue() : Number    
    {
            return _internal_maxDoubleValue;
    }    
	[Bindable(event="propertyChange")] 
    public function get expressRule() : ArrayCollection    
    {
            return _internal_expressRule;
    }    
	[Bindable(event="propertyChange")] 
    public function get minDoubleValue() : Number    
    {
            return _internal_minDoubleValue;
    }    

    /**
     * data property setters
     */      
    public function set oriMinVal(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_oriMinVal;               
        if (oldValue !== value)
        {
            _internal_oriMinVal = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "oriMinVal", oldValue, _internal_oriMinVal));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set oriMaxVal(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_oriMaxVal;               
        if (oldValue !== value)
        {
            _internal_oriMaxVal = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "oriMaxVal", oldValue, _internal_oriMaxVal));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set unitType(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_unitType;               
        if (oldValue !== value)
        {
            _internal_unitType = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "unitType", oldValue, _internal_unitType));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set maxDoubleValue(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_maxDoubleValue;               
        if (oldValue !== value)
        {
            _internal_maxDoubleValue = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxDoubleValue", oldValue, _internal_maxDoubleValue));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set expressRule(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:ArrayCollection = _internal_expressRule;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_expressRule = value;
            }
            else if (value is Array)
            {
                _internal_expressRule = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of expressRule must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "expressRule", oldValue, _internal_expressRule));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set minDoubleValue(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_minDoubleValue;               
        if (oldValue !== value)
        {
            _internal_minDoubleValue = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "minDoubleValue", oldValue, _internal_minDoubleValue));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    

    /**
     * data property setter listeners
     */   

   model_internal function setterListenerAnyConstraint(value:flash.events.Event):void
   {
        if (model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }        
   }   

    /**
     * valid related derived properties
     */
    model_internal var _isValid : Boolean;
    model_internal var _invalidConstraints:Array = new Array();
    model_internal var _validationFailureMessages:Array = new Array();

    /**
     * derived property calculators
     */

    /**
     * isValid calculator
     */
    model_internal function calculateIsValid():Boolean
    {
        var violatedConsts:Array = new Array();    
        var validationFailureMessages:Array = new Array();    


		var styleValidity:Boolean = true;
	
	
	
	
	
	
    
        model_internal::_cacheInitialized_isValid = true;
        model_internal::invalidConstraints_der = violatedConsts;
        model_internal::validationFailureMessages_der = validationFailureMessages;
        return violatedConsts.length == 0 && styleValidity;
    }  

    /**
     * derived property setters
     */

    model_internal function set isValid_der(value:Boolean) : void
    {
       	var oldValue:Boolean = model_internal::_isValid;               
        if (oldValue !== value)
        {
        	model_internal::_isValid = value;
        	_model.model_internal::fireChangeEvent("isValid", oldValue, model_internal::_isValid);
        }        
    }

    /**
     * derived property getters
     */

    [Transient] 
	[Bindable(event="propertyChange")] 
    public function get _model() : _AdvancedDoubleMinMaxDescribeEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _AdvancedDoubleMinMaxDescribeEntityMetadata) : void       
    {
    	var oldValue : _AdvancedDoubleMinMaxDescribeEntityMetadata = model_internal::_dminternal_model;               
        if (oldValue !== value)
        {
        	model_internal::_dminternal_model = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_model", oldValue, model_internal::_dminternal_model));
        }     
    }      

    /**
     * methods
     */  


    /**
     *  services
     */                  
     private var _managingService:com.adobe.fiber.services.IFiberManagingService;
    
     public function set managingService(managingService:com.adobe.fiber.services.IFiberManagingService):void
     {
         _managingService = managingService;
     }                      
     
    model_internal function set invalidConstraints_der(value:Array) : void
    {  
     	var oldValue:Array = model_internal::_invalidConstraints;
     	// avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_invalidConstraints = value;   
			_model.model_internal::fireChangeEvent("invalidConstraints", oldValue, model_internal::_invalidConstraints);   
        }     	             
    }             
    
     model_internal function set validationFailureMessages_der(value:Array) : void
    {  
     	var oldValue:Array = model_internal::_validationFailureMessages;
     	// avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_validationFailureMessages = value;   
			_model.model_internal::fireChangeEvent("validationFailureMessages", oldValue, model_internal::_validationFailureMessages);   
        }     	             
    }        
     
     // Individual isAvailable functions     
	// fields, getters, and setters for primitive representations of complex id properties

}

}
