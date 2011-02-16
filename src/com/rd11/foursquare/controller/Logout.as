////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Jan 31, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.controller
{
	import com.rd11.foursquare.models.FoursquareModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class Logout extends Command
	{
		
		[Inject]
		public var model:FoursquareModel;
		
		public function Logout()
		{
			super();
		}
		
		override public function execute() : void{
			var oauthFile:File = model.oauthFile;
			if(oauthFile.exists) oauthFile.deleteFile();
			
			model.feed.source.splice(0, model.feed.length);
		}

	}
}