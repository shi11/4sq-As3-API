////////////////////////////////////////////////////////////
// Project: foursquareapi 
// Author: Seth Hillinger
// updated: Feb 12, 2011
////////////////////////////////////////////////////////////

package com.rd11.foursquare.views
{
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	import com.rd11.foursquare.views.interfaces.IHistoryView;
	
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class HistoryMediator extends Mediator
	{

		[Inject]
		public var view:IHistoryView;
		
		[Inject]
		public var bus:FoursquareSignalBus;
		
		public function HistoryMediator()
		{
			super();
		}
		
		override public function onRegister() : void{
			view.historyRequest.add( getHistory );
			bus.historyResponse.add( setHistory );
		}
		
		override public function onRemove() : void{
			super.onRemove();
		}
		
		public function setHistory( array: Array ):void{
			view.historyResult( array );
		}
		
		private function getHistory():void{
			bus.historyRequest.dispatch();
		}
	}
}