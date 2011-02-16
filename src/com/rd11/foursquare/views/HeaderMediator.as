////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Mar 9, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.views
{
	import com.rd11.foursquare.events.CheckinEvent;
	import com.rd11.foursquare.events.UserEvent;
	import com.rd11.foursquare.events.VenueEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;

	public class HeaderMediator extends Mediator
	{
		[Inject]
		public var headerView:HeaderView;
		
		[Inject]
		public var model:FoursquareModel;
		
		public function HeaderMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener( eventDispatcher, UserEvent.MY_DETAILS_GOT, onMyDetailsGot );
			eventMap.mapListener( eventDispatcher, VenueEvent.VENUE_CHANGING, onVenueChanging );
			eventMap.mapListener( eventDispatcher, CheckinEvent.CHECKIN_SUCCESS, onCheckinSuccess );
			eventMap.mapListener( headerView, CheckinEvent.CHECKIN, bounceEvent );
			eventMap.mapListener( headerView, IssueEvent.READ, bounceEvent );
			eventMap.mapListener( headerView, NavigationEvent.CHANGE, bounceEvent );
			
			if(model.currentUser){
				showUser(model.currentUser.firstname, model.currentUser.lastname, model.currentUser.photo);
			}
		}
		
		private function bounceEvent( event:Event ):void{
			dispatch( event.clone() );
		}
		
		/**
		 * display
		 * 
		 * @param firstName
		 * @param lastName
		 * @param photo
		 * 
		 */		
		private function showUser(firstName:String, lastName:String, photo:String):void{
			headerView.userName.text = firstName +" "+ lastName;
			headerView.userImage.source = photo;
		}
		
		/**
		 * recieve user details
		 * @param event
		 * 
		 */		
		private function onMyDetailsGot(event:UserEvent):void{
			var lastName:String;
			event.userVO.lastname ? lastName = event.userVO.lastname : lastName = "";
			showUser(event.userVO.firstname, lastName, event.userVO.photo);
		}
		
		/**
		 * when user is changing their venue 
		 * @param event
		 * 
		 */		
		private function onVenueChanging(event:VenueEvent):void{
			headerView.selectedVenue = event.venue;
		}
		
		private function onCheckinSuccess(event:CheckinEvent):void{
			headerView.handleCheckinSuccess(event);
		}
	}
}