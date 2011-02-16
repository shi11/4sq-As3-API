package com.rd11.foursquare.views.interfaces
{
	import flash.utils.Dictionary;
	
	import org.osflash.signals.ISignal;

	public interface IHistoryView
	{
		function get historyRequest():ISignal;
		function historyResult( array:Array ):void;
	}
}