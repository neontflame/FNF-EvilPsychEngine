package stages;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import stages.elements.*;

class Spooky extends BasicStage
{
	var halloweenBG:BGSprite;
	var halloweenWhite:BGSprite;

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	public override function init()
	{
		name = 'spooky';

		if (!ClientPrefs.lowQuality)
		{
			halloweenBG = new BGSprite('week2/halloween_bg', -200, -100, ['halloweem bg0', 'halloweem bg lightning strike']);
		}
		else
		{
			halloweenBG = new BGSprite('week2/halloween_bg_low', -200, -100);
		}
		addToBackground(halloweenBG);

		halloweenWhite = new BGSprite(null, -FlxG.width, -FlxG.height, 0, 0);
		halloweenWhite.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.WHITE);
		halloweenWhite.alpha = 0;
		halloweenWhite.blend = ADD;
		addToForeground(halloweenWhite);

		// PRECACHE SOUNDS
		CoolUtil.precacheSound('week2/thunder_1');
		CoolUtil.precacheSound('week2/thunder_2');
	}

	public override function beat(curBeat:Int)
	{
		if (FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		{
			lightningStrikeShit(curBeat);
		}
	}

	function lightningStrikeShit(curBeat:Int):Void
	{
		FlxG.sound.play(Paths.soundRandom('week2/thunder_', 1, 2));
		if (!ClientPrefs.lowQuality)
			halloweenBG.animation.play('halloweem bg lightning strike');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);

		if (boyfriend().animOffsets.exists('scared'))
		{
			boyfriend().playAnim('scared', true);
		}
		if (gf().animOffsets.exists('scared'))
		{
			gf().playAnim('scared', true);
		}

		if (ClientPrefs.camZooms)
		{
			FlxG.camera.zoom += 0.015;
			playstate().camHUD.zoom += 0.03;

			if (!playstate().camZooming)
			{ // Just a way for preventing it to be permanently zoomed until Skid & Pump hits a note
				FlxTween.tween(FlxG.camera, {zoom: playstate().defaultCamZoom}, 0.5);
				FlxTween.tween(playstate().camHUD, {zoom: 1}, 0.5);
			}
		}

		if (ClientPrefs.flashing)
		{
			halloweenWhite.alpha = 0.4;
			FlxTween.tween(halloweenWhite, {alpha: 0.5}, 0.075);
			FlxTween.tween(halloweenWhite, {alpha: 0}, 0.25, {startDelay: 0.15});
		}
	}
}
