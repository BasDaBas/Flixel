package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
using flixel.util.FlxSpriteUtil;
import flixel.util.FlxDestroyUtil;
import flash.system.System;


/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
	
 

{
	private var _btnPlay:FlxButton; // playbutton
	private var _txtTitle:FlxText;
	private var _btnOptions:FlxButton;
	private var _sprBackGround:FlxSprite;
	private var _btnExit:FlxButton;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	
	 override public function create():Void
	{
		//setup the background		
		_sprBackGround = new FlxSprite(0, 0, AssetPaths.BackgroundGame__png);
		add(_sprBackGround);
		// setup the play button
		_btnPlay = new FlxButton(0, 0,"", clickPlay);	
		_btnPlay.label = new FlxText(0, 0, _btnPlay.width, "Play");
		_btnPlay.label.setFormat(null, 20, 0x4f3510, "center");
		_btnPlay.scale.x = 3;
		_btnPlay.scale.y = 3;
		_btnPlay.x = (FlxG.width / 2) - _btnPlay.width - 100;
		_btnPlay.y = FlxG.height - _btnPlay.height - 170;		
		_btnPlay.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		_btnPlay.updateHitbox;
		add(_btnPlay);
		//setup the Option button
		_btnOptions = new FlxButton((FlxG.width / 2) + 100, _btnPlay.y, "", clickOptions);
		_btnOptions.label = new FlxText(0, 0, 0, "Options");
		_btnOptions.label.setFormat(null, 20, 0x4f3510, "center");		
		_btnOptions.scale.x = 3;
		_btnOptions.scale.y = 3;		
		_btnOptions.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(_btnOptions);
		//Camera fade in or out
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		//if playing at desktop, setup exit button
		_btnExit = new FlxButton(0, 0, "", clickExit);
		_btnExit.label = new FlxText(0,0,0, "Exit Game", 8);
		_btnExit.label.setFormat(null, 20, 0x4f3510, "center");		
		_btnExit.scale.x = 3;
		_btnExit.scale.y = 3;		
		_btnExit.x = (FlxG.width / 2 - 40);
		_btnExit.y = _btnPlay.y + 70;
		_btnExit.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		_btnExit.centerOffsets(false);
		add(_btnExit);
		
		
		super.create();
		
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		
		super.destroy();
		_btnPlay = FlxDestroyUtil.destroy(_btnPlay); 
		_txtTitle = FlxDestroyUtil.destroy(_txtTitle);
		_btnPlay = FlxDestroyUtil.destroy(_btnPlay);
		_btnOptions = FlxDestroyUtil.destroy(_btnOptions);
		_btnExit = FlxDestroyUtil.destroy(_btnExit);			
		_sprBackGround = FlxDestroyUtil.destroy(_sprBackGround);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
	}
	//function that change the state to Playstate when called
	private function clickPlay():Void
	{
		FlxG.switchState(new PlayState());
	}
	//function that change the state to OptionsState when called
	private function clickOptions():Void
	{
		FlxG.switchState(new OptionsState());
	}
	//exit the system when called	
	private function clickExit():Void
	 {
		System.exit(0);
	 }
	
	
	
	
}