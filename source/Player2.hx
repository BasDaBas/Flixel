package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxAngle;
import flixel.system.FlxSound;

import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;


/**
 * ...
 * @author Bas Benjamins
 */
class Player2 extends FlxSprite
{
	public var speed:Float = 350;
	private var _sndStep:FlxSound;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		//This tells your sprite to use the player.png graphic, that it's animated, and that each frame is 16x16 pixels
		loadGraphic(AssetPaths.player1__png, true, 54, 54);
		//sort of a way to slow down an object when it's not being moved.
		drag.x = drag.y = 1600;
		//change the player sprite size and offsets to make the player move easier trough 1 tile wide doorways
		setSize(30, 50);
		offset.set(4, 2);
		//Saying that we don't want to flip anything when facing Left
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		//define the animations,this will make the animation return to the correct frams as soon as they stop animating
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		
		//set sound for the footsteps
		_sndStep = FlxG.sound.load(AssetPaths.step__wav);
		
		
	}
	//function that updates every frame
	override public function update():Void 
	{
		movement();
		super.update();
	}
	//function that destroys objects
	override public function destroy():Void
	{
		_sndStep = FlxDestroyUtil.destroy(_sndStep);
		super.destroy();
	}
	
	private function movement():Void
	{
		//define some helper variables so we can easily tell which keys were pressed later on in the function
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		
		//checking if certain keys are being pressed
		_up = FlxG.keys.anyPressed(["W"]);
		_down = FlxG.keys.anyPressed(["S"]);
		_left = FlxG.keys.anyPressed(["A"]);
		_right = FlxG.keys.anyPressed(["D"]);
		
		//cancel out opposing directions. if the player is pressing Up and Down at the same time, we're not going to move anywhere:
		if (_up && _down)	
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;		
		
		if (_up || _down || _left || _right)
		{
			//create a temporary variable to hold our angle, and then, based on which direction(s) the player is pressing, set that angle to the direction we plan on moving the player.
			var mA:Float = 0; // our temporary angle
			if (_up) // the player is pressing UP
			{
				mA = -90; // set our angle to -90 (12 o' clock)
				if (_left)
					mA -= 45; //if the player is also pressing LEFT, subtract 45 degrees from our angle - we're moving up and left
				else if (_right)
					mA += 45; // similarly, if the player is pressing RIGHT, add 45 degrees (up and right)
				facing = FlxObject.UP; // the sprite should be facing UP
			}
			else if (_down) // the player is pressing DOWN
			{
				mA = 90; // set our angle to 90 (6 o'clock)
				if (_left)
					mA += 45; // add 45 degrees if the player is also pressing LEFT
				 else if (_right)
					mA -= 45; // or subtract 45 if they are pressing RIGHT
				facing = FlxObject.DOWN; // the sprite is facing DOWN
			}
			else if (_left) // if the player is not pressing UP or DOWN, but they are pressing LEFT
			{	
				mA = 180;
				facing = FlxObject.LEFT; // the sprite should be facing LEFT
			}
			else if (_right) // the player is not pressing UP, DOWN, or LEFT, and they ARE pressing RIGHT			
			{
				mA = 0; // set our angle to 0 (3 o'clock)
				facing = FlxObject.RIGHT; // set the sprite's facing to RIGHT
			}			
			FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity); // determine our velocity based on angle and speed
			if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) // if the player is moving (velocity is not 0 for either axis), we need to change the animation to match their facing
			{
				_sndStep.play();
				switch (facing)
				{
					case FlxObject.LEFT, FlxObject.RIGHT: animation.play("lr");
					case FlxObject.UP: animation.play("u");
					case FlxObject.DOWN: animation.play("d");
				}
			}
		}
		
	}
	

	
}