package;

import lime.graphics.Image;
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;



class SpoilerState extends MusicBeatState
{
	public static var leftState:Bool = false;
	
	public var canpress:Bool = true;

	public static var needVer:String = "IDFK LOL";

	var bg:FlxSprite;
	var txt:FlxText;

	override function create()
	{
		FlxG.sound.music.stop();
		FlxG.sound.playMusic(Paths.music('freakyMenu', 'preload'));
		var funnyicon:Image = new Image();
		funnyicon = Image.fromFile(Sys.getCwd() + "iconOG.png");
		lime.app.Application.current.window.setIcon(funnyicon);
		lime.app.Application.current.window.title = "Friday Night Funkin' Vs. Mami [FULL WEEK]";
		var tex = Paths.getSparrowAtlas('spoiler','shared');
		bg = new FlxSprite(-200, -100);
		bg.frames = tex;
		bg.animation.addByPrefix('idle', 'spoiler loop');
		bg.screenCenter();
		bg.y -= 750;
		bg.animation.play('idle', true);
		bg.alpha = 0.5;
		add(bg);

		canpress = false;

		trace(bg.x);
		trace(bg.y);

		super.create();
		
		txt = new FlxText(0, 0, FlxG.width,
			"THIS MOD CONTAINS SPOILERS AND FLASHING LIGHTS\n"
			+ "This mod has SPOILERS for the 'Madoka Magica' series.\n"
			+ "\n"
			+ "This mod also has FLASHING LIGHTS from additional content!\n"
			+ "Press ENTER to go into the settings, or ESC to ingore this warning.\n"
			+ "\n"
			+ "Oh and by the way, there's 2 new songs in Freeplay.\n",
			32);
		txt.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.y -= 750;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		add(txt);

		new FlxTimer().start(0.5, function(phone:FlxTimer)
		{
			FlxTween.tween(bg, {x: -78, y: -14}, 0.5, {ease: FlxEase.cubeOut});
			FlxTween.tween(txt, {x: 0, y: 228}, 0.5, {ease: FlxEase.cubeOut});
		});

		new FlxTimer().start(1, function(phone:FlxTimer)
		{
			canpress = true;
		});

		trace(txt.x);
		trace(txt.y);
	}

	override function update(elapsed:Float)
	{
		if (canpress)
		{
			if (controls.ACCEPT)
			{
				canpress = false;
				FlxTween.tween(bg, {x: -78 - 1378, y: -14}, 0.5, {ease: FlxEase.cubeIn});
				FlxTween.tween(txt, {x: 0 - 1378, y: 228}, 0.5, {ease: FlxEase.cubeIn});
				new FlxTimer().start(0.5, function(phones:FlxTimer)
				{
					FlxTransitionableState.skipNextTransOut = true;
					FlxG.switchState(new OptionsMenu());
				});
			}
			if (controls.BACK)
			{
				canpress = false;
				FlxTween.tween(bg, {x: -78, y: -14 + 750}, 0.5, {ease: FlxEase.cubeIn});
				FlxTween.tween(txt, {x: 0, y: 228 + 750}, 0.5, {ease: FlxEase.cubeIn});
				new FlxTimer().start(0.5, function(phones:FlxTimer)
				{
					FlxTransitionableState.skipNextTransOut = true;
					FlxG.switchState(new MainMenuState());
				});
			}
		}

		super.update(elapsed);
	}
}