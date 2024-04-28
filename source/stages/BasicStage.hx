package stages;

// import flixel.FlxBasic;
import flixel.math.FlxPoint;

/**
	This is the base class for stages. 
	When making your own stage make a new class extending this one.    
	@author Rozebud
**/
class BasicStage
{
	public var name:String;
	public var cameraStartPosition:FlxPoint; // Leave null for PlayState default.

	public var backgroundElements:Array<Dynamic> = [];
	public var middleElements:Array<Dynamic> = [];
	public var foregroundElements:Array<Dynamic> = [];

	/**
	 * Do not override this function, override `init()` instead.
	 */
	public function new()
	{
		init();
	}

	/**
	 * Override this function to initialize all of your stage elements.
	 */
	function init()
	{
	}

	/**
	 * Adds an object to `backgroundElements` to be added to PlayState.
	 *
	 * @param   x  The object to add. Should be any type that can be added to a state.
	 */
	public function addToBackground(x:Dynamic)
	{
		backgroundElements.push(x);
	}

	/**
	 * Adds an object to `middleElements` to be added to PlayState.
	 *
	 * @param   x  The object to add. Should be any type that can be added to a state.
	 */
	public function addToMiddle(x:Dynamic)
	{
		middleElements.push(x);
	}

	/**
	 * Adds an object to `foregroundElements` to be added to PlayState.
	 *
	 * @param   x  The object to add. Should be any type that can be added to a state.
	 */
	public function addToForeground(x:Dynamic)
	{
		foregroundElements.push(x);
	}

	/**
	 * Destroys all objects added to the stage elements.
	 */
	public function destroyAll()
	{
		for (x in backgroundElements)
		{
			x.destroy();
		}
		for (x in middleElements)
		{
			x.destroy();
		}
		for (x in foregroundElements)
		{
			x.destroy();
		}
	}

	/**
	 * Called every frame in PlayState update.
	 *
	 * @param   elapsed  The elapsed time between previous frames passed in by PlayState.
	 */
	public function update(elapsed:Float)
	{
	}

	/**
	 * Called every beat hit in PlayState.
	 *
	 * @param   curBeat  The current song beat passed in by PlayState.
	 */
	public function beat(curBeat:Int)
	{
	}

	/**
	 * Called every step hit in PlayState.
	 *
	 * @param   curStep  The current song step passed in by PlayState.
	 */
	public function step(curStep:Int)
	{
	}

	/**
	 * Called every event in PlayState.
	 *
	 * @param   eventName	The name of the event passed in by PlayState.
	 * @param   value1		The first value of the event passed in by PlayState.
	 * @param   value2		The second value of the event passed in by PlayState.
	 */
	public function triggerEventNote(eventName:String, value1:String, value2:String)
	{
	}

	inline function boyfriend()
	{
		return PlayState.instance.boyfriend;
	}

	inline function gf()
	{
		return PlayState.instance.gf;
	}

	inline function dad()
	{
		return PlayState.instance.dad;
	}

	inline function playstate(?type:String = ''):Dynamic
	{
		switch (type)
		{
			case "static":
				return PlayState;
			default:
				return PlayState.instance;
		}
	}
}
