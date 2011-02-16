////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Feb 7, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.controller
{
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.models.vo.UserVO;
	import com.rd11.foursquare.services.IFoursquareService;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	import com.rd11.foursquare.views.MainViewMediator;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class MyDetailsCommand extends SignalCommand
	{
		
		[Inject]
		public var foursquareSignalBus:FoursquareSignalBus;
		
		[Inject]
		public var foursquareService:IFoursquareService;

		[Inject]
		public var foursquareModel:FoursquareModel;
		
		[Inject]
		public var mainView:MainViewMediator;
		
		[Inject]
		public var userVO:UserVO;
		
		public function MyDetailsCommand()
		{
			super();
		}
		
		override public function execute() : void{
			foursquareService.getUserDetails( userVO, false );
			/*switch(event.type){
				case UserEvent.GET_MY_DETAILS:
					break;
				case UserEvent.MY_DETAILS_GOT:
					foursquareModel.currentUser = event.userVO;
					break;
			}*/
		}
	}
}