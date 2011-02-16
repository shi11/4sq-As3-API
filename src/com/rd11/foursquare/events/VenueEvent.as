////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Mar 26, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.events
{
	
	import com.rd11.foursquare.models.vo.VenueVO;
	
	import flash.events.Event;
	
	public class VenueEvent extends Event
	{
		public static const GET_VENUE_DETAILS:String = "getVenueDetails";
		public static const VENUE_DETAILS_GOT:String = "venueDetailsGot";
		public static const VENUE_CHANGING:String = "venueChanging";
		
		public var venue:VenueVO;
		
		public function VenueEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone() : Event{
			var venueEvent:VenueEvent = new VenueEvent( type );
			venueEvent.venue = venue;
			return venueEvent;
		}
	}
}