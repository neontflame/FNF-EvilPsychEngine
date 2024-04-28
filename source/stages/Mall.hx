package stages;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import stages.elements.*;

class Mall extends BasicStage
{
	var upperBoppers:BGSprite;
	var bottomBoppers:BGSprite;
	var santa:BGSprite;

	var heyTimer:Float;

	public override function init()
	{
		name = 'mall';

		var bg:BGSprite = new BGSprite('week5/christmas/bgWalls', -1000, -500, 0.2, 0.2);
		bg.setGraphicSize(Std.int(bg.width * 0.8));
		bg.updateHitbox();
		addToBackground(bg);

		if (!ClientPrefs.lowQuality)
		{
			upperBoppers = new BGSprite('week5/christmas/upperBop', -240, -90, 0.33, 0.33, ['Upper Crowd Bob']);
			upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
			upperBoppers.updateHitbox();
			addToBackground(upperBoppers);

			var bgEscalator:BGSprite = new BGSprite('week5/christmas/bgEscalator', -1100, -600, 0.3, 0.3);
			bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
			bgEscalator.updateHitbox();
			addToBackground(bgEscalator);
		}

		var tree:BGSprite = new BGSprite('week5/christmas/christmasTree', 370, -250, 0.40, 0.40);
		addToBackground(tree);

		bottomBoppers = new BGSprite('week5/christmas/bottomBop', -300, 140, 0.9, 0.9, ['Bottom Level Boppers Idle']);
		bottomBoppers.animation.addByPrefix('hey', 'Bottom Level Boppers HEY', 24, false);
		bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
		bottomBoppers.updateHitbox();
		addToBackground(bottomBoppers);

		var fgSnow:BGSprite = new BGSprite('week5/christmas/fgSnow', -600, 700);
		addToBackground(fgSnow);

		santa = new BGSprite('week5/christmas/santa', -840, 150, 1, 1, ['santa idle in fear']);
		addToBackground(santa);
		CoolUtil.precacheSound('week5/Lights_Shut_off');
	}

	public override function update(elapsed:Float)
	{
		if (heyTimer > 0)
		{
			heyTimer -= elapsed;
			if (heyTimer <= 0)
			{
				bottomBoppers.dance(true);
				heyTimer = 0;
			}
		}
	}

	public override function beat(curBeat:Int)
	{
		if (!ClientPrefs.lowQuality)
		{
			upperBoppers.dance(true);
		}

		if (heyTimer <= 0)
			bottomBoppers.dance(true);
		santa.dance(true);
	}

	public override function triggerEventNote(eventName:String, value1:String, value2:String)
	{
		switch (eventName)
		{
			case "Hey!":
				var time:Float = Std.parseFloat(value2);
				if (Math.isNaN(time) || time <= 0)
					time = 0.6;

				bottomBoppers.animation.play('hey', true);
				heyTimer = time;
		}
	}
}
