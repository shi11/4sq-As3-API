////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Jan 30, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.events
{
	import com.rd11.foursquare.models.vo.VenueVO;
	
	import flash.events.Event;
	
	public class CheckinEvent extends Event
	{
		
		//public static const SHOUT:String = "shout";
		//public static const SHOUT_SUCCESS:String = "shoutSuccess";

		public static const CHECKIN:String = "checkin";
		public static const CHECKIN_SUCCESS:String = "checkinSuccess";
		
		public static const READ:String = "read";
		public static const READ_RETURNED:String = "readReturned";
		
		//at a future date perhaps refactor this into a settingsevent
		public static const CHANGE_POLL_INTERVAL:String = "changePollInterval";
		public static const TOGGLE_GROWL_MESSAGING:String = "toggleGrowlMessaging";
		
		public var userId:int;
		public var message:String;
		
		public var venueVO:VenueVO;
		public var checkins:Array;
		
		public var interval:int;
		public var useGrowl:Boolean;
		
		public function CheckinEvent(type:String)
		{
			super(type, false, false);
		}
		
		override public function clone() : Event{
			var checkinEvent:CheckinEvent = new CheckinEvent(type);
			checkinEvent.userId = userId;
			checkinEvent.message = message;
			checkinEvent.venueVO = venueVO;
			checkinEvent.checkins = checkins;
			checkinEvent.interval = interval;
			checkinEvent.useGrowl = useGrowl;
			return checkinEvent;
		}
	}
}