////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Feb 18, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.services
{
	import com.rd11.foursquare.events.ErrorEvent;
	import com.rd11.foursquare.events.SearchEvent;
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.models.vo.CheckinVO;
	import com.rd11.foursquare.models.vo.UserVO;
	import com.rd11.foursquare.models.vo.VenueVO;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	import com.rd11.foursquare.util.XMLUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.flaircode.oauth.IOAuth;
	import org.flaircode.oauth.OAuth;
	import org.robotlegs.mvcs.Actor;

	public class FoursquareService extends Actor implements IFoursquareService
	{
		
		[Inject]
		public var foursquareModel:FoursquareModel;
		
		[Inject]
		public var bus:FoursquareSignalBus;
		
		private var _url : String = "http://api.foursquare.com/v2/";
		
		private var consumerKey : String = '266d5934f6cb223fcd5ffc75eeb0a99404acf504c';
		private var consumerSecret : String = '6265da6ce9bd8cb2c69632ae51836327';
		
		private static const DATEVERIFIED : String = "20110917"
		
		private var oauth : IOAuth;
		
		//TODO (seth) move these into a Model
		private var actor : UserVO;
		
		public function FoursquareService()
		{
			oauth = new OAuth(consumerKey, consumerSecret);
		}
		
		/*public function login(loginVO:LoginVO):void
		{
			var request : URLRequest = oauth.buildRequest(
				URLRequestMethod.POST, _url+'authexchange',
				null, 
				{fs_username: loginVO.username, fs_password: loginVO.password});
			
			var loader : URLLoader = new URLLoader();
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoginError);
			loader.addEventListener(Event.COMPLETE, onLoginSuccess);
			loader.load(request);
		}*/
		
		/**
		 * checkin 
		 * @param shout
		 * @param venueVO
		 * 
		 */		
		public function checkin(shout:String="", venueVO:VenueVO=null):void
		{
			var service : HTTPService = new HTTPService();
			service.method = URLRequestMethod.GET;
			//confirm this
			service.url = "https://api.foursquare.com/v2/users/self/checkins";
			//service.useProxy = false;
			
			var params:Object = new Object();
			params.oauth_token = foursquareModel.accessToken;

			if (venueVO){
				if( venueVO.id ) params.vid = venueVO.id;
				if (venueVO.name.length > 1) params.venue = venueVO.name;
			}
			
			if (shout.length > 1) params.shout = shout;
			
			
			service.addEventListener(ResultEvent.RESULT, onResult_checkin );
			service.addEventListener(FaultEvent.FAULT, onFault );
			
			service.send(params);
		}
		
		/**
		 * Get Checkins 
		 */		
		public function getFeed():void
		{
			/*var request : URLRequest = oauth.buildRequest(
				URLRequestMethod.GET, 
				_url+'checkins.json',
				foursquareModel.oauth_token);
			
			var loader : URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.addEventListener(Event.COMPLETE, onResult_getFeed);
			loader.load(request);*/
		}
		
		/**
		 * GET HISTORY 
		 * @param limit
		 * */
		public function getHistory(timeStamp:Number=-1):void
		{
			var service : HTTPService = new HTTPService();
			service.method = URLRequestMethod.GET;
			service.url = "https://api.foursquare.com/v2/users/self/venuehistory";
			
			var params:Object = new Object();
			params.oauth_token = foursquareModel.accessToken;
			if( timeStamp > 0){
				params.beforeTimestamp = timeStamp;
			}
			
			service.addEventListener(ResultEvent.RESULT, onResult_getHistory );
			service.addEventListener(FaultEvent.FAULT, onFault );
			
			service.send(params);
		}
		
		/**
		 * GET MY DETAILS 
		 * @param uid
		 * 
		 */	
		/*public function getMyDetails(userVO:UserVO):void
		{
			var params : Object = new Object();
			if(userVO){
				params.uid = userVO.id;
				params.badges = true;
				params.mayor = true;
			}
			
			var request : URLRequest = oauth.buildRequest(
				URLRequestMethod.GET, 
				_url+'user.xml',
				foursquareModel.oauth_token, params);
			
			var loader : URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.addEventListener(Event.COMPLETE, onResult_getMyDetails);
			loader.load(request);
		}*/
		
		/**
		 * GET USER DETAILS 
		 * @param uid
		 * @param badges
		 * @param mayor
		 * 
		 */	
		public function getUserDetails(userVO:UserVO, lazy:Boolean):void
		{
			/*var params : Object = new Object();
			if(userVO.id){
				params.uid = userVO.id;
				params.badges = lazy;
				params.mayor = lazy;
			}
			
			var request : URLRequest = oauth.buildRequest(
				URLRequestMethod.GET, 
				_url+'user.json',
				foursquareModel.oauth_token, params);
			
			var loader : URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.addEventListener(Event.COMPLETE, onResult_getUserDetails);
			loader.load(request);*/
		}
		
		/**
		 * GET VENUES
		 * geolat - latitude (required)
		 * geolong - longitude (required)
		 * r - radius in miles (optional)
		 * l - limit of results (optional, default 10)
		 * q - keyword search (optional)
		 */
		public function getVenues(geolat:Number, geolong:Number, q:String=null):void
		{
			
			var service : HTTPService = new HTTPService();
			service.method = URLRequestMethod.GET;
			service.url = "https://api.foursquare.com/v2/venues/search";
			
			var params:Object = new Object();
			params.client_id = consumerKey;
			params.client_secret = consumerSecret;
			params.ll = geolat + "," + geolong;
			if(q) params.query = q;
			
			params.v = DATEVERIFIED;
			
			service.addEventListener(ResultEvent.RESULT, onResult_getVenues );
			service.addEventListener(FaultEvent.FAULT, onFault );
			
			service.send(params);
		}
		
		public function listCities():void
		{
		}
		
		//*****************************************
		// HANDLERS
		//*****************************************	
		
		private function onResult_checkin(event : ResultEvent):void{
			var jsonObj:Object = JSON.parse( event.result as String );
			var message:String = jsonObj.response.message;
			bus.checkinResult.dispatch( message );
		}
		
		private function onResult_getHistory(event : ResultEvent):void{
			var jsonObj:Object = JSON.parse( event.result as String );
			var venues:Array = jsonObj.response.venues.items;
			bus.historyResponse.dispatch( venues );
		}

		private function onFault(event : FaultEvent):void{
			var errorEvent: ErrorEvent = new ErrorEvent( ErrorEvent.ERROR );
			errorEvent.error = new Error( event.fault.faultDetail );
			dispatch( errorEvent );
		}
		
		/**
		 * process results of getFeed 
		 * @param event
		 * 
		 */		
		private function onResult_getFeed(event : Event):void{
			var checkins:Array = new Array();
			var xml:XML = new XML((event.target as URLLoader).data);
			
			//loop through xml and create VOs
			for each( var checkin : XML in xml..checkin){
				checkins.push( new CheckinVO( XMLUtil.XMLToObject( checkin.children() )) );
			}
			
			bus.feedResult.dispatch( checkins );
		}
		
		/**
		 * create and return a history dictionary of checkinVOs
		 * dictionary key: day, mo, year
		 * dictionary value: CheckinVO
		 * @param event
		 * 
		 */		
		
		/**
		 * returns userdetails 
		 * @param event
		 * 
		 */		
		private function onResult_getUserDetails(event:Event):void{
			var obj:Object = JSON.parse( event.target.data );
			var userVO:UserVO = new UserVO( obj.user );
			bus.userResult.dispatch( userVO );
		}
		
		/**
		 * returned following a getVenue call 
		 * @param event
		 * 
		 */		
		private function onResult_getVenues(event:ResultEvent) : void {
			var results:Object = JSON.parse( event.result as String );
			var venues:Array = results.response.venues;
			bus.nearbyResult.dispatch( venues );
			
			/*var venues:Array = new Array();
			var xml:XML = new XML((event.target as URLLoader).data);
			
			//loop through xml and create VOs
			for each( var venue : XML in xml..venue){
				venues.push( new VenueVO( XMLUtil.XMLToObject( venue.children() )) );
			}
			
			//dispatch event
			var searchEvent:SearchEvent = new SearchEvent(SearchEvent.QUERY_RETURNED);
			searchEvent.results = new ArrayCollection( venues );
			dispatch( searchEvent );*/
		}
		
		//*****************************************
		// ERROR HANDLERS
		//*****************************************	
		
		/*private function onLoginError(event:IOErrorEvent):void{
			var errorMessage : String = "Incorrect username/password or couldnt talk to foursquare";
			bus.loginResult.dispatch( false, errorMessage );
			//handleError(error);
		}*/
		
		private function onIOError(event:IOErrorEvent):void{
			var error : Error = new Error( (event.target as URLLoader).data, event.errorID );
			
			var errorEvent:ErrorEvent = new ErrorEvent( ErrorEvent.ERROR);
			errorEvent.error = error;
			dispatch(errorEvent);
		}
		
	}
}