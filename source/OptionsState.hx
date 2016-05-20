package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSave;
using flixel.util.FlxSpriteUtil;

class OptionsState extends FlxState
{
	// define our screen elements
	private var _txtTitle:FlxText;
	private var _barVolume:FlxBar;
	private var _txtVolume:FlxText;
	private var _txtVolumeAmt:FlxText;
	private var _btnVolumeDown:FlxButton;
	private var _btnVolumeUp:FlxButton;
	private var _btnClearData:FlxButton;
	private var _btnBack:FlxButton;
	private var _sprBackGround:FlxSprite;
	#if desktop
	private var _btnFullScreen:FlxButton;
	#end	
	private var _save:FlxSave; // a save object for saving settings
	
	override public function create():Void 
	{
		//setup the background		
		_sprBackGround = new FlxSprite(0, 0, AssetPaths.OptionsMenu__png);
		add(_sprBackGround);		
	
		
		//setup the buttons + bar
		_btnVolumeDown = new FlxButton(410,500, "-", clickVolumeDown);
		_btnVolumeDown.loadGraphic(AssetPaths.button__png, true, 20,20);
		_btnVolumeDown.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);	
		_btnVolumeDown.scale.x = 2;
		_btnVolumeDown.scale.y = 2;
		
		add(_btnVolumeDown);
		
		_btnVolumeUp = new FlxButton(FlxG.width - 500, _btnVolumeDown.y, "+", clickVolumeUp);
		_btnVolumeUp.loadGraphic(AssetPaths.button__png, true, 20,20);
		_btnVolumeUp.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		_btnVolumeUp.scale.x = 2;
		_btnVolumeUp.scale.y = 2;
		add(_btnVolumeUp);
		
		_barVolume = new FlxBar(0,500, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(FlxG.width - 64), Std.int(_btnVolumeUp.height));
		_barVolume.createFilledBar(FlxColor.CHARCOAL, FlxColor.WHITE, true, FlxColor.WHITE);
		_barVolume.screenCenter;
		_barVolume.scale.x = 0.5;
		_barVolume.scale.y = 2;
		add(_barVolume);
		
		_txtVolumeAmt = new FlxText(0, 0, 200, Std.string( FlxG.sound.volume * 100) + "%", 8);
		_txtVolumeAmt.alignment = "center";
		_txtVolumeAmt.borderStyle = FlxText.BORDER_OUTLINE;
		_txtVolumeAmt.borderColor = FlxColor.CHARCOAL;
		_txtVolumeAmt.y = _barVolume.y + (_barVolume.height / 2) - (_txtVolumeAmt.height / 2);
		_txtVolumeAmt.screenCenter(true, false);
		add(_txtVolumeAmt);
		
		#if desktop
		_btnFullScreen = new FlxButton(0, _barVolume.y + _barVolume.height + 80, FlxG.fullscreen ? "FULLSCREEN" : "WINDOWED", clickFullscreen);
		_btnFullScreen.screenCenter(true, false);
		_btnFullScreen.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		_btnFullScreen.label = new FlxText(0, 0, 0, FlxG.fullscreen ? "FULLSCREEN" : "WINDOWED");
		_btnFullScreen.label.setFormat(null, 20, 0x4f3510, "left");		
		_btnFullScreen.scale.x = 3;
		_btnFullScreen.scale.y = 3;
		add(_btnFullScreen);
		#end
		
		_btnClearData = new FlxButton((FlxG.width / 2) - 190, FlxG.height - 58, "", clickClearData);
		_btnClearData.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		_btnClearData.label = new FlxText(0, 0, 0, "Clear Data");
		_btnClearData.label.setFormat(null, 20, 0x4f3510, "center");		
		_btnClearData.scale.x = 3;
		_btnClearData.scale.y = 3;
		add(_btnClearData);
		
		_btnBack = new FlxButton((FlxG.width/2)+100, FlxG.height-58, "", clickBack);
		_btnBack.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		_btnBack.label = new FlxText(0, 0, 0, "Back");
		_btnBack.label.setFormat(null, 20, 0x4f3510, "center");
		_btnBack.scale.y = 3;
		_btnBack.scale.x = 3;
		add(_btnBack);
		
		// create and bind our save object to "flixel-tutorial"
		_save = new FlxSave();
		_save.bind("flixel-tutorial");
		
		// update our bar to show the current volume level
		updateVolume();
		//Camera fade in or out
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		
		super.create();
	}
	
	#if desktop
	private function clickFullscreen():Void
	{
		FlxG.fullscreen = !FlxG.fullscreen;
		_btnFullScreen.text = FlxG.fullscreen ? "FULLSCREEN" : "WINDOWED";
		_save.data.fullscreen = FlxG.fullscreen;
	}
	#end
	
	/**
	 * The user wants to clear the saved data - we just call erase on our save object and then reset the volume to .5
	 */
	private function clickClearData():Void
	{
		_save.erase();
		FlxG.sound.volume = .5;
		updateVolume();
	}
	
	/**
	 * The user clicked the back button - close our save object, and go back to the MenuState
	 */
	private function clickBack():Void
	{
		_save.close();
		FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new MenuState());
		});
	}
	
	/**
	 * The user clicked the down button for volume - we reduce the volume by 10% and update the bar
	 */
	private function clickVolumeDown():Void
	{
		FlxG.sound.volume -= 0.1;
		_save.data.volume = FlxG.sound.volume;
		updateVolume();
	}
	
	/**
	 * The user clicked the up button for volume - we increase the volume by 10% and update the bar
	 */
	private function clickVolumeUp():Void
	{
		FlxG.sound.volume += 0.1;
		_save.data.volume = FlxG.sound.volume;
		updateVolume();
	}
	
	/**
	 * Whenever we want to show the value of volume, we call this to change the bar and the amount text
	 */
	private function updateVolume():Void
	{
		var vol:Int = Math.round(FlxG.sound.volume * 100);
		_barVolume.currentValue = vol;
		_barVolume.value.
		_txtVolumeAmt.text = Std.string(vol) + "%";
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		
		// cleanup all our objects!
		_txtVolumeAmt = FlxDestroyUtil.destroy(_txtVolumeAmt);
		_btnVolumeDown = FlxDestroyUtil.destroy(_btnVolumeDown);
		_btnVolumeUp = FlxDestroyUtil.destroy(_btnVolumeUp);
		_btnClearData = FlxDestroyUtil.destroy(_btnClearData);
		_btnBack = FlxDestroyUtil.destroy(_btnBack);
		_sprBackGround = FlxDestroyUtil.destroy(_sprBackGround);
		_save.destroy();
		_save = null;
		#if desktop
		_btnFullScreen = FlxDestroyUtil.destroy(_btnFullScreen);
		#end
	}
}