package stages;

import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import stages.elements.*;

class Limo extends BasicStage
{
	var limoSpeed:Float = 0;
	var limoKillingState:Int = 0;
	var limo:BGSprite;
	var limoMetalPole:BGSprite;
	var limoLight:BGSprite;
	var limoCorpse:BGSprite;
	var limoCorpseTwo:BGSprite;
	var bgLimo:BGSprite;
	var grpLimoParticles:FlxTypedGroup<BGSprite>;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:BGSprite;

	var fastCarCanDrive:Bool = true;

	public override function init()
	{
		name = 'limo';

		var skyBG:BGSprite = new BGSprite('week4/limo/limoSunset', -120, -50, 0.1, 0.1);
		addToBackground(skyBG);

		if (!ClientPrefs.lowQuality)
		{
			limoMetalPole = new BGSprite('week4/gore/metalPole', -500, 220, 0.4, 0.4);
			addToBackground(limoMetalPole);

			bgLimo = new BGSprite('week4/limo/bgLimo', -150, 480, 0.4, 0.4, ['background limo pink'], true);
			addToBackground(bgLimo);

			limoCorpse = new BGSprite('week4/gore/noooooo', -500, limoMetalPole.y - 130, 0.4, 0.4, ['Henchmen on rail'], true);
			addToBackground(limoCorpse);

			limoCorpseTwo = new BGSprite('week4/gore/noooooo', -500, limoMetalPole.y, 0.4, 0.4, ['henchmen death'], true);
			addToBackground(limoCorpseTwo);

			grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
			addToBackground(grpLimoDancers);

			for (i in 0...5)
			{
				var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
				dancer.scrollFactor.set(0.4, 0.4);
				grpLimoDancers.add(dancer);
			}

			limoLight = new BGSprite('week4/gore/coldHeartKiller', limoMetalPole.x - 180, limoMetalPole.y - 80, 0.4, 0.4);
			addToBackground(limoLight);

			grpLimoParticles = new FlxTypedGroup<BGSprite>();
			addToBackground(grpLimoParticles);

			// PRECACHE BLOOD
			var particle:BGSprite = new BGSprite('week4/gore/stupidBlood', -400, -400, 0.4, 0.4, ['blood'], false);
			particle.alpha = 0.01;
			grpLimoParticles.add(particle);
			resetLimoKill();

			// PRECACHE SOUND
			CoolUtil.precacheSound('week4/dancerdeath');
		}

		limo = new BGSprite('week4/limo/limoDrive', -120, 550, 1, 1, ['Limo stage'], true);
		addToMiddle(limo);

		fastCar = new BGSprite('week4/limo/fastCarLol', -300, 160);
		fastCar.active = true;
		limoKillingState = 0;

		resetFastCar();
	}

	public override function update(elapsed:Float)
	{
		if (!ClientPrefs.lowQuality)
		{
			grpLimoParticles.forEach(function(spr:BGSprite)
			{
				if (spr.animation.curAnim.finished)
				{
					spr.kill();
					grpLimoParticles.remove(spr, true);
					spr.destroy();
				}
			});

			switch (limoKillingState)
			{
				case 1:
					limoMetalPole.x += 5000 * elapsed;
					limoLight.x = limoMetalPole.x - 180;
					limoCorpse.x = limoLight.x - 50;
					limoCorpseTwo.x = limoLight.x + 35;

					var dancers:Array<BackgroundDancer> = grpLimoDancers.members;
					for (i in 0...dancers.length)
					{
						if (dancers[i].x < FlxG.width * 1.5 && limoLight.x > (370 * i) + 130)
						{
							switch (i)
							{
								case 0 | 3:
									if (i == 0)
										FlxG.sound.play(Paths.sound('week4/dancerdeath'), 0.5);

									var diffStr:String = i == 3 ? ' 2 ' : ' ';
									var particle:BGSprite = new BGSprite('week4/gore/noooooo', dancers[i].x + 200, dancers[i].y, 0.4, 0.4,
										['hench leg spin' + diffStr + 'PINK'], false);
									grpLimoParticles.add(particle);
									var particle:BGSprite = new BGSprite('week4/gore/noooooo', dancers[i].x + 160, dancers[i].y + 200, 0.4, 0.4,
										['hench arm spin' + diffStr + 'PINK'], false);
									grpLimoParticles.add(particle);
									var particle:BGSprite = new BGSprite('week4/gore/noooooo', dancers[i].x, dancers[i].y + 50, 0.4, 0.4,
										['hench head spin' + diffStr + 'PINK'], false);
									grpLimoParticles.add(particle);

									var particle:BGSprite = new BGSprite('week4/gore/stupidBlood', dancers[i].x - 110, dancers[i].y + 20, 0.4, 0.4, ['blood'],
										false);
									particle.flipX = true;
									particle.angle = -57.5;
									grpLimoParticles.add(particle);
								case 1:
									limoCorpse.visible = true;
								case 2:
									limoCorpseTwo.visible = true;
							} // Note: Nobody cares about the fifth dancer because he is mostly hidden offscreen :(
							dancers[i].x += FlxG.width * 2;
						}
					}

					if (limoMetalPole.x > FlxG.width * 2)
					{
						resetLimoKill();
						limoSpeed = 800;
						limoKillingState = 2;
					}

				case 2:
					limoSpeed -= 4000 * elapsed;
					bgLimo.x -= limoSpeed * elapsed;
					if (bgLimo.x > FlxG.width * 1.5)
					{
						limoSpeed = 3000;
						limoKillingState = 3;
					}

				case 3:
					limoSpeed -= 2000 * elapsed;
					if (limoSpeed < 1000)
						limoSpeed = 1000;

					bgLimo.x -= limoSpeed * elapsed;
					if (bgLimo.x < -275)
					{
						limoKillingState = 4;
						limoSpeed = 800;
					}

				case 4:
					bgLimo.x = FlxMath.lerp(bgLimo.x, -150, CoolUtil.boundTo(elapsed * 9, 0, 1));
					if (Math.round(bgLimo.x) == -150)
					{
						bgLimo.x = -150;
						limoKillingState = 0;
					}
			}

			if (limoKillingState > 2)
			{
				var dancers:Array<BackgroundDancer> = grpLimoDancers.members;
				for (i in 0...dancers.length)
				{
					dancers[i].x = (370 * i) + bgLimo.x + 280;
				}
			}
		}
	}

	public override function beat(curBeat:Float)
	{
		if (!ClientPrefs.lowQuality)
		{
			grpLimoDancers.forEach(function(dancer:BackgroundDancer)
			{
				dancer.dance();
			});
		}

		if (FlxG.random.bool(10) && fastCarCanDrive)
			fastCarDrive();
	}

	function resetFastCar():Void
	{
		fastCar.x = -12600;
		fastCar.y = FlxG.random.int(140, 250);
		fastCar.velocity.x = 0;
		fastCarCanDrive = true;
	}

	function fastCarDrive()
	{
		FlxG.sound.play(Paths.soundRandom('week4/carPass', 0, 1), 0.7);

		fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
		fastCarCanDrive = false;
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			resetFastCar();
		});
	}

	function killHenchmen():Void
	{
		if (!ClientPrefs.lowQuality && ClientPrefs.violence)
		{
			if (limoKillingState < 1)
			{
				limoMetalPole.x = -400;
				limoMetalPole.visible = true;
				limoLight.visible = true;
				limoCorpse.visible = false;
				limoCorpseTwo.visible = false;
				limoKillingState = 1;

				#if ACHIEVEMENTS_ALLOWED
				Achievements.henchmenDeath++;
				var achieve:Int = checkForAchievement([10]);
				if (achieve > -1)
				{
					startAchievement(achieve);
				}
				else
				{
					FlxG.save.data.henchmenDeath = Achievements.henchmenDeath;
					FlxG.save.flush();
				}
				FlxG.log.add('Deaths: ' + Achievements.henchmenDeath);
				#end
			}
		}
	}

	function resetLimoKill():Void
	{
		limoMetalPole.x = -500;
		limoMetalPole.visible = false;
		limoLight.x = -500;
		limoLight.visible = false;
		limoCorpse.x = -500;
		limoCorpse.visible = false;
		limoCorpseTwo.x = -500;
		limoCorpseTwo.visible = false;
	}

	public override function triggerEventNote(eventName:String, value1:String, value2:String)
	{
		switch (eventName)
		{
			case 'Kill Henchmen':
				killHenchmen();
		}
	}
}
