package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.util.FlxSave;
import openfl.display.StageQuality;

class Main extends Sprite 
{
	var gameWidth:Int = 1920; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 1080; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = PlayState; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = false; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = true; // Whether to start the game in fullscreen on desktop targets
	
	// You can pretty much ignore everything from here on - your code should go in your states.
	
	public static function main():Void
	{	
		Lib.current.addChild(new Main());
	}
	
	public function new() 
	{
		super();
		
		if (stage != null) 
		{
			init();
		}
		else 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
	
	private function init(?E:Event):Void 
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		setupGame();
	}
	
	private function setupGame():Void
	{
		
		
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}
		
		//It makes a new FlxSave object, binds it to our "flixel-tutorial" and then checks if there is a volume and fullscreen value stored in it, 
		//and if there is, sets our game's volume and screen to match, and then closes the save.
		var _save:FlxSave = new FlxSave();
		_save.bind("flixel-tutorial");
		#if desktop
		if (_save.data.fullscreen != null)
		{
			startFullscreen = _save.data.fullscreen;
		}
		#end
		
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
		
		if (_save.data.volume != null)
		{
			FlxG.sound.volume = _save.data.volume;
			#if flash
			FlxG.sound.playMusic(AssetPaths.soundtracklevel1__wav,1,true);
			#else
			FlxG.sound.playMusic(AssetPaths.soundtracklevel1__wav, 1, true);
			#end
		}
		_save.close();
	}
}