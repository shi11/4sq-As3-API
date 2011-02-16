////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Jan 30, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.views
{
	import models.vo.LoginVO;
	import signals.FoursquareSignalBus;
	import views.interfaces.ILoginView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class LoginMediator extends Mediator
	{
		
		[Inject]
		public var view:ILoginView;
		
		[Inject]
		public var signalBus:FoursquareSignalBus;
		
		public function LoginMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			view.loginRequest.add( login );
			signalBus.loginResult.add( onResults_login );
		}
		
		private function login(userName:String, password:String, rememberMe:Boolean):void{
			var loginVO:LoginVO = new LoginVO();
			loginVO.username = userName;
			loginVO.password = password;
			loginVO.rememberMe = rememberMe;
			signalBus.loginRequest.dispatch( loginVO );
		}
		
		private function onResults_login( value:Boolean, message:String="" ):void{
			view.loginResponse( value, message );
		} 
		
	}
}