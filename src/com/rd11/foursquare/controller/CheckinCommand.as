////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Updated: Jan 8, 2011
////////////////////////////////////////////////////////////

package com.rd11.foursquare.controller
{
	import com.rd11.foursquare.events.CheckinEvent;
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.services.IFoursquareService;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	
	import org.robotlegs.mvcs.SignalCommand;

	public class CheckinCommand extends SignalCommand
	{
		
		[Inject]
		public var service:IFoursquareService;
		
		[Inject]
		public var foursquareModel:FoursquareModel;
		
		[Inject]
		public var bus:FoursquareSignalBus;
		
	/*	[Inject]
		public var mainViewMediator:MainViewMediator;
		
		[Inject]
		public var checkinMediator:FeedMediator;*/
		

		public function CheckinCommand()
		{
			super();
		}
		
		override public function execute():void{
			getFeed();
		}
		
		private function createCheckin( event : CheckinEvent ):void{
			if(!event.venueVO)
			{
				service.checkin( event.message );
			}else{
				service.checkin( event.message, event.venueVO );
			}
		}
		
		private function getFeed():void{
			bus.feedRequest.add( onCheckinResult );
			service.getFeed();
		}
		
		private function onCheckinResult( feed: Array ):void{
			
			/*if( !checkinMediator.firstRead && mainViewMediator.showGrowl){
				var newFeed:ArrayCollection = findNewFeed( feed );
				for each(var checkin:CheckinVO in newFeed){
					mainViewMediator.growl( checkin );
				}
			}

			checkinMediator.handleResults();*/
			foursquareModel.feed.source = feed;
			//bus.checkinsResult
		}
		
		/**
		 * checks for new feed since last timerEvent...
		 * @param currentCheckin
		 * @param newCheckin
		 * @return 
		 * 
		 */		
		/*private function findNewFeed(feed:Array):ArrayCollection{
			
			var timeFromLastPoll:Number = new Date().time - checkinMediator.pollInterval;
			var newFeed:ArrayCollection = new ArrayCollection();
			
			for each(var checkin:CheckinVO in feed){
				if( checkin.created.time > timeFromLastPoll){
					newFeed.addItem( checkin );
				}else{
					break;
				}
			}
			return newFeed;			
		}
		
		private function startPolling():void{
			checkinMediator.startPolling();
		}

		private function stopPolling():void{
			checkinMediator.stopPolling();
		}
		
		private function handleCheckin( message:String ):void{
			mainViewMediator.handleShout( message );
			getFeed();
		}*/

	}
}