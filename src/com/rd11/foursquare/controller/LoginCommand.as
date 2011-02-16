////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Updated: Jan 8, 2011
////////////////////////////////////////////////////////////

package com.rd11.foursquare.controller
{
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.models.vo.LoginVO;
	import com.rd11.foursquare.services.IFoursquareService;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class LoginCommand extends SignalCommand
	{
		
		[Inject]
		public var service:IFoursquareService;
		
		[Inject]
		public var bus:FoursquareSignalBus;
		
		[Inject]
		public var model:FoursquareModel;
		
		[Inject]
		public var loginVO:LoginVO;
		
		
		public function LoginCommand()
		{
			super();
		}
		
		override public function execute():void{
			bus.loginResult.add( onLoginResult );
			model.rememberMe = loginVO.rememberMe;
			service.login( loginVO );
		}
		
		private function onLoginResult( success:Boolean, message:String="" ):void{
			if( success ){
				//TODO move out of api and into demo code
				/*if(model.rememberMe){
					var d:Object = new Object();
					d.oauth_token_key = model.oauth_token.key;
					d.oauth_token_secret = model.oauth_token.secret;
					var contents:String = XMLUtil.objectToXML(d).toXMLString();
					
					var stream:FileStream = new FileStream(); 
					stream.open(model.oauthFile, FileMode.WRITE);
					stream.writeUTFBytes(contents); 
					stream.close(); 
				}*/
				
				bus.userRequest.dispatch( new UserVO(), false );
			}
		}
	}
}