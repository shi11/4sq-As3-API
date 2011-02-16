package com.rd11.foursquare.flexUnitTests
{
	import models.FoursquareModel;
	import models.vo.LoginVO;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.failOnSignal;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.proceedOnSignal;
	import org.osflash.signals.utils.registerFailureSignal;
	
	import services.FoursquareService;
	
	import signals.FoursquareSignalBus;

	//@see http://eidiot.net/en/2010/05/21/async-test-for-as3-signals-with-flexunit4/
	
	public class LoginTestCase
	{
		
		private var bus:FoursquareSignalBus;
		private var context:FourSquareContext;
		private var foursquareService:FoursquareService;
		private var model:FoursquareModel;
		
		[Before]
		public function setUp():void
		{
			bus = new FoursquareSignalBus();
			context = new FourSquareContext();
			foursquareService = new FoursquareService();
			model = new FoursquareModel();
			
			foursquareService.bus = bus;
			foursquareService.model = model;
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		//======================================================================
		//  Test methods
		//======================================================================
		[Test(async)]
		public function test_proceedOnSignal():void 
		{
			var signal:Signal = new Signal();
			proceedOnSignal(this, signal);
			signal.dispatch();
		}
		
		[Test(async)] 
		public function test_requestSignal():void 
		{
			var loginRequest:Signal = bus.loginRequest;
			
			var loginVO:LoginVO = new LoginVO();
			loginVO.username = "sethtest1@rd11.com";
			loginVO.password = "sethtester";
			loginVO.rememberMe = false;
			
			handleSignal( this, loginRequest, verify_requestSignal, 500, loginVO );
			loginRequest.dispatch( loginVO );
		}
		
		[Test(async)] 
		public function test_service():void 
		{
			
			var loginVO:LoginVO = new LoginVO();
			loginVO.username = "sethtest1@rd11.com";
			loginVO.password = "sethtester";
			loginVO.rememberMe = false;
			
			var loginResult:ISignal = bus.loginResult;
			handleSignal( this, loginResult, verify_resultSuccess, 500, loginVO );
			
			foursquareService.login( loginVO );
		}
		
		[Test(async)] 
		public function test_failOnSignal():void 
		{
			var signal:Signal = new Signal();
			failOnSignal(this, signal);
		}
		[Test(async)] 
		public function test_registerFailureSignal():void 
		{
			var signal:Signal = new Signal();
			registerFailureSignal(this, signal);
		}
		//======================================================================
		//  Verify methods
		//======================================================================
		private function verify_resultSuccess(event:SignalAsyncEvent, data:Object):void 
		{
			assertEquals(event.args[0], true);
			assertNotNull( model.oauth_token.key );
			assertNotNull( model.oauth_token.secret );
		}
		
		private function verify_requestSignal(event:SignalAsyncEvent, data:Object):void 
		{
			assertEquals(event.args[0].username, data.username);
			assertEquals(event.args[0].password, data.password);
		}
	}
}