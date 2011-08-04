////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Jan 27, 2011
////////////////////////////////////////////////////////////

package com.rd11.foursquare.views
{
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	import com.rd11.foursquare.views.interfaces.IFoursquareAuthenticationView;
	
	import flash.net.SharedObject;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class FoursquareAuthenticateMediator extends Mediator
	{
		
		[Inject]
		public var view:IFoursquareAuthenticationView;
		
		[Inject]
		public var signalBus:FoursquareSignalBus;
		
		public function FoursquareAuthenticateMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			view.locationChangeHandler = locationChangeHandler;
			view.authenticationRequest.add( authenticate );
			signalBus.authenticationResult.add( view.authenticationResults );
		}
		
		private function authenticate(clientId:String, redirectURI:String):void{
			view.navigate( 
					"https://foursquare.com/oauth2/authenticate?" +
					"client_id="+clientId+
					"&response_type=token" +
					"&redirect_uri="+redirectURI );
		
			signalBus.authenticationRequest.dispatch();
		}
		
		private function locationChangeHandler( location : String ):void{
			if (location.search('#access_token=') > -1){
				var accessToken:String = location.substr(location.search('=') + 1);
				signalBus.authenticationResult.dispatch( accessToken );
			}
		}
		
	}
}