package;

/**
 * ...
 * @author Bas Benjamins
 */
class FSM
{	
	public var activateState:Void ->Void;
	
	//giving the enemies 2 states(idle and chase)
	public function new(?Initstate:Void->Void):Void 
	{
		activateState = Initstate;
	}
	
	public function update():Void
	{
		if (activateState != null)
		activateState();
	}
	
}