package;
import flixel.group.FlxGroup.FlxTypedGroup;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Bas Benjamins
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
	private var _sprBack:FlxSprite;
	private var _txtHealth:FlxText;
	private var _txtHealth2:FlxText;
	private var _txtCard:FlxText;
    private var _sprHealth:FlxSprite;
	private var _sprHealth2:FlxSprite;
    private var _sprCard:FlxSprite;
	private var _txtPlayer1:FlxText;
	private var _txtPlayer2:FlxText;
	
	
	
	
	public function new() 
	{
		super();
		
		//setup the Health Text Player 1
		_txtHealth = new FlxText(50, 50, 0, "3 / 3", 24);
		_txtHealth.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
		//setup the Health Text Player 2
		_txtHealth2 = new FlxText(FlxG.width - 95, _txtHealth.y, 0, "3 / 3", 24);
		_txtHealth2.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
		//setup the Health Sprite for player 1 (icon)
		_sprHealth = new FlxSprite(_txtHealth.x - 25, _txtHealth.y + 10, AssetPaths.health__png);
		_sprHealth.scale.x = 1.5;
		_sprHealth.scale.y = 1.5;
		//setup the Health Sprite for player 2 (icon)
		_sprHealth2 = new FlxSprite(_txtHealth2.x - 25, _txtHealth2.y + 10 , AssetPaths.health__png);
		_sprHealth2.scale.x = 1.5;
		_sprHealth2.scale.y = 1.5;
		//setup the Money Text
		_txtCard = new FlxText(55, _txtHealth.y + 40, 0, "0", 24);
        _txtCard.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);		
		//setup the Money Sprite (icon)
		_sprCard = new FlxSprite(_txtCard.x - 40, _txtHealth.y + 40, AssetPaths.card__png);
		//setup player 1 and 2 text
		_txtPlayer1 = new FlxText(_txtHealth.x- 20, _txtHealth.y - 30, 0, "Player 1", 24);
		_txtPlayer1.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
		_txtPlayer2 = new FlxText(_txtHealth2.x - 50, _txtHealth2.y - 30, 0, "Player 2", 24);
		_txtPlayer2.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
		
		
		
		
        
        
		add(_sprBack);
        add(_sprHealth);
		add(_sprHealth2);
        add(_sprCard);
        add(_txtHealth);
		add(_txtHealth2);
        add(_txtCard);
		add(_txtPlayer1);
		add(_txtPlayer2);
		
        
		//we use this to iterate through each of the items in this group, and it just sets their scrollFactor.x and scrollFactor.y to 0, 
		//meaning, even if the camera scrolls, all of these items will stay at the same position relative to the screen.
		forEach(function(spr:FlxSprite) 
		{
            spr.scrollFactor.set();
        });
	}
	
	//updates the HUD for palyer1 (health and money)
	public function updateHUD(Health:Int = 0, Money:Int = 0):Void
    {
        _txtHealth.text = Std.string(Health) + " / 3";
        _txtCard.text = Std.string(Money);    
		
		
    }
	//updates the HUD for player 2 (health and money)
	public function updateHUD2(Health:Int = 0, Money:Int = 0):Void
    {
        _txtHealth2.text = Std.string(Health) + " / 3";
        _txtCard.text = Std.string(Money);
       
		
    }
	
	

	
}