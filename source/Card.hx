package;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Bas Benjamins
 */
class Card extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.card__png, false,25 , 38);
		
	}
	override public function kill():Void
	{
		alive = false;
		//FlxTween is a powerful tool that lets you animate an object's properties
		FlxTween.tween(this, { alpha:0, y:y - 16 }, .33, { ease:FlxEase.circOut, complete:finishKill } ); //make the cards fade out while also rising up.
	}
	
	private function finishKill(_):Void
	{
		exists = false;
	}
	
}