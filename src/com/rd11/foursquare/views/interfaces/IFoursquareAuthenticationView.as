package com.rd11.foursquare.views.interfaces
{
	import org.osflash.signals.ISignal;

	public interface IFoursquareAuthenticationView
	{
		function get authenticationRequest():ISignal;
		function get locationChangeHandler():Function;
		function set locationChangeHandler(value:Function):void;

		function navigate( href:String ):void;
		function authenticationResults( accessToken : String ):void;
	}
}