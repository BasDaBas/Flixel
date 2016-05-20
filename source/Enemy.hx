package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.math.FlxVelocity;
import flixel.system.FlxSound;

import flixel.util.FlxDestroyUtil;



using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Bas Benjamins
 */
class Enemy extends FlxSprite
{

	public var speed:Float = 280; //sets the speed to ...
    public var etype(default, null):Int; // use to figure out which enemy sprite to load, and which one we're dealing with
	private var _brain:FSM; //A finite-state machine
	private var _idleTmr:Float; //idle timer
	private var _moveDir:Float; // movement direction
	public var seesPlayer:Bool = false; //set seesplayer to false
	public var playerPos:FlxPoint; //storing the the point (x and y)
	private var _sndStep:FlxSound;// soundstep for the enemy
	
	
    public function new(X:Float=0, Y:Float=0, EType:Int)
    {
        super(X, Y);
        etype = EType;
        loadGraphic("assets/images/enemy-" + Std.string(etype) + ".png", true, 54, 54);
        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);
        animation.add("d", [0, 1, 0, 2], 6, false);
        animation.add("lr", [3, 4, 3, 5], 6, false);
        animation.add("u", [6, 7, 6, 8], 6, false);
        drag.x = drag.y = 10;
        width = 27;
        height = 52;
        offset.x = 4;
        offset.y = 2;
		_brain = new FSM(idle);
		_idleTmr = 0;
		playerPos = FlxPoint.get();
		
		//setting the volume to .4 (40%), then we setup our proximity for our sounds, setting it's position to the x and y of this enemy,
		//and telling it to target the FlxG.camera.target object(Player)
		//the radius of our footstep sound is a little bit more than half of the screen's width - so we should be able to hear enemies that are just off the screen
		_sndStep = FlxG.sound.load(AssetPaths.step__wav,0);
		_sndStep.proximity(x,y,FlxG.camera.target, FlxG.width *.6);
    }

	override public function draw():Void
	{
		if ((velocity.x != 0 || velocity.y != 0 ) && touching == FlxObject.NONE)
		{
			if (Math.abs(velocity.x) > Math.abs(velocity.y))
			{
				if (velocity.x < 0)
					facing = FlxObject.LEFT;
				else
					facing = FlxObject.RIGHT;
			}
			else
			{
				if (velocity.y < 0)
					 facing = FlxObject.UP;
				else
					facing = FlxObject.DOWN;
			}
			switch (facing)
			{
				case FlxObject.LEFT, FlxObject.RIGHT:
					animation.play("lr");
					
				case FlxObject.UP:
					animation.play("u");

				case FlxObject.DOWN:
					animation.play("d");
			}
		}
		super.draw();
	}
	
	//setup what the enemy has to do(when see the enemy - chase. / when see no enemy - idle)
	//While in the Idle state, every so often (in random intervals) it will choose a random direction to 
	//move in for a little while (with a small chance to just stand still). 
	
	public function idle():Void
	{
		if (seesPlayer)
		{
			_brain.activateState = chase;
		}
		else if (_idleTmr <= 0)
		{
			if (FlxRandom.chanceRoll(1))
			{
				_moveDir = -1;
				velocity.x = velocity.y = 0;
			}
			else
			{
				_moveDir = FlxRandom.intRanged(0, 8) * 45;
				FlxAngle.rotatePoint(speed * .5, 0, 0, 0, _moveDir, velocity);
			}
			_idleTmr = FlxRandom.intRanged(1, 4);
		}
		else 
			_idleTmr -= FlxG.elapsed;
	}
	//looking if the enemy is seeing the target(player)
	//In the Chase state, they will move directly towards the player.
	public function chase():Void
	{
		if (!seesPlayer)// if enemy doesn't see player - Idle
		{
			_brain.activateState = idle; 
		}
		else // enemy chase target
		{
			FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
		}
	}
	
	//updates all the functions in this function
	override public function update ():Void
	{
		_brain.update();		
		
		super.update();
		
		//check if the enemy is moving and not bumping into a wall
		if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
		{
			//If they are moving, we set the position of our sound to wherever our enemy is
			_sndStep.setPosition(x + _halfWidth, y + height);
			_sndStep.play();
		}		
	}
	
	// clean up all our objects!
	override public function destroy():Void
	{
		_sndStep = FlxDestroyUtil.destroy(_sndStep);
		super.destroy();
	}
	
	
	
	

	
}