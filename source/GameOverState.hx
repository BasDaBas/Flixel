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

class GameOverState extends FlxState
{
	private var _score:Int = 0;			// number of cards we've collected
	private var _win:Bool;				// if we won or lost	
	private var _sprScore:FlxSprite;	// sprite for a card icon
	private var _btnMainMenu:FlxButton;	// button to go to main menu
	private var _btnNextLevel:FlxButton; // button to go to the next level
	private var _txtScore:FlxText; //Text for the score (cards)
	private var _txtHiScore:FlxText; //Text for the high score (cards)
	static private var _level:Int = 1; // setting level on 1
	private var _sprBackGround:FlxSprite;//sprite used for the background
	private var _btnRestart:FlxButton; //button used for the restart function
	
	
	/**
	 * Called from PlayState, this will set our win and score variables
	 * @param	Win		true if the player beat the game, false if they died
	 * @param	Score	the number of cards collected
	 */
	public function new(Win:Bool, Score:Int) 
	{
		
		_win = Win;
		_score = Score;
		
		super();
	}
	
	override public function create():Void 
	{
		//brings the mouse back(if there is no mouse)
		#if !FLX_NO_MOUSE
		FlxG.mouse.visible = true;
		#end
		
		//setup the background		
		_sprBackGround = new FlxSprite(0, 0, _win ? AssetPaths.CompleteLevel__png: AssetPaths.GameOver__png);
		add(_sprBackGround);
		
		// create and add each of our items		
		_sprScore = new FlxSprite((FlxG.width / 2) + 20, 500, AssetPaths.card__png);		
		add(_sprScore);		
		
		_txtScore = new FlxText((FlxG.width / 2) - 20, _sprScore.y, 0, Std.string(_score), 32);
		_txtScore.color = 0x4f3510;
		add(_txtScore);
		
		// we want to see what the high score is
		var _hiScore = checkHiScore(_score);
		
		_txtHiScore = new FlxText((FlxG.width / 2) - 20, _txtScore.y + 120, 0 ,Std.string(_hiScore), 32);
		_txtHiScore.alignment = "center";
		_txtHiScore.color = 0x4f3510;
		add(_txtHiScore);
		
		//add Button for the main menu
		_btnMainMenu = new FlxButton(0, FlxG.height - 70, "", _win ?  goNextLevel: goMainMenu ); 
		_btnMainMenu.screenCenter(true, false);
		_btnMainMenu.label = new FlxText(0, 0, 0, _win ? "Next Level" : "Main Menu", 8); 
		_btnMainMenu.label.setFormat(null, 20, 0x333333, "center");	
		_btnMainMenu.scale.x = 3;
		_btnMainMenu.scale.y = 3;
		_btnMainMenu.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(_btnMainMenu);
		
		//add Button to restart the game and begin in level 1
		_btnRestart = new FlxButton(0, FlxG.height - 250, "", restart); 
		_btnRestart.screenCenter(true, false);
		_btnRestart.label = new FlxText(0, 0, 0,"Restart", 8); 
		_btnRestart.label.setFormat(null, 20, 0x333333, "center");	
		_btnRestart.scale.x = 3;
		_btnRestart.scale.y = 3;
		_btnRestart.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(_btnRestart);
		
			
		
		//Camera fade in or out
		FlxG.camera.fade(FlxColor.BLACK, .33, true);		
				
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
		
	/** Depending on if the players finished the game
	 *  goMainMenu: Brings the players back to the menu state
	 * 	goNextLevel: Brings the players to the next level
	 * 	GoNextLevel: Checks which level the players is and depending on that is loading the correct level.
	 * at the end of each if we set the level +1 and at the end back to 1.
	 */ 
	private function goMainMenu():Void
	{
		//destroy the music
		FlxG.sound.destroy;
		
		FlxG.camera.fade(FlxColor.BLACK, .33, false, function() {
			FlxG.switchState(new MenuState());
		});
		
	}	
	
		private function goNextLevel():Void
	{			
		
		if (_level == 1)
		{
			_level = 2;
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function() {
			FlxG.switchState(new Level2());		
			});	
			
			
		}
		else if (_level == 2)
		{
			_level = 3;
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function() {
			FlxG.switchState(new Level3());		
			});	
			
		}
		else if (_level == 3)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function() {
			FlxG.switchState(new Level4());		
			});
			_level = 1;
		}
		
		
	}	
	//function to restart the game
	private function restart():Void
	{
		_level = 1;
		FlxG.switchState(new PlayState());
		
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
		_btnRestart = FlxDestroyUtil.destroy(_btnRestart);
	}
}