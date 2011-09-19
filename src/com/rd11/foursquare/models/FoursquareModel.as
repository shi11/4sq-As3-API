////////////////////////////////////////////////////////////
// Project: foursquare 
// Author: Seth Hillinger
// Created: Jan 23, 2010 
// Updated: Sep 19, 2011 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.models
{
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import org.iotashan.oauth.OAuthToken;
	import org.robotlegs.mvcs.Actor;
	
	public class FoursquareModel extends Actor
	{
		
		/**
		 * log for service results 
		 */		
		private var _log:String;
		
		/**
		 * current version of users app 
		 */		
		public var currentVersion:String;
		
		/**
		 * used for autologin 
		 */		
		public var rememberMe:Boolean;
		
		/**
		 * logged in user's id. 
		 */		
		public var myId:int;
		
		/**
		 * user dictionary.
		 */		
		public var users:Dictionary = new Dictionary();
		
		/**
		 * checkin feed 
		 */		
		public var feed:ArrayCollection=new ArrayCollection();
		
		/**
		 * oauth2 token 
		 */		
		private var _accessToken : String;
		
		/**
		 * selectedVenue 
		 */		
		public var selectedVenue:Object;
		

		/**
		 * accesstoken 
		 */
		public function get accessToken():String
		{
			return _accessToken;
		}
		/**
		 * @private
		 */
		public function set accessToken(value:String):void
		{
			_accessToken = value;
			
			var so : SharedObject = SharedObject.getLocal("foursquare");
			so.data["accessToken"] = _accessToken;
			so.flush();
		}

		public function FoursquareModel()
		{
			super();
		}
		
		public function log(value:String):void{
			_log = value;
		}
		
	}
}