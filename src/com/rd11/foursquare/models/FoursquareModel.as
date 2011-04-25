////////////////////////////////////////////////////////////
// Project: foursquare 
// Author: Seth Hillinger
// Created: Jan 23, 2010 
// Updated: Feb 12, 2011 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.models
{
	//import flash.filesystem.File;
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
		
		private var _accessToken : String;

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

		
		//TODO Seth: remove this.
		public var oauth_token : OAuthToken;
		
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
		
		public function FoursquareModel()
		{
			super();
			//oauthFile = File.applicationStorageDirectory.resolvePath("user/oauth_token.xml");
		}
		
		public function log(value:String):void{
			_log = value;
		}
		
	}
}