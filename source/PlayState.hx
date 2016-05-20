package;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;




/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
 
{	
	private var _player1:Player1; // creates player 1
	private var _player2:Player2;// creates player 2
	private var _map:FlxOgmoLoader; //creates the map 
	private var _mWalls:FlxTilemap; //creates walls  vlgensmij kan ik dan iets met die _won ? doen net als 
	private var _mObjects:FlxTilemap; //creates objects
	private var _grpCards:FlxTypedGroup<Card>; //makes a FlxGroup in our PlayState to hold our Cards
	private var _grpEnemies:FlxTypedGroup<Enemy>; //makes a FlxGroup in our PlayState to hold our Enemies
	private var _hud:HUD; // 
	private var _cards:Int = 0; // sets cards to 0
	private var _healthPlayer1:Int = 3; // sets lives to 25
	private var _healthPlayer2:Int = 3; // sets lives to 25
	private var _ending:Bool;
	private var _won:Bool;
	private var _sndCard:FlxSound; // sound for the Card
	private var _sndLose:FlxSound; // sound for when the players loses
	private var _sndWin:FlxSound;// sound for when the players wins
	private var _tmrBuff:FlxTimer;// Timer for the buffs
	private var _tmrHit:FlxTimer;	
	private var _player1Pos:FlxPoint;
	private var _player2Pos:FlxPoint;
	private var _timeleft:String;
	private var _tmrGame:FlxTimer;
	private var _txtTimer:FlxText;
	private var _time:Int;
	private var _mscGame:FlxSound;	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		//setup the map
		_map = new FlxOgmoLoader(AssetPaths.room_002__oel);	// setup level
		_mWalls = _map.loadTilemap(AssetPaths.tiles3__png, 54, 54, "walls");	//setup tiles	
		_mWalls.setTileProperties(0, FlxObject.ANY);	//set tile  to ANY collide
		_mWalls.setTileProperties(1, FlxObject.ANY);	//set tile  to ANY collide
		_mWalls.setTileProperties(2, FlxObject.ANY);	//set tile  to ANY collide
		_mWalls.setTileProperties(3, FlxObject.ANY);	//set tile  to NONE collide
		_mWalls.setTileProperties(4, FlxObject.NONE);	//set tile  to NONE collide 
		_mWalls.setTileProperties(5, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(6, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(7, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(8, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(9, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(10, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(11, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(12, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(13, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(14, FlxObject.NONE);	//set tile  to NONE collide (Floor Tile)
		_mWalls.setTileProperties(15, FlxObject.NONE);	//set tile  to NONE collide 
		_mWalls.setTileProperties(16, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(17, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(18, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(19, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(20, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(21, FlxObject.ANY);	//set tile  to ANY collide
		_mWalls.setTileProperties(22, FlxObject.ANY);	//set tile  to ANY collide
		_mWalls.setTileProperties(23, FlxObject.ANY);	//set tile  to ANY collide 
		_mWalls.setTileProperties(24, FlxObject.ANY);	//set tile  to ANY collide
		_mWalls.setTileProperties(25, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(26, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(27, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(28, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(29, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(30, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(32, FlxObject.NONE);	//set tile  to NONE collide 
		_mWalls.setTileProperties(33, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(34, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(35, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(36, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(37, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(38, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(39, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(40, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(41, FlxObject.NONE);	//set tile  to NONE collide		
		_mWalls.setTileProperties(42, FlxObject.NONE);	//set tile  to NONE collide 
		_mWalls.setTileProperties(43, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(44, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(45, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(46, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(47, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(48, FlxObject.NONE);	//set tile  to NONE collide
		_mWalls.setTileProperties(49, FlxObject.ANY);	//set tile  to NONE collide		
		add(_mWalls);
		
		//setup Objects Layer in OGMO Editor
		_mObjects = _map.loadTilemap(AssetPaths.tiles3__png, 54, 54, "objects");
		_mObjects.setTileProperties(2, FlxObject.ANY);	
		_mObjects.setTileProperties(53, FlxObject.NONE);	
		_mObjects.setTileProperties(54, FlxObject.NONE);	
		_mObjects.setTileProperties(55, FlxObject.NONE);	
		_mObjects.setTileProperties(60, FlxObject.NONE);	
		_mObjects.setTileProperties(61, FlxObject.NONE);	
		_mObjects.setTileProperties(62, FlxObject.NONE);	
		_mObjects.setTileProperties(67, FlxObject.NONE);	
		_mObjects.setTileProperties(68, FlxObject.NONE);	
		_mObjects.setTileProperties(69, FlxObject.NONE);	
		add(_mObjects);		
		
		//setup timer
		_tmrGame = new FlxTimer(30, gameTimer, 1);		
		_timeleft = Std.string(Math.ceil(_tmrGame.timeLeft));
		_txtTimer = new FlxText(FlxG.width / 2 - 150, 40, 0, _timeleft, 28);
		_txtTimer.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);		
		add(_txtTimer);		
		//setup cards
		_grpCards = new FlxTypedGroup<Card>();
		add(_grpCards);
		//setup enemy
		_grpEnemies = new FlxTypedGroup<Enemy>();
		add(_grpEnemies);
		//setup player
		_player1 = new Player1();	
		_player2 = new Player2();
		_map.loadEntities(placeEntities, "entities");
		//add Players
		add(_player1);
		add(_player2);
		//adds HUD
		_hud = new HUD();
		add(_hud);	_grpCards;
		//adds the sound
		_sndCard = FlxG.sound.load(AssetPaths.card__wav,0.5);
		_sndLose = FlxG.sound.load(AssetPaths.lose__wav);
		_sndWin = FlxG.sound.load(AssetPaths.win__wav);
		//setup background music	
		FlxG.sound.destroy;
		FlxG.sound.playMusic(AssetPaths.soundtracklevel4__wav, 1, true);
		//Camera fade in or out
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		//hides the mouse while playing
		#if !FLX_NO_MOUSE
		FlxG.mouse.visible = false;
		#end
		
		super.create();
	}
	
	//when this function gets passed an entity with the name "", will set our object's x and y values to the Entities x and y values (converting them from Strings to Ints).
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		//creates a player on the position based on the Ogmo entity
		if (entityName == "player")
		{
			_player1.x = x;
			_player1.y = y;
		}
		else if (entityName == "playersecond")
		{
			_player2.x = x;
			_player2.y = y;				
		}
		else if (entityName == "cards")
		{
			_grpCards.add(new Card(x + 15, y + 10)); // creates a new card (because the card is smaller I add + ... to center it
		}
		else if (entityName == "enemy")
		{
			_grpEnemies.add(new Enemy(x, y, Std.parseInt(entityData.get("etype")))); // creates a new enemy 
			
		}		
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();	
		
		_mWalls = FlxDestroyUtil.destroy(_mWalls);
		_mObjects = FlxDestroyUtil.destroy(_mObjects);
		_txtTimer = FlxDestroyUtil.destroy(_txtTimer);
		_grpCards = FlxDestroyUtil.destroy(_grpCards);
		_grpEnemies = FlxDestroyUtil.destroy(_grpEnemies);
		_hud = FlxDestroyUtil.destroy(_hud);
		_sndCard = FlxDestroyUtil.destroy(_sndCard);
		_sndLose = FlxDestroyUtil.destroy(_sndLose);		
		_player1 = FlxDestroyUtil.destroy(_player1);
		_player2 = FlxDestroyUtil.destroy(_player2);		
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		FlxG.collide(_player1, _mWalls); //check collision between our player and our walls
		FlxG.collide(_player2, _mWalls); //check collision between our player and our walls
		FlxG.collide(_player1, _mObjects); //check collision between our player and our objects
		FlxG.collide(_player2, _mObjects); //check collision between our player and our objects
		FlxG.overlap(_player1, _grpCards, player1TouchCard);// when the player hits the card, get 1 card and remove it from the level
		FlxG.overlap(_player2, _grpCards, player2TouchCard);// when the player hits the card, get 1 card and remove it from the level
		FlxG.collide(_grpEnemies, _mWalls);  //check collision between our enemy and our walls
		FlxG.collide(_grpEnemies, _mObjects);	//check collision between our enemy and our objects
		_grpEnemies.forEachAlive(checkEnemyVision);	//enemy checks if he sees players
		_grpEnemies.forEachAlive(checkClosestPlayer); //enemy checks which player is closest
		FlxG.overlap(_player1, _grpEnemies, player1TouchEnemy);//when a enemy hits the player, lose 1 life
		FlxG.overlap(_player2, _grpEnemies, player2TouchEnemy);//when a enemy hits the player, lose 1 life
		
		updateHUD();//update the time
		
		if (FlxG.keys.pressed.R)
		{
			restart();
		}			
		//checks if all the cards are collected and goes to the GameOverState  
		if (_cards == 20)
		{
			_sndWin.play();
			_won = true;
			_ending = true;
			FlxG.camera.fade(FlxColor.BLACK, .33, false, doneFadeOut);
		}			
		//when player has no lifes left go to GameOverState 
		if (_healthPlayer1 <= 0 || _healthPlayer2 <= 0) 
		{
			_sndLose.play();			
			_ending = true;
			FlxG.camera.fade(FlxColor.BLACK, .33, false, doneFadeOut);
		}
		else			
		{	
			_player1.active = true;
			_player2.active = true;
			_grpEnemies.active = true;	
		}			
	}
	//This function simply verifies that the player and the card that overlap each other are both alive and exist, and if so, kill the card 
	private function player1TouchCard(P:Player1, C:Card):Void
	{
		if (P.alive && P.exists && C.alive && C.exists)
		{
			C.kill();
			_cards++; //adds +1 to the cards
			_hud.updateHUD(_healthPlayer1, _cards); //updates the HUD so you can see it
			_sndCard.play(true);//plays sound whenever you pickup a card
			if (_player1.speed == 350)
			{
				_player1.speed = _player1.speed + 50; // increase the speed by 50
				_tmrBuff = new FlxTimer(2, SpeedBuff1, 1); // after 2 sec call the function speedbuff, which set the speed back to normal
			}
			
		}	
	}
	
		private function player2TouchCard(P:Player2, C:Card):Void
	{
		if (P.alive && P.exists && C.alive && C.exists)
		{
			C.kill();
			_cards++; //adds +1 to the cards
			_hud.updateHUD(_healthPlayer2, _cards); //updates the HUD so you can see it
			_sndCard.play(true);//plays sound whenever you pickup a card
			if (_player2.speed == 350)
			{
				_player2.speed = _player2.speed + 50; // increase the speed by 50
				_tmrBuff = new FlxTimer(2, SpeedBuff2, 1); // after 2 sec call the function speedbuff, which set the speed back to normal
			}
			
			
		}	
	}
	
	/**checks the distance from the enemy to player 1 and player 2 and changes e.PlayerPos to the closest player
	* _distanceToPlayer is using the Pythagorean theorem to calculate the distance
	* the if fucntion is checking if player1 distance is less than player2 distance
	* if it is player1, the Enemy will chase e.playerPos which is player 1
	* else it will be player2
	*/	
	private function checkClosestPlayer(e:Enemy):Void 
	{
		_player1Pos = _player1.getMidpoint();
		_player2Pos = _player2.getMidpoint();		
		
		var _distanceToPlayer1 = Math.sqrt(Math.pow((Math.abs(_player1Pos.x - e.x)),2) + Math.pow((Math.abs(_player1Pos.y - e.y)),2));
		var _distanceToPlayer2 = Math.sqrt(Math.pow((Math.abs(_player2Pos.x - e.x)),2) + Math.pow((Math.abs(_player2Pos.y - e.y)),2));
		
		if (_distanceToPlayer1 < _distanceToPlayer2)
		{
			e.playerPos = _player1Pos;
		}
		else
		{
			e.playerPos = _player2Pos;			
		}
				
	}
	
	//this functions checks if the enemies sees the player
	private function checkEnemyVision(e:Enemy):Void  
	{
		if (_mWalls.ray(e.getMidpoint(), _player1.getMidpoint())|| _mWalls.ray(e.getMidpoint(), _player2.getMidpoint()))
		{
			e.seesPlayer = true;			
		}
		else
		{
			e.seesPlayer = false;
		}
	}
	
	
	
	//if the player touches an enemy - loseLife
	private function player1TouchEnemy(P:Player1, E:Enemy):Void
	{
		
		
		if (P.alive && P.exists && E.alive && E.exists && !P.isFlickering() && _healthPlayer1 >= 1)
		{
			
			_healthPlayer1--;// player 1 lose 1 live
			FlxG.camera.shake(0.01, 0.2);//shakes the camera
			_hud.updateHUD(_healthPlayer1, _cards); //updates the HUD so you can see it
			P.flicker(2, 0.1, true, true);			
		}
	}
	
	//if the player touches an enemy - loseLife
	private function player2TouchEnemy(P:Player2, E:Enemy):Void
	{
		if (P.alive && P.exists && E.alive && E.exists && !P.isFlickering() && _healthPlayer2 >= 1)
		{
			
			_healthPlayer2--;//player 2 lose 1 live
			FlxG.camera.shake(0.01, 0.2);//shakes the camera
			_hud.updateHUD2(_healthPlayer2, _cards); //updates the HUD so you can see it
			P.flicker(2, 0.1, true, true);	 
			
		}
	}
	
	/**function that change the state to GameOverState when called.
	* takes the var _cards to the GameOverState so it can be tracked there
	*/ 	
	private function doneFadeOut():Void 
	{
		FlxG.switchState(new GameOverState(_won,_cards));		
	}
	// set the speed of the player back to normal (350)
	private function SpeedBuff1(Timer:FlxTimer):Void
	{
		_player1.speed = 350;
	}
	// set the speed of the player back to normal (350)
	private function SpeedBuff2(Timer:FlxTimer):Void
	{
		_player2.speed = 350;
	}
	
	//function that restarts the game when called
	public function gameTimer(Timer:FlxTimer):Void
	{
		_sndLose.play();
		_ending = true;
		FlxG.camera.fade(FlxColor.BLACK, .33, false, doneFadeOut);
	}
	//function that updates the time when called
	public function updateHUD()
    {
		_timeleft = Std.string(Math.ceil(_tmrGame.timeLeft));
		_txtTimer.text = _timeleft;	
    }
	//function that switch the state to play state when called
	private function restart():Void
	{
		FlxG.switchState(new PlayState());
	}
}