package stages;

import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import stages.elements.*;

class Philly extends BasicStage
{
	var phillyCityLights:FlxTypedGroup<BGSprite>;
	var phillyTrain:BGSprite;

	var trainSound:FlxSound;

	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	var startedMoving:Bool = false;

	var curLight:Int = 0;
	var curLightEvent:Int = 0;

	public override function init()
	{
		name = 'philly';

		if (!ClientPrefs.lowQuality)
		{
			var bg:BGSprite = new BGSprite('week3/philly/sky', -100, 0, 0.1, 0.1);
			addToBackground(bg);
		}

		var city:BGSprite = new BGSprite('week3/philly/city', -10, 0, 0.3, 0.3);
		city.setGraphicSize(Std.int(city.width * 0.85));
		city.updateHitbox();
		addToBackground(city);

		phillyCityLights = new FlxTypedGroup<BGSprite>();
		addToBackground(phillyCityLights);

		for (i in 0...5)
		{
			var light:BGSprite = new BGSprite('week3/philly/win' + i, city.x, city.y, 0.3, 0.3);
			light.visible = false;
			light.setGraphicSize(Std.int(light.width * 0.85));
			light.updateHitbox();
			phillyCityLights.add(light);
		}

		if (!ClientPrefs.lowQuality)
		{
			var streetBehind:BGSprite = new BGSprite('week3/philly/behindTrain', -40, 50);
			addToBackground(streetBehind);
		}

		phillyTrain = new BGSprite('week3/philly/train', 2000, 360);
		addToBackground(phillyTrain);

		trainSound = new FlxSound().loadEmbedded(Paths.sound('week3/train_passes'));
		CoolUtil.precacheSound('week3/train_passes');
		FlxG.sound.list.add(trainSound);

		var street:BGSprite = new BGSprite('week3/philly/street', -40, 50);
		addToBackground(street);
	}

	public override function update(elapsed:Float)
	{
		if (trainMoving)
		{
			trainFrameTiming += elapsed;

			if (trainFrameTiming >= 1 / 24)
			{
				updateTrainPos();
				trainFrameTiming = 0;
			}
		}
		phillyCityLights.members[curLight].alpha -= (Conductor.crochet / 1000) * FlxG.elapsed * 1.5;
	}

	public override function beat(curBeat)
	{
		if (!trainMoving)
			trainCooldown += 1;

		if (curBeat % 4 == 0)
		{
			phillyCityLights.forEach(function(light:BGSprite)
			{
				light.visible = false;
			});

			curLight = FlxG.random.int(0, phillyCityLights.length - 1, [curLight]);

			phillyCityLights.members[curLight].visible = true;
			phillyCityLights.members[curLight].alpha = 1;
		}

		if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
		{
			trainCooldown = FlxG.random.int(-4, 0);
			trainStart();
		}
	}

	function changeLightColor()
	{
		phillyCityLights.forEach(function(light:BGSprite)
		{
			light.visible = false;
		});

		var curLight = FlxG.random.int(0, phillyCityLights.length - 1);

		phillyCityLights.members[curLight].visible = true;
		// phillyCityLights.members[curLight].alpha = 1;
	}

	function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
		{
			trainSound.play(true);
		}
	}

	function updateTrainPos():Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			gf().playAnim('hairBlow');
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
				{
					trainFinishing = true;
				}
			}

			if (phillyTrain.x < -4000 && trainFinishing)
			{
				trainReset();
			}
		}
	}

	function trainReset():Void
	{
		gf().danced = false; // Sets head to the correct position once the animation ends
		gf().playAnim('hairFall');
		phillyTrain.x = FlxG.width + 200;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}
}
