package com.rd11.foursquare.events
{
	import flash.events.Event;
	
	import mx.rpc.IResponder;
	
	public class CallbackEvent extends Event
	{
		
		private var _callback:IResponder;
		
		public function CallbackEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, callback:IResponder=null)
		{
			super(type, bubbles, cancelable);
			
			_callback = callback;
		}
	}
}