package stages;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import stages.elements.*;

class Stage extends BasicStage
{
	public override function init()
	{
		name = 'stage';

		var bg:BGSprite = new BGSprite('week1/stageback', -600, -200, 0.9, 0.9);
		addToBackground(bg);

		var stageFront:BGSprite = new BGSprite('week1/stagefront', -650, 600, 0.9, 0.9);
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
		stageFront.updateHitbox();
		addToBackground(stageFront);

		if (!ClientPrefs.lowQuality)
		{
			var stageLight:BGSprite = new BGSprite('week1/stage_light', -125, -100, 0.9, 0.9);
			stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
			stageLight.updateHitbox();
			addToBackground(stageLight);

			var stageLight:BGSprite = new BGSprite('week1/stage_light', 1225, -100, 0.9, 0.9);
			stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
			stageLight.updateHitbox();
			stageLight.flipX = true;
			addToBackground(stageLight);

			var stageCurtains:BGSprite = new BGSprite('week1/stagecurtains', -500, -300, 1.3, 1.3);
			stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
			stageCurtains.updateHitbox();
			addToBackground(stageCurtains);
		}
	}
}
