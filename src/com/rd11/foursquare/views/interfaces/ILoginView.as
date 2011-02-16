package com.rd11.foursquare.views.interfaces
{
	import org.osflash.signals.ISignal;

	public interface ILoginView
	{
		function get loginRequest():ISignal;
		function loginResponse(value:Boolean, message:String=""):void;
	}
}