package com.rd11.foursquare.services
{
	import com.rd11.foursquare.models.vo.UserVO;
	import com.rd11.foursquare.models.vo.VenueVO;
	

	public interface IFoursquareService
	{
		//function login(loginVO:LoginVO):void;
		function checkin(shout : String="", venueVO:VenueVO=null):void;
		function getFeed():void;
		function getHistory(timeStamp:Number=-1):void;
		//function getMyDetails(userVO:UserVO):void;
		function getUserDetails(userVO:UserVO, lazy:Boolean):void;
		function getVenues(geolat:Number, geolong:Number, q:String=null):void;
		function listCities():void;	
	}
}