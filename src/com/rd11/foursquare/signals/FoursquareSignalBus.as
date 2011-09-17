package com.rd11.foursquare.signals
{
	import com.rd11.foursquare.models.vo.CityVO;
	import com.rd11.foursquare.models.vo.UserVO;
	
	import org.osflash.signals.Signal;
	
	public class FoursquareSignalBus
	{

		public const startupRequest:Signal = new Signal();
		public const startupResponse:Signal = new Signal( String );
		
		public const error:Signal = new Signal( String );
		
		public const authenticationRequest:Signal = new Signal( );
		public const authenticationResult:Signal = new Signal( String );
		
		public const userRequest:Signal = new Signal( UserVO, Boolean ); // BOOL = lazy load
		public const userResult:Signal = new Signal( UserVO );
		
		public const checkinRequest:Signal = new Signal();
		public const checkinResult:Signal = new Signal( String );
		
		public const feedRequest:Signal = new Signal();
		public const feedResult:Signal = new Signal( Array );

		public const nearbyRequest:Signal = new Signal( CityVO );
		public const nearbyResult:Signal = new Signal( Array );
		
		public const historyRequest:Signal = new Signal();
		public const historyResponse:Signal = new Signal( Array ); 
	}
}