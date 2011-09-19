////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Jan 23, 2010 
// Last modified: Dec 12, 2010
////////////////////////////////////////////////////////////

package com.rd11.foursquare
{
	import com.rd11.foursquare.controller.AuthenticateCommand;
	import com.rd11.foursquare.controller.CheckinCommand;
	import com.rd11.foursquare.controller.HistoryCommand;
	import com.rd11.foursquare.controller.SaveVenueCommand;
	import com.rd11.foursquare.controller.SearchCommand;
	import com.rd11.foursquare.controller.StartupCommand;
	import com.rd11.foursquare.controller.UserDetailsCommand;
	import com.rd11.foursquare.events.CheckinEvent;
	import com.rd11.foursquare.events.HistoryEvent;
	import com.rd11.foursquare.events.UserEvent;
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.services.FoursquareService;
	import com.rd11.foursquare.services.IFoursquareService;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.SignalContext;
	
	public class FourSquareContext extends SignalContext
	{
		
		public static var foursquareSignalBus:FoursquareSignalBus;
		
		public function FourSquareContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super();
		}
		
		public static function get bus():FoursquareSignalBus{
			return foursquareSignalBus;
		}
		
		override public function startup():void
		{
			foursquareSignalBus = new FoursquareSignalBus();
			injector.mapValue( FoursquareSignalBus, foursquareSignalBus );
			
			signalCommandMap.mapSignal( foursquareSignalBus.startupRequest, StartupCommand );
			signalCommandMap.mapSignal( foursquareSignalBus.authenticationRequest, AuthenticateCommand );
			signalCommandMap.mapSignal( foursquareSignalBus.userRequest, UserDetailsCommand );
			signalCommandMap.mapSignal( foursquareSignalBus.feedRequest, CheckinCommand );
			signalCommandMap.mapSignal( foursquareSignalBus.nearbyRequest, SearchCommand );
			signalCommandMap.mapSignal( foursquareSignalBus.historyRequest, HistoryCommand );
			signalCommandMap.mapSignal( foursquareSignalBus.venueSelected, SaveVenueCommand );
			
			//map model
			injector.mapSingleton( FoursquareModel );
			
			//map service
			injector.mapSingletonOf( IFoursquareService, FoursquareService );
			
			//foursquareSignalBus.startupRequest.dispatch();
		}
	}
}