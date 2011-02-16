////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: April 16, 2010 
// Modified Jan 2, 2010
////////////////////////////////////////////////////////////

package com.rd11.foursquare.controller
{
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.models.vo.UserVO;
	import com.rd11.foursquare.services.IFoursquareService;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class UserDetailsCommand extends SignalCommand
	{
	
		//parameters from signal
		[Inject] public var userVO:UserVO;
		[Inject] public var lazy:Boolean;

		[Inject]
		public var service:IFoursquareService;
		
		[Inject]
		public var bus:FoursquareSignalBus;
		
		[Inject]
		public var model:FoursquareModel;
		
		public function UserDetailsCommand()
		{
			super();
		}
		
		override public function execute() : void{
			bus.userResult.add( onUserResult );
			service.getUserDetails( userVO, lazy );
		}
		
		private function onUserResult( user:UserVO ):void{
			model.users[userVO.id] = userVO;
		}
	}
}