package com.rd11.foursquare.views.interfaces
{
	import org.osflash.signals.ISignal;

	public interface IFeedView
	{
		function get feedRequest():ISignal;
		function feedResult(array:Array):void;
	}
}