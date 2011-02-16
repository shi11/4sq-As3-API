package com.rd11.foursquare.controller
{
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	
	import flash.net.SharedObject;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class StartupCommand extends SignalCommand
	{
		
		[Inject]
		public var bus:FoursquareSignalBus;
		
		[Inject]
		public var foursquareModel:FoursquareModel;
		
		public function StartupCommand()
		{
			super();
		}
		
		override public function execute():void{
			var so : SharedObject = SharedObject.getLocal("foursquare");
			var accessToken:String = so.data["accessToken"];
			
			if( !accessToken ) accessToken = "";
			else foursquareModel.accessToken = accessToken;
			
			bus.authenticationResult.dispatch( accessToken );
		}
	}
}