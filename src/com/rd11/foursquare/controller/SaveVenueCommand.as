package com.rd11.foursquare.controller
{
	import com.rd11.foursquare.models.FoursquareModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class SaveVenueCommand extends Command
	{
		[Inject]
		public var model:FoursquareModel;
		
		[Inject]
		public var selectedVenue:Object;
		
		public function SaveVenueCommand()
		{
			super();
		}
		
		override public function execute():void{
			model.selectedVenue = selectedVenue;
		}
	}
}