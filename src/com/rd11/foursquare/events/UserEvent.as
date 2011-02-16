////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Feb 7, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.events
{
	import com.rd11.foursquare.models.vo.UserVO;
	
	import flash.events.Event;
	
	public class UserEvent extends Event
	{
		
		public static const GET_MY_DETAILS:String = "getMyDetails";
		public static const MY_DETAILS_GOT:String = "myDetailsGot";
		
		public static const GET_DETAILS:String = "getDetails";
		public static const DETAILS_GOT:String = "detailsGot";
		
		public var userVO:UserVO;
		
		public function UserEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event{
			var userEvent:UserEvent = new UserEvent( type );
			userEvent.userVO = userVO;
			return userEvent;
		}
	}
}