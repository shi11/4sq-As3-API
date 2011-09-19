////////////////////////////////////////////////////////////
// Project: foursquareapi
// Author: Seth Hillinger
// Created: Jan 31, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.views
{
	import com.rd11.foursquare.events.CheckinEvent;
	import com.rd11.foursquare.events.UserEvent;
	import com.rd11.foursquare.events.VenueEvent;
	import com.rd11.foursquare.models.Constants;
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.models.vo.UserVO;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	import com.rd11.foursquare.views.interfaces.IFeedView;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.events.CollectionEvent;
	
	import org.robotlegs.mvcs.Mediator;

	public class FeedMediator extends Mediator
	{

		[Inject]
		public var foursquareModel:FoursquareModel;

		[Inject]
		public var view:IFeedView;
		
		[Inject]
		public var bus:FoursquareSignalBus;
		
		/**
		 * flag for when to start polling
		 */
		private var _firstRead : Boolean = true;
		/**
		 * delay between timer events in milliseconds
		 */
		private var _pollInterval : int = Constants.defaultPollInterval;

		private var timer : Timer;

		public function FeedMediator()
		{
			super();
		}

		override public function onRegister() : void
		{
			view.feedRequest.add( getCheckins );
			bus.feedResult.add( onResult_getCheckins );
		}
		
		private function getCheckins():void{
			bus.feedRequest.dispatch();
		}
		
		private function onResult_getCheckins( data:Array ):void{
			if (_firstRead)
			{
				_firstRead = false;
				view.feedResult( data );
			}
		}

		/*public function startPolling() : void
		{
			if (!timer)
			{
				timer = new Timer(_pollInterval);
				timer.addEventListener(TimerEvent.TIMER, getFeed);
			}
			timer.start();
		}

		public function stopPolling() : void
		{
			timer.stop();
		}*/

		public function setUserDetails(userVO : UserVO) : void
		{
			//feedView.openUserDetails(userVO);
		}
		
		private function onFeedChange(event:CollectionEvent):void{
			//feedView.createView( foursquareModel.feed );
		}

		private function getFeed(event : TimerEvent=null) : void
		{
			eventDispatcher.dispatchEvent(new CheckinEvent(CheckinEvent.READ));
		}

		private function getUserDetails(event : UserEvent) : void
		{
			eventDispatcher.dispatchEvent(event.clone());
		}

		private function getVenueDetails(event : VenueEvent) : void
		{
			eventDispatcher.dispatchEvent(event.clone());
		}

		public function get firstRead() : Boolean
		{
			return _firstRead;
		}

		public function set pollInterval(interval : int) : void
		{
			_pollInterval = interval;
			timer.delay = _pollInterval;
			timer.reset();
		}

		public function get pollInterval() : int
		{
			return _pollInterval;
		}
	}
}