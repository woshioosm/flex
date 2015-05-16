/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - FusionResultMap.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.DeepFrameWithLang;
import valueObjects.TFusionresult;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_FusionResultMap extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.model.FusionResultMap") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.model.FusionResultMap", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.model.FusionResultMap", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
        valueObjects.TFusionresult.initRemoteClassAliasSingleChild();
        valueObjects.Timestamp.initRemoteClassAliasSingleChild();
        valueObjects.DeepFrameWithLang.initRemoteClassAliasSingleChild();
    }

	model_internal var _dminternal_model : _FusionResultMapEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_fusionResult : valueObjects.TFusionresult;
	private var _internal_uuid : String;
	private var _internal_sources : ArrayCollection;
	model_internal var _internal_sources_leaf:valueObjects.DeepFrameWithLang;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_FusionResultMap() 
	{	
		_model = new _FusionResultMapEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get fusionResult() : valueObjects.TFusionresult    
    {
            return _internal_fusionResult;
    }    
	[Bindable(event="propertyChange")] 
    public function get uuid() : String    
    {
            return _internal_uuid;
    }    
	[Bindable(event="propertyChange")] 
    public function get sources() : ArrayCollection    
    {
            return _internal_sources;
    }    

    /**
     * data property setters
     */      
    public function set fusionResult(value:valueObjects.TFusionresult) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_fusionResult == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:valueObjects.TFusionresult = _internal_fusionResult;               
        if (oldValue !== value)
        {
            _internal_fusionResult = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fusionResult", oldValue, _internal_fusionResult));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set uuid(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_uuid == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_uuid;               
        if (oldValue !== value)
        {
            _internal_uuid = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "uuid", oldValue, _internal_uuid));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set sources(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_sources == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:ArrayCollection = _internal_sources;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_sources = value;
            }
            else if (value is Array)
            {
                _internal_sources = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of sources must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sources", oldValue, _internal_sources));
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

		if (_model.isFusionResultAvailable && _internal_fusionResult == null)
		{
			violatedConsts.push("fusionResultIsRequired");
			validationFailureMessages.push("fusionResult is required");
		}
		if (_model.isUuidAvailable && _internal_uuid == null)
		{
			violatedConsts.push("uuidIsRequired");
			validationFailureMessages.push("uuid is required");
		}
		if (_model.isSourcesAvailable && _internal_sources == null)
		{
			violatedConsts.push("sourcesIsRequired");
			validationFailureMessages.push("sources is required");
		}

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
    public function get _model() : _FusionResultMapEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _FusionResultMapEntityMetadata) : void       
    {
    	var oldValue : _FusionResultMapEntityMetadata = model_internal::_dminternal_model;               
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
