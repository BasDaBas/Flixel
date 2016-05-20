package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSave;
using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Bas Benjamins
 */

class FinishedGame extends FlxState
{
	private var _score:Int = 0;			// number of cards we've collected
	private var _sprScore:FlxSprite;	// sprite for a card icon
	private var _btnMainMenu:FlxButton;	// button to go to main menu
	private var _btnNextLevel:FlxButton; // button to go to the next level
	private var _txtScore:FlxText;
	private var _txtHiScore:FlxText;
	private var _sprBackGround:FlxSprite;
	
	
	/**
	 * Called from PlayState, this will set our score variables
	 * @param	Score the number of cards collected
	 */
	
	public function new(Score:Int) 
	{
		_score = Score;
		
		super();
	}
	override public function create():Void 
	{
		
		#if !FLX_NO_MOUSE
		FlxG.mouse.visible = true;
		#end
		
		//setup the background		
		_sprBackGround = new FlxSprite(0, 0,AssetPaths.FinalScreen__png);
		add(_sprBackGround);
		
		// create and add each of our items		
		_sprScore = new FlxSprite((FlxG.width / 2) + 20, 500, AssetPaths.card__png);		
		add(_sprScore);
		
		_txtScore = new FlxText((FlxG.width / 2) - 20, _sprScore.y, 0, Std.string(_score), 32);
		_txtScore.color = 0x4f3510;
		add(_txtScore);
		
		// we want to see what the hi-score is
		var _hiScore = checkHiScore(_score);
		
		_txtHiScore = new FlxText((FlxG.width / 2) - 20, _txtScore.y + 120, 0 ,Std.string(_hiScore), 32);
		_txtHiScore.alignment = "center";
		_txtHiScore.color = 0x4f3510;
		add(_txtHiScore);
		
		_btnMainMenu = new FlxButton(0, FlxG.height - 70, "", goMainMenu ); 
		_btnMainMenu.screenCenter(true, false);
		_btnMainMenu.label = new FlxText(0, 0, 0,"Main Menu", 8); 
		_btnMainMenu.label.setFormat(null, 20, 0x4f3510, "center");	
		_btnMainMenu.scale.x = 3;
		_btnMainMenu.scale.y = 3;
		_btnMainMenu.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(_btnMainMenu);
		
		
		
		
		
		
		
		//Camera fade in or out
		FlxG.camera.fade(FlxColor.BLACK, .33, true);		
		//shows the mouse while not playing
		#if !FLX_NO_MOUSE
		FlxG.mouse.visible = true;
		#end
		
		super.create();
	}
	
	/**
	 * This function will compare the new score with the saved hi-score. 
	 * If the new score is higher, it will save it as the new hi-score, otherwise, it will return the saved hi-score.
	 * @param	Score	The new score
	 * @return	the hi-score
	 */
	private function checkHiScore(Score:Int):Int
	{
		var _hi:Int = Score;
		var _save:FlxSave = new FlxSave();
		if (_save.bind("flixel-tutorial"))
		{
			if (_save.data.hiscore != null)
			{
				if (_save.data.hiscore > _hi)
				{
					_hi = _save.data.hiscore;
				}
				else
				{
					_save.data.hiscore = _hi;
				}
			}
		}
		_save.close();
		return _hi;
	}
	
	
	//When the user hits the main menu button, it should fade out and then take them back to the MenuState
	 
	private function goMainMenu():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, function() {
			FlxG.switchState(new MenuState());
		});
	}	
	

	
	override public function destroy():Void 
	{
		super.destroy();
		
		// clean up all our objects!		
		_sprScore = FlxDestroyUtil.destroy(_sprScore);
		_txtScore = FlxDestroyUtil.destroy(_txtScore);
		_btnMainMenu = FlxDestroyUtil.destroy(_btnMainMenu);
		_btnNextLevel = FlxDestroyUtil.destroy(_btnNextLevel);
		_sprBackGround = FlxDestroyUtil.destroy(_sprBackGround);
		_txtScore = FlxDestroyUtil.destroy(_txtScore);
		_txtHiScore = FlxDestroyUtil.destroy(_txtHiScore);
	}
}