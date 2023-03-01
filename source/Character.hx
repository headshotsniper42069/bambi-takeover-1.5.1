package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets', 'shared');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-holy':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/HOLY_GF', 'shared');
				frames = tex;
				animation.addByPrefix('bop', 'girlfriend_idle', 24);

				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);


				//addOffset('cheer');
				//addOffset('sad', -2, -2);
				//addOffset('danceLeft', 0, -9);
				//addOffset('danceRight', 0, -9);

				//addOffset("singUP", 0, 4);
				//addOffset("singRIGHT", 0, -20);
				//addOffset("singLEFT", 0, -19);
				//addOffset("singDOWN", 0, -20);
				//addOffset('hairBlow', 45, -8);
				//addOffset('hairFall', 0, -9);

				//addOffset('scared', -2, -17);

				playAnim('danceLeft');	

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST','shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND','shared');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('shot', "BF shotdeath", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				animation.addByPrefix('dodge', 'boyfriend dodge', 24, false);
				animation.addByPrefix('hit', 'BF hit', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('shot', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				addOffset("dodge", 7, -6);
				addOffset("hit", 26, 26);

				playAnim('idle');

				flipX = true;

			case 'bf-tetris': //his sprites are a wip
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND-tetris','shared');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				animation.addByPrefix('dodge', 'boyfriend dodge', 24, false);
				animation.addByPrefix('hit', 'BF hit', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				addOffset("dodge", 7, -6);
				addOffset("hit", 26, 26);

				playAnim('idle');

				flipX = true;


			case 'mami':
				tex = Paths.getSparrowAtlas('characters/Mami','shared');
				frames = tex;
				animation.addByPrefix('idle', 'Mami IDLE', 24);
				animation.addByPrefix('singUP', 'Mami UP', 24);
				animation.addByPrefix('singRIGHT', 'Mami RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Mami DOWN', 24);
				animation.addByPrefix('singLEFT', 'Mami LEFT', 24);
	
				addOffset('idle');
				addOffset("singUP", -6, 0);
				addOffset("singRIGHT", 0, -3);
				addOffset("singLEFT", -30, 0);
				addOffset("singDOWN", -10, -0);
	
				playAnim('idle');
			
			case 'bami': // case 'mamixbambishippingcute':
				tex = Paths.getSparrowAtlas('characters/bambibutmamiisntgone','shared');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 15, false);
				animation.addByPrefix('singUP', 'Bambi Up', 15, false);
				animation.addByPrefix('singRIGHT', 'Bambi Right', 15, false);
				animation.addByPrefix('singDOWN', 'Bambi Down', 15, false);
				animation.addByPrefix('singLEFT', 'Bambi Left', 15, false);
				animation.addByPrefix('singUP-alt', 'Mami Up', 15, false);
				animation.addByPrefix('singRIGHT-alt', 'Mami Right', 15, false);
				animation.addByPrefix('singDOWN-alt', 'Mami Down', 15, false);
				animation.addByPrefix('singLEFT-alt', 'Mami Left', 15, false);
	
				playAnim('idle');
			case 'edward': // fuck
				tex = Paths.getSparrowAtlas('characters/Fuck','shared');
				frames = tex;
				animation.addByPrefix('well', 'EduardoWell', 24, false);
				animation.addByPrefix('idle', 'EduardoIdle', 24, false);
				animation.addByPrefix('singLEFT', 'EduardoLeft', 24, false);
				animation.addByPrefix('singUP', 'EduardoUp', 24, false);
				animation.addByPrefix('singDOWN', 'EduardoDown', 24, false);
				animation.addByPrefix('singRIGHT', 'EduardoRight', 24, false);
				addOffset('idle', 0, 0); //24
				addOffset('well', -3, 1); //24
				addOffset("singUP", -16, 25); //-5
				addOffset("singRIGHT", -4, -6); //-35
				addOffset("singLEFT", 4, -6); //-35
				addOffset("singDOWN", 11, -20); //-65

				playAnim('idle');

			case 'bamijitterfix':
				tex = Paths.getSparrowAtlas('characters/bambibutmamiisntgonejitterfix','shared');
				frames = tex;
				animation.addByPrefix('singRIGHT', 'right', 15, false);
				animation.addByPrefix('singLEFT', 'left', 15, false);
				animation.addByPrefix('singUP', 'right', 15, false);
				animation.addByPrefix('singDOWN', 'left', 15, false);
				animation.addByPrefix('idle', 'left', 15, false);
	
				playAnim('idle');

			case 'mami-tetris':
				tex = Paths.getSparrowAtlas('characters/Mami Tetris','shared');
				frames = tex;
				animation.addByPrefix('idle', 'Mami IDLE', 24);
				animation.addByPrefix('singUP', 'Mami UP', 24);
				animation.addByPrefix('singRIGHT', 'Mami RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Mami DOWN', 24);
				animation.addByPrefix('singLEFT', 'Mami LEFT', 24);
	
				addOffset('idle');
				addOffset("singUP", -6, 0);
				addOffset("singRIGHT", 0, -3);
				addOffset("singLEFT", -30, 0);
				addOffset("singDOWN", -10, -0);
	
				playAnim('idle');
	
			case 'mami-holy-postsnap':
				tex = Paths.getSparrowAtlas('characters/Dave appears as a light skinned man with a blue shirt, blue pants, and short brown hair','shared');
				frames = tex;
				animation.addByPrefix('idle', 'altIDLE', 24, false);
				animation.addByPrefix('singUP', 'altUP', 24);
				animation.addByPrefix('singRIGHT', 'altUP', 24);
				animation.addByPrefix('singDOWN', 'altUP', 24);
				animation.addByPrefix('singLEFT', 'altUP', 24);

				addOffset('idle', -69, 126);
				addOffset('singUP', -94, 158);
				addOffset('singRIGHT', -94, 158);
				addOffset('singLEFT', -94, 158);
				addOffset('singDOWN', -94, 158);
	
				playAnim('idle');	

			case 'mami-mamigation':
				tex = Paths.getSparrowAtlas('characters/Mami Mamigation','shared');
				frames = tex;
				animation.addByPrefix('idle', 'MAMIGATION_IDLE', 24);
				animation.addByPrefix('singUP', 'MAMIGATION_UP', 24);
				animation.addByPrefix('singRIGHT', 'MAMIGATION_RIGHT', 24);
				animation.addByPrefix('singDOWN', 'MAMIGATION_DOWN', 24);
				animation.addByPrefix('singLEFT', 'MAMIGATION_LEFT', 24);

				addOffset('idle', -67, 126); //24
				addOffset("singUP", -69, 326); //-5
				addOffset("singRIGHT", -229, 126); //-35
				addOffset("singLEFT", 111, 246); //-35
				addOffset("singDOWN", 12, 56); //-65
	
				playAnim('idle');
			
			case 'bambi-splitathon':
				frames = Paths.getSparrowAtlas('characters/Splitathon_Bambi'); // STOP STOP BULLYING DAVE OH HE- HES DEAD
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
							
				addOffset('idle');
				addOffset("singUP", -24, 15);
				addOffset("singRIGHT", -34, -6);
				addOffset("singLEFT", -3, 6);
				addOffset("singDOWN", -20, -10);
		
				playAnim('idle');
			case 'bambi-splitathon1.0':
				frames = Paths.getSparrowAtlas('characters/Bambi Splitathon 1.0');
				animation.addByPrefix('idle', 'i', 24, false);
				animation.addByPrefix('singDOWN', 'd', 24, false);
				animation.addByPrefix('singUP', 'u', 24, false);
				animation.addByPrefix('singLEFT', 'l', 24, false);
				animation.addByPrefix('singRIGHT', 'r', 24, false);
							
				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);
		
				playAnim('idle');
			case 'dave-splitathon':
				frames = Paths.getSparrowAtlas('characters/Splitathon_Dave');
				animation.addByPrefix('idle', 'SplitIdle', 24, false);
				animation.addByPrefix('singDOWN', 'SplitDown', 24, false);
				animation.addByPrefix('singUP', 'SplitUp', 24, false);
				animation.addByPrefix('singLEFT', 'SplitLeft', 24, false);
				animation.addByPrefix('singRIGHT', 'SplitRight', 24, false);
				animation.addByPrefix('scared', 'Nervous', 24, true);
				animation.addByPrefix('what', 'Mad', 24, true);
				animation.addByPrefix('happy', 'Happy', 24, true);

				addOffset('idle');
				addOffset("singUP", -12, 20);
				addOffset("singRIGHT", -40, -13);
				addOffset("singLEFT", 32, 8);
				addOffset("singDOWN", 3, -21);
				addOffset("scared", -15, 11);
				addOffset("what", -3, 1);
				addOffset("happy", -3, 1);

				playAnim('idle');

			case 'mamigodofphones':
				frames = Paths.getSparrowAtlas('characters/Mami God Of Phones');
				animation.addByPrefix('idle', 'Idle', 15, false);
				animation.addByPrefix('singDOWN', 'Down', 15, false);
				animation.addByPrefix('singUP', 'Up', 15, false);
				animation.addByPrefix('singLEFT', 'Left', 15, false);
				animation.addByPrefix('singRIGHT', 'Right', 15, false);
				animation.addByPrefix('lookleft', 'Looking Left', 15, true);

				playAnim('idle');

			case '3dmami':
				frames = Paths.getSparrowAtlas('characters/oh no oh god');
				animation.addByPrefix('idle', 'idle', 15, true);
				animation.addByPrefix('singDOWN', 'down', 15, false);
				animation.addByPrefix('singUP', 'up', 15, false);
				animation.addByPrefix('singLEFT', 'left', 15, false);
				animation.addByPrefix('singRIGHT', 'right', 15, false);

				playAnim('idle');

			case 'bambijoke':
				frames = Paths.getSparrowAtlas('characters/bambi joke','shared');
				animation.addByIndices('idle', 'MARCELLO HEY!!', [24], "", 24, false);
				animation.addByPrefix('singUP', 'MARCELLO HEY!!', 24, false);
				animation.addByPrefix('singLEFT', 'MARCELLO HEY!!', 24, false);
				animation.addByPrefix('singRIGHT', 'MARCELLO HEY!!', 24, false);
				animation.addByPrefix('singDOWN', 'MARCELLO HEY!!', 24, false);

				flipX = true;

				playAnim('idle');
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				if (curCharacter != 'mamigodofphones')
					dance();
				else if (PlayState.mamiidlefix && curCharacter == 'mamigodofphones')
					dance(); // IM SOS SORRY FOR DOING THIS IDK HOW TO LJKSDFJKLFSDKJLDFSKLJFDS
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');

			case 'gf-holy':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-holy':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}

		if (curCharacter == 'gf-holy')
			{
				if (AnimName == 'singLEFT')
				{
					danced = true;
				}
				else if (AnimName == 'singRIGHT')
				{
					danced = false;
				}
	
				if (AnimName == 'singUP' || AnimName == 'singDOWN')
				{
					danced = !danced;
				}
			}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
