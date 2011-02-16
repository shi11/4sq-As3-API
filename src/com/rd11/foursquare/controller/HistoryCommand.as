////////////////////////////////////////////////////////////
// Project: foursquareapi
// Author: Seth Hillinger
// Created: Feb 12, 2011 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.controller
{
	import com.rd11.foursquare.models.Constants;
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.services.IFoursquareService;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Command;
	
	public class HistoryCommand extends Command
	{

		[Inject]
		public var service : IFoursquareService;
		
		[Inject]
		public var bus : FoursquareSignalBus;
		
		[Inject]
		public var model : FoursquareModel;
		
		public function HistoryCommand()
		{
			super();
		}
		
		override public function execute():void{
			bus.historyResponse.add( historyReturned );
			getHistory();
		}
		
		private function getHistory():void{
			service.getHistory();
		}
		
		private function historyReturned( value:Array ):void{
			//historyMediator.setHistory( value );
		}
	}
}