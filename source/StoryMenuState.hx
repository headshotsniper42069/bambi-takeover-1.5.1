package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreTopText:FlxText;
	var scoreText:FlxText;

	var weekData:Array<Dynamic> = [
		['Connect','Reminisce','Salvation'],
		['???', '???', '???']
	];
	var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true];

	var weekCharacters:Array<Dynamic> = [
		['', 'bf', 'gf']
	];

	var weekNames:Array<String> = [
		"Mackingham Palace",
		"??? (COMING SOON)"
	];

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	//var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	//var flower:FlxSprite;
	var holyConfirmBG:FlxSprite;
	var holyConfirm:FlxText;
	var holySelected:Bool = false;

	var storyWeekBG:FlxSprite;
	var storyWeek2BG:FlxSprite;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Story Mode Menu", null);
		#end

		Conductor.changeBPM(171);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		scoreTopText = new FlxText(10, 10, 0, "WEEK SCORE", 36);
		scoreTopText.setFormat("VCR OSD Mono", 36);

		scoreText = new FlxText(10, 36, 0, "123456789", 72);
		scoreText.setFormat("VCR OSD Mono", 72);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		txtWeekTitle.borderSize = 3;
		txtWeekTitle.alpha = 1;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var yellowBG:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 400, 0xFFF9CF51);

		storyWeek2BG = new FlxSprite(0, -100).loadGraphic(Paths.image('storymenu/week1bg', 'preload'));
		storyWeek2BG.antialiasing = true;
		storyWeek2BG.visible = false;
		//haxeflixe please make the week bg change thanks -Juan
		add(storyWeek2BG);
		FlxTween.linearMotion(storyWeek2BG, 0, -1280, 0, -100, 2, {ease: FlxEase.quadOut});

		storyWeekBG = new FlxSprite(0, -100).loadGraphic(Paths.image('storymenu/week0bg', 'preload'));
		storyWeekBG.antialiasing = true;
		storyWeekBG.visible = true;
		//haxeflixe please make the week bg change thanks -Juan
		add(storyWeekBG);
		FlxTween.linearMotion(storyWeekBG, 0, -1280, 0, -100, 2, {ease: FlxEase.quadOut});

		new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				FlxTween.tween(storyWeekBG, {y: -25}, 7, {type: FlxTweenType.PINGPONG, ease: FlxEase.quadInOut});
				FlxTween.tween(storyWeek2BG, {y: -25}, 7, {type: FlxTweenType.PINGPONG, ease: FlxEase.quadInOut});
			});

		var scoreBlackBG:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('storymenu/top_section', 'preload'));
		add(scoreBlackBG);
		FlxTween.linearMotion(scoreBlackBG, 0, -1280, 0, 0, 2, {ease: FlxEase.quadOut});

		var weekSelectionBG:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('storymenu/bottom_section', 'preload'));
		add(weekSelectionBG);
		FlxTween.linearMotion(weekSelectionBG, 0, 1280, 0, 0, 2, {ease: FlxEase.quadOut});

		var weekTracksBG:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('storymenu/tracks_section', 'preload'));
		add(weekTracksBG);
		FlxTween.linearMotion(weekTracksBG, 0, 1280, 0, 0, 2, {ease: FlxEase.quadOut});

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);
		//FlxTween.linearMotion(grpWeekText, 0, 1280, 0, 0, 2, {ease: FlxEase.quadOut});

		//grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		trace("Line 70");

		for (i in 0...weekData.length)
		{
			var weekThing:MenuItem = new MenuItem(90, 90, i);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.screenCenter(X);
			weekThing.x -= 35;
			weekThing.antialiasing = true;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}
			weekThing.alpha = 0.0;
			FlxTween.tween(weekThing,{alpha: 1}, 2, {ease: FlxEase.quadOut});
		}

		trace("Line 96");

		//grpWeekCharacters.add(new MenuCharacter(0, 100, 0.5, false));
		//grpWeekCharacters.add(new MenuCharacter(450, 25, 0.9, true));
		//grpWeekCharacters.add(new MenuCharacter(850, 100, 0.5, true));

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);
		//FlxTween.linearMotion(difficultySelectors, 0, -1280, 0, 0, 1.5, {ease: FlxEase.quadOut});

		trace("Line 124");

		leftArrow = new FlxSprite(900, 525);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		sprDifficulty = new FlxSprite(leftArrow.x + 95, 540);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.addByPrefix('holy', 'HOLY');
		sprDifficulty.animation.play('easy');
		changeDifficulty();

		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(sprDifficulty.x + sprDifficulty.width + 15, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		difficultySelectors.add(rightArrow);

		FlxTween.linearMotion(leftArrow, 900, 1280, 900, 525, 2, {ease: FlxEase.quadOut});
		FlxTween.linearMotion(sprDifficulty, 995, 1280, 1015, 540, 2, {ease: FlxEase.quadOut});
		FlxTween.linearMotion(rightArrow, 1200, 1280, 1200, 525, 2, {ease: FlxEase.quadOut});

		trace("Line 150");

		//add(grpWeekCharacters);
		add(scoreBlackBG);

		//flower = new FlxSprite(-15, 0).loadGraphic(Paths.image('weekm'));
		//flower.setGraphicSize(Std.int(flower.width * 0.55));
		//flower.antialiasing = true;
		//add(flower);

		//FlxTween.tween(flower, {angle: 25}, 2.5, {type: FlxTweenType.PINGPONG, ease: FlxEase.quadInOut});
		
		txtTracklist = new FlxText(FlxG.width * 0.06, 500, 0, "Tracks", 32);
		txtTracklist.setFormat("VCR OSD Mono", 32, 0xFFe55777, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		txtTracklist.borderSize = 3;
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFe55777;
		txtTracklist.angle = -6;
		txtTracklist.antialiasing = true;
		add(txtTracklist);
		FlxTween.tween(txtTracklist,{alpha: 1}, 2, {ease: FlxEase.quadOut});
		// add(rankText);
		add(scoreText);
		add(scoreTopText);
		add(txtWeekTitle);

		holyConfirmBG = new FlxSprite(0, 347).makeGraphic(FlxG.width, 90, FlxColor.BLACK);
		holyConfirmBG.alpha = 0;
		add(holyConfirmBG);
		
		holyConfirm = new FlxText(FlxG.width * -0.05, FlxG.height * 0.5, 1000, "", 32);
		holyConfirm.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		holyConfirm.alpha = 0;
		holyConfirm.text = "HOLY diffiuclty is unforgiving. Press CONFIRM again to play on this diffiuclty.";
		holyConfirm.scrollFactor.set(0, 0);
		holyConfirm.screenCenter(X);
		add(holyConfirm);

		updateText();

		trace("Line 165");

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		if (controls.RIGHT)
			{
			FlxTween.cancelTweensOf(holyConfirm);
			FlxTween.cancelTweensOf(holyConfirmBG);
			holyConfirm.alpha = 0;
			holyConfirmBG.alpha = 0;
			}

		if (controls.LEFT)
			{
			FlxTween.cancelTweensOf(holyConfirm);
			FlxTween.cancelTweensOf(holyConfirmBG);
			holyConfirm.alpha = 0;
			holyConfirmBG.alpha = 0;
			}

		if (controls.UP)
			{
			FlxTween.cancelTweensOf(holyConfirm);
			FlxTween.cancelTweensOf(holyConfirmBG);
			holyConfirm.alpha = 0;
			holyConfirmBG.alpha = 0;
			}

		if (controls.DOWN)
			{
			FlxTween.cancelTweensOf(holyConfirm);
			FlxTween.cancelTweensOf(holyConfirmBG);
			holyConfirm.alpha = 0;
			holyConfirmBG.alpha = 0;
			}

		scoreText.text = "" + lerpScore;

		//scoreText.text = "WEEK SCORE:" + lerpScore;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = weekUnlocked[curWeek];

		if (BamberVariables.alreadycompletedcornholyshit = true)
			{
				BamberVariables.alreadycompletedcornholyshit = false; // reverse the what it does in playstate DOES ANYONE EVEN READ THIS=? duplicatre moment
			}

		if (curWeek == 1)
			{
				storyWeekBG.visible = false;
				storyWeek2BG.visible = true;
				difficultySelectors.visible = true;
			}
		else
			{
				storyWeekBG.visible = true;
				storyWeek2BG.visible = false;
				difficultySelectors.visible = true;
			}


		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeWeek(-1);
				}

				if (controls.DOWN_P)
				{
					changeWeek(1);
				}

				if (controls.RIGHT && curWeek == 0)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT && curWeek == 0)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.RIGHT_P && curWeek == 0)
					changeDifficulty(1);

				if (controls.LEFT_P && curWeek == 0)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT && curWeek == 0)
			{
				if (curDifficulty == 3)
					{
						if (!holySelected)
							{
							FlxTween.completeTweensOf(holyConfirm);
							FlxTween.completeTweensOf(holyConfirmBG);
							if (holyConfirm.alpha == 1)
								{
								selectWeek();
								holySelected = true;
								}
							FlxG.sound.play(Paths.sound('confirmMenu'));
							if (!holySelected) //just to make sure it doesn't move after you select it??
								{
								holyConfirm.y = 370;
								holyConfirmBG.y = 357;
								FlxTween.tween(holyConfirm, {y: 360, alpha: 1}, .3, {type: FlxTweenType.ONESHOT, ease: FlxEase.quadOut});
								FlxTween.tween(holyConfirmBG, {y: 347, alpha: 1}, .3, {type: FlxTweenType.ONESHOT, ease: FlxEase.quadOut});
								}
							}
					}
				else
					{
						selectWeek();
					}
			}
			else if (controls.ACCEPT && curWeek == 1)
				{
					FlxG.sound.play(Paths.sound('errorMenu'));
					FlxTween.color(storyWeek2BG, 1, 0xffff8f8f, FlxColor.WHITE, {ease: FlxEase.quartOut});
				}
		}

		if (curDifficulty == 3 && curWeek == 0)
			txtTracklist.color = 0xFFFEE897;
		else
			txtTracklist.color = 0xFFe55777;

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		FlxG.camera.zoom = FlxMath.lerp(1.0, FlxG.camera.zoom, 0.95);

		super.update(elapsed);
	}

	override function beatHit()
		{
			FlxG.log.add(curBeat);

			if (curBeat % 4 == 0)
				{
					FlxG.camera.zoom += 0.005;
				}
			
			super.beatHit();
		}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
			{
				if (stopspamming == false)
				{
					if (curDifficulty == 3)
						{
						FlxTween.completeTweensOf(holyConfirm);
						FlxTween.completeTweensOf(holyConfirmBG);
						}
					else
						FlxG.sound.play(Paths.sound('confirmMenu'));

					grpWeekText.members[curWeek].startFlashing();
					//grpWeekCharacters.members[1].animation.play('bfConfirm');
					stopspamming = true;
				}

				PlayState.storyPlaylist = weekData[curWeek];
				PlayState.isStoryMode = true;
				selectedWeek = true;

				var diffic = "";

				switch (curDifficulty)
				{
					case 0:
						diffic = '-easy';
					case 2:
						diffic = '-hard';
					case 3:
						diffic = '-holy';
				}

				PlayState.storyDifficulty = curDifficulty;

				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = curWeek;
				PlayState.campaignScore = 0;
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new VideoState("assets/videos/Connect_Intro.webm", new PlayState()));
					LoadingState.loadAndSwitchState(new PlayState(), true);
				});
			}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 3;
		if (curDifficulty > 3)
			curDifficulty = 0;

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
				sprDifficulty.offset.x = 40;
			case 1:
				sprDifficulty.animation.play('normal');
				sprDifficulty.offset.x = 50;
			case 2:
				sprDifficulty.animation.play('hard');
				sprDifficulty.offset.x = 45;
			case 3:
				sprDifficulty.animation.play('holy');
				sprDifficulty.offset.x = 40;
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = 525 - 15;
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

		FlxTween.tween(sprDifficulty, {y: 525 + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked[curWeek])
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));

		updateText();
	}

	function updateText()
	{
		//grpWeekCharacters.members[0].setCharacter(weekCharacters[curWeek][0]);
		//grpWeekCharacters.members[1].setCharacter(weekCharacters[curWeek][1]);
		//grpWeekCharacters.members[2].setCharacter(weekCharacters[curWeek][2]);

		txtTracklist.text = "Tracks\n";
		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
		{
			txtTracklist.text += "\n" + i;
		}

		txtTracklist.text += "\n"; 
		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}
}
