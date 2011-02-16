////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Mar 13, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.views
{
	import com.rd11.foursquare.events.CheckinEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class SettingsMediator extends Mediator
	{
		
		[Inject]
		public var settingsView:SettingsView;
		
		public function SettingsMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener( settingsView, CheckinEvent.CHANGE_POLL_INTERVAL, onChangePollInterval );
			eventMap.mapListener( settingsView, CheckinEvent.TOGGLE_GROWL_MESSAGING, onToggleGrowl );
		}
		
		private function onChangePollInterval(event:CheckinEvent):void{
			eventDispatcher.dispatchEvent( event );
		}
		
		private function onToggleGrowl(event:CheckinEvent):void{
			eventDispatcher.dispatchEvent( event );		
		}
	}
}