/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - TFusionsource.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.events.PropertyChangeEvent;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_TFusionsource extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.model.TFusionsource") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.model.TFusionsource", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.model.TFusionsource", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
    }

	model_internal var _dminternal_model : _TFusionsourceEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_id : int;
	private var _internal_searchUuid : String;
	private var _internal_fusionUuid : String;
	private var _internal_cell : String;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_TFusionsource() 
	{	
		_model = new _TFusionsourceEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get id() : int    
    {
            return _internal_id;
    }    
	[Bindable(event="propertyChange")] 
    public function get searchUuid() : String    
    {
            return _internal_searchUuid;
    }    
	[Bindable(event="propertyChange")] 
    public function get fusionUuid() : String    
    {
            return _internal_fusionUuid;
    }    
	[Bindable(event="propertyChange")] 
    public function get cell() : String    
    {
            return _internal_cell;
    }    

    /**
     * data property setters
     */      
    public function set id(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_id;               
        if (oldValue !== value)
        {
            _internal_id = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "id", oldValue, _internal_id));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set searchUuid(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_searchUuid;               
        if (oldValue !== value)
        {
            _internal_searchUuid = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "searchUuid", oldValue, _internal_searchUuid));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set fusionUuid(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_fusionUuid;               
        if (oldValue !== value)
        {
            _internal_fusionUuid = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fusionUuid", oldValue, _internal_fusionUuid));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set cell(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_cell;               
        if (oldValue !== value)
        {
            _internal_cell = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "cell", oldValue, _internal_cell));
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
    public function get _model() : _TFusionsourceEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _TFusionsourceEntityMetadata) : void       
    {
    	var oldValue : _TFusionsourceEntityMetadata = model_internal::_dminternal_model;               
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
