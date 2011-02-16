////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Feb 9, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.views
{
	import com.rd11.foursquare.events.LoginEvent;
	import com.rd11.foursquare.events.NavigationEvent;
	import com.rd11.foursquare.views.interfaces.INavigationView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class NavigationMediator extends Mediator
	{
		
		public static const HOME:String = "home";
		
		[Inject]
		public var navigation:INavigationView;
		
		public function NavigationMediator()
		{
			super();
		}
		
		public function home():void{
			
		}
		
		override public function onRegister():void
		{
			//listen for a click
			eventMap.mapListener( navigation, NavigationEvent.CHANGE, bounceEvent );

			eventMap.mapListener( eventDispatcher, LoginEvent.LOGOUT, onLogout );
		}

		private function onLogout(event:LoginEvent):void{
			//navigation.buttonBar.selectedIndex = 0;
		}
		
		//make robotlegs aware of the change.
		private function bounceEvent(event:NavigationEvent):void{
			eventDispatcher.dispatchEvent( event );
		}
		
	}
}