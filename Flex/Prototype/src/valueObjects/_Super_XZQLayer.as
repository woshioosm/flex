/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - XZQLayer.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.XZQValue;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_XZQLayer extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.model.XZQLayer") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.model.XZQLayer", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.model.XZQLayer", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
        valueObjects.XZQValue.initRemoteClassAliasSingleChild();
    }

	model_internal var _dminternal_model : _XZQLayerEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_values : ArrayCollection;
	model_internal var _internal_values_leaf:valueObjects.XZQValue;
	private var _internal_maxFeacode : Number;
	private var _internal_layerName : String;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_XZQLayer() 
	{	
		_model = new _XZQLayerEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get values() : ArrayCollection    
    {
            return _internal_values;
    }    
	[Bindable(event="propertyChange")] 
    public function get maxFeacode() : Number    
    {
            return _internal_maxFeacode;
    }    
	[Bindable(event="propertyChange")] 
    public function get layerName() : String    
    {
            return _internal_layerName;
    }    

    /**
     * data property setters
     */      
    public function set values(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:ArrayCollection = _internal_values;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_values = value;
            }
            else if (value is Array)
            {
                _internal_values = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of values must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "values", oldValue, _internal_values));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set maxFeacode(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_maxFeacode;               
        if (oldValue !== value)
        {
            _internal_maxFeacode = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxFeacode", oldValue, _internal_maxFeacode));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set layerName(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_layerName;               
        if (oldValue !== value)
        {
            _internal_layerName = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "layerName", oldValue, _internal_layerName));
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
    public function get _model() : _XZQLayerEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _XZQLayerEntityMetadata) : void       
    {
    	var oldValue : _XZQLayerEntityMetadata = model_internal::_dminternal_model;               
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
