package stages;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import stages.elements.*;

class School extends BasicStage
{
	var bgGirls:BackgroundGirls;

	public override function init()
	{
		name = 'school';

		GameOverSubstate.deathSoundName = 'fnf_loss_sfx-pixel';
		GameOverSubstate.loopSoundName = 'gameOver-pixel';
		GameOverSubstate.endSoundName = 'gameOverEnd-pixel';
		GameOverSubstate.characterName = 'bf-pixel-dead';

		var bgSky:BGSprite = new BGSprite('week6/weeb/weebSky', 0, 0, 0.1, 0.1);
		addToBackground(bgSky);
		bgSky.antialiasing = false;

		var repositionShit = -200;

		var bgSchool:BGSprite = new BGSprite('week6/weeb/weebSchool', repositionShit, 0, 0.6, 0.90);
		addToBackground(bgSchool);
		bgSchool.antialiasing = false;

		var bgStreet:BGSprite = new BGSprite('week6/weeb/weebStreet', repositionShit, 0, 0.95, 0.95);
		addToBackground(bgStreet);
		bgStreet.antialiasing = false;

		var widShit = Std.int(bgSky.width * 6);
		if (!ClientPrefs.lowQuality)
		{
			var fgTrees:BGSprite = new BGSprite('week6/weeb/weebTreesBack', repositionShit + 170, 130, 0.9, 0.9);
			fgTrees.setGraphicSize(Std.int(widShit * 0.8));
			fgTrees.updateHitbox();
			addToBackground(fgTrees);
			fgTrees.antialiasing = false;
		}

		var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
		bgTrees.frames = Paths.getPackerAtlas('week6/weeb/weebTrees');
		bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
		bgTrees.animation.play('treeLoop');
		bgTrees.scrollFactor.set(0.85, 0.85);
		addToBackground(bgTrees);
		bgTrees.antialiasing = false;

		if (!ClientPrefs.lowQuality)
		{
			var treeLeaves:BGSprite = new BGSprite('week6/weeb/petals', repositionShit, -40, 0.85, 0.85, ['PETALS ALL'], true);
			treeLeaves.setGraphicSize(widShit);
			treeLeaves.updateHitbox();
			addToBackground(treeLeaves);
			treeLeaves.antialiasing = false;
		}

		bgSky.setGraphicSize(widShit);
		bgSchool.setGraphicSize(widShit);
		bgStreet.setGraphicSize(widShit);
		bgTrees.setGraphicSize(Std.int(widShit * 1.4));

		bgSky.updateHitbox();
		bgSchool.updateHitbox();
		bgStreet.updateHitbox();
		bgTrees.updateHitbox();

		if (!ClientPrefs.lowQuality)
		{
			bgGirls = new BackgroundGirls(-100, 190);
			bgGirls.scrollFactor.set(0.9, 0.9);

			bgGirls.setGraphicSize(Std.int(bgGirls.width * playstate('static').daPixelZoom));
			bgGirls.updateHitbox();
			addToBackground(bgGirls);
		}
	}

	public override function beat(curBeat:Int)
	{
		if (!ClientPrefs.lowQuality)
		{
			bgGirls.dance();
		}
	}

	public override function triggerEventNote(eventName:String, value1:String, value2:String)
	{
		switch (eventName)
		{
			case 'BG Freaks Expression':
				if (bgGirls != null)
					bgGirls.swapDanceType();
		}
	}
}
