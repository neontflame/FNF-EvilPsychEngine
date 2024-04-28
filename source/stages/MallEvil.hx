package stages;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import stages.elements.*;

class MallEvil extends BasicStage
{
	public override function init()
	{
		name = 'mallEvil';

		var bg:BGSprite = new BGSprite('week5/christmas/evilBG', -400, -500, 0.2, 0.2);
		bg.setGraphicSize(Std.int(bg.width * 0.8));
		bg.updateHitbox();
		addToBackground(bg);

		var evilTree:BGSprite = new BGSprite('week5/christmas/evilTree', 300, -300, 0.2, 0.2);
		addToBackground(evilTree);

		var evilSnow:BGSprite = new BGSprite('week5/christmas/evilSnow', -200, 700);
		addToBackground(evilSnow);
	}
}
