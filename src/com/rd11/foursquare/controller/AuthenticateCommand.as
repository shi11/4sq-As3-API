package com.rd11.foursquare.controller
{
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	
	import flash.net.SharedObject;
	
	import org.robotlegs.mvcs.Command;
	
	public class AuthenticateCommand extends Command
	{
		[Inject]
		public var bus : FoursquareSignalBus;
		
		[Inject]
		public var model : FoursquareModel;
		
		public function AuthenticateCommand()
		{
			super();
		}
		
		override public function execute():void{
			bus.authenticationResult.add( onAuthenticationResult );
		}
		
		private function onAuthenticationResult( accessToken : String ):void{
			
			var so : SharedObject = SharedObject.getLocal("foursquare");
			so.data["accessToken"] = accessToken;
			so.flush();
			
			model.accessToken = accessToken;
		}
	}
}