package stages;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import stages.elements.*;

class SchoolEvil extends BasicStage
{
	var bgGhouls:BGSprite;

	public override function init()
	{
		name = 'schoolEvil';

		GameOverSubstate.deathSoundName = 'fnf_loss_sfx-pixel';
		GameOverSubstate.loopSoundName = 'gameOver-pixel';
		GameOverSubstate.endSoundName = 'gameOverEnd-pixel';
		GameOverSubstate.characterName = 'bf-pixel-dead';

		/*if(!ClientPrefs.lowQuality) { //Does this even do something?
			var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
			var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);
		}*/

		var posX = 400;
		var posY = 200;
		if (!ClientPrefs.lowQuality)
		{
			var bg:BGSprite = new BGSprite('week6/weeb/animatedEvilSchool', posX, posY, 0.8, 0.9, ['background 2'], true);
			bg.scale.set(6, 6);
			bg.antialiasing = false;
			addToBackground(bg);

			bgGhouls = new BGSprite('week6/weeb/bgGhouls', -100, 190, 0.9, 0.9, ['BG freaks glitch instance'], false);
			bgGhouls.setGraphicSize(Std.int(bgGhouls.width * playstate('static').daPixelZoom));
			bgGhouls.updateHitbox();
			bgGhouls.visible = false;
			bgGhouls.antialiasing = false;
			addToBackground(bgGhouls);
		}
		else
		{
			var bg:BGSprite = new BGSprite('week6/weeb/animatedEvilSchool_low', posX, posY, 0.8, 0.9);
			bg.scale.set(6, 6);
			bg.antialiasing = false;
			addToBackground(bg);
		}
	}

	public override function update(elapsed:Float)
	{
		if (!ClientPrefs.lowQuality && bgGhouls.animation.curAnim.finished)
		{
			bgGhouls.visible = false;
		}
	}

	public override function triggerEventNote(eventName:String, value1:String, value2:String)
	{
		switch (eventName)
		{
			case 'Trigger BG Ghouls':
				if (!ClientPrefs.lowQuality)
				{
					bgGhouls.dance(true);
					bgGhouls.visible = true;
				}
		}
	}
}
