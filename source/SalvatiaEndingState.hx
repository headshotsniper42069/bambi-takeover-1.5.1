import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import openfl.Lib;
#if desktop
import Sys;
import Discord.DiscordClient;
#end

using StringTools; // yes

class SalvatiaEndingState extends FlxState
{
    public static var ending:String = 'cheater';
    public var endingscene:FlxSprite;
    public var bf:Boyfriend; // for worst endings
    public var mami:FlxSprite;
    public var bambi:FlxSprite;
    public var bfxthing:Int = 470;
    public var bfything:Int = 200;
    public var dave:FlxSprite;
//  public var systemalert:FlxText; // GUYS BAMBI TAKEOVER 1.5 IS A VIRUS DO NOT DOWNLOAD!?!?!?LKJDSFJKLFSDKLJFSD
//  god damnit the variable above was gonna be used for something but i forgot

    public function new(?isfucked:Bool = false)
    {
        if (isfucked)
            Sys.exit(0);
        super();
    }
    override public function create()
    {
        super.create();

        FlxG.autoPause = true;
        if (Lib.application.window.title != "Friday Night Funkin' Vs. Mami [FULL WEEK]")
            Lib.application.window.title = "Friday Night Funkin' Vs. Mami [FULL WEEK]";
        if (FlxG.save.data.newending)
        {
            switch (ending)
            {
                case 'skill issue':
                    mami = new FlxSprite(407, 38).loadGraphic(Paths.image('lookinleft', 'shared'));
                    mami.setGraphicSize(Std.int(mami.height * 0.47));
                    mami.antialiasing = true;
                    dave = new FlxSprite(278, 104).loadGraphic(Paths.image('awhen anime isnt real', 'shared'));
                    dave.setGraphicSize(Std.int(dave.height * 0.349));
                    dave.antialiasing = true;
                    bfxthing = 700;
                    bfything = 160;
            /*  case 'ascended':
                    eduardo = new Character(213, -13, 'edward');
                    eduardo.playAnim('idle');
                    eduardo.setGraphicSize(Std.int(eduardo.height * 0.25));
                    mami = new FlxSprite(439, 48).loadGraphic(Paths.image('lookinleft', 'shared'));
                    mami.setGraphicSize(Std.int(mami.height * 0.449));
                    mami.antialiasing = true;
                    new FlxTimer().start(1.287850, function(tmr:FlxTimer)
                    {
                        well();
                        new FlxTimer().start(2.6, function(tmr:FlxTimer)
                        {
                            FlxG.sound.playMusic(Paths.music('freakyMenu'));
                            LoadingState.loadAndSwitchState(new MainMenuState());
                        }); 
                    }); */ // dead eduardo meme
                case 'headshot':
                    bfxthing = 700;
                    bfything = 160;
                    dave = new FlxSprite(188, 17);
                    dave.frames = Paths.getSparrowAtlas('dave/Why', 'shared');
                    dave.animation.addByPrefix('uhh', 'What??????', 24, false);
                    dave.animation.play('uhh', true);
                    dave.setGraphicSize(Std.int(dave.height * 0.425));
                    dave.antialiasing = true;
                    mami = new FlxSprite(433, -96).loadGraphic(Paths.image('dave/oh my god', 'shared'));
                    mami.setGraphicSize(Std.int(mami.height * 0.26));
                    mami.antialiasing = true; 
                case 'worst':
                    bfxthing = 700;
                    bfything = 160;
                    bambi = new FlxSprite(592, 251);
                    bambi.loadGraphic(Paths.image('sad', 'shared'));
                    bambi.setGraphicSize(Std.int(bambi.height * 0.5));
                    bambi.antialiasing = true;
                    dave = new FlxSprite(176, 130);
                    dave.loadGraphic(Paths.image('awhen anime isnt real', 'shared'));
                    dave.setGraphicSize(Std.int(dave.height * 0.29));
                    dave.antialiasing = true;
                    mami = new FlxSprite(233, -18).loadGraphic(Paths.image('dave/what', 'shared'));
                    mami.setGraphicSize(Std.int(mami.height * 0.19));
                    mami.antialiasing = true;
                case 'pretakeover':
                    bfxthing = 700;
                    bfything = 160;
                    dave = new FlxSprite(246, 129);
                    dave.frames = (Paths.getSparrowAtlas('dave/oh no', 'shared'));
                    dave.animation.addByPrefix('oh no', 'oh no', 24, true);
                    dave.animation.play('oh no', true);
                    dave.setGraphicSize(Std.int(dave.height * 0.32));
                    dave.antialiasing = true;
                    mami = new FlxSprite(434, -93).loadGraphic(Paths.image('dave/oh my god', 'shared'));
                    mami.setGraphicSize(Std.int(mami.height * 0.256));
                    mami.antialiasing = true;
                case 'cheater':
                    bfxthing = 470;
                    bfything = 160;
                default:
                    bfxthing = 700;
                    bfything = 160;
            }
        }
        else
        {
            bfxthing = 470;
            bfything = 200;
        }
    /*  if (ending == 'skill issue')
        {
            mami = new FlxSprite(407, 38).loadGraphic(Paths.image('lookinleft', 'shared'));
            mami.setGraphicSize(Std.int(mami.height * 0.47));
            mami.antialiasing = true;
            dave = new FlxSprite(278, 104).loadGraphic(Paths.image('awhen anime isnt real', 'shared'));
            dave.setGraphicSize(Std.int(dave.height * 0.349));
            dave.antialiasing = true;
            bfxthing = 700;
            bfything = 160;
        }
        if (ending == 'ascended')
        {
            eduardo = new Character(213, -13, 'edward');
            eduardo.playAnim('idle');
            mami = new FlxSprite(439, 48).loadGraphic(Paths.image('lookinleft', 'shared'));
            mami.setGraphicSize(Std.int(mami.height * 0.449));
            mami.antialiasing = true;
            eduardo.setGraphicSize(Std.int(eduardo.height * 0.25));
            new FlxTimer().start(1.287850, function(tmr:FlxTimer)
            {
                well();
                new FlxTimer().start(2.6, function(tmr:FlxTimer)
                {
                    FlxG.sound.playMusic(Paths.music('freakyMenu'));
                    LoadingState.loadAndSwitchState(new MainMenuState());
                }); 
            });
        } */
        endingscene = new FlxSprite(0, 0);
        endingscene.loadGraphic(Paths.image('dave/' + ending.toUpperCase() + ' ENDING!!!', 'shared'));
        add(endingscene);

    //  add(dave);
    //  add(mami);
        
        if (ending == 'worst' || ending == 'pretakeover' || ending == 'headshot' || ending == 'cheater' || ending == 'amongus' || ending == 'skill issue')
        {
		    bf = new Boyfriend(1340, bfything);
            bf.setGraphicSize(Std.int(bf.width / 2));
		    add(bf);
        }
        FlxG.sound.playMusic(Paths.music(ending + 'Ending', 'shared'));
    }
    	
	override public function update(elapsed:Float):Void 
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
        {
            if (FlxG.save.data.newending)
            {
                switch (ending)
                {
                    case 'worst':
                        add(dave);
                        add(mami);
                        add(bambi);
                        bfslide();
                    case 'skill issue' | 'pretakeover':
                        add(dave);
                        add(mami);
                        bfslide();
                    case 'headshot':
                        add(dave);
                        add(mami);
                        dave.animation.play('uhh');
                        bfslide();
                    case 'cheater':
                        bfslide();
                    case 'pressing f1' | 'pressing 7':
                        skip();
                    case 'amongus':
                        FlxG.sound.music.stop();
                        TitleState.initialized = false;
                        LoadingState.loadAndSwitchState(new VideoState("assets/videos/john roblos.webm", new TitleState()));
                    default:
                        FlxG.sound.playMusic(Paths.music('freakyMenu'));
                        FlxG.switchState(new MainMenuState());
                }
            }
            else
            {
                switch (ending)
                {
                    case 'worst' | 'skill issue' | 'pretakeover' | 'headshot' | 'cheater':
                        bfslide();
                    case 'pressing f1' | 'pressing 7':
                        skip();
                    case 'amongus':
                        FlxG.sound.music.stop();
                        TitleState.initialized = false;
                        LoadingState.loadAndSwitchState(new VideoState("assets/videos/john roblos.webm", new TitleState()));
                    default:
                        FlxG.sound.playMusic(Paths.music('freakyMenu'));
                        FlxG.switchState(new MainMenuState());
                }
            }
        }
        if (FlxG.keys.justPressed.ESCAPE) // this is finally a thing now
        {
            if (ending == 'cheater' || ending.startsWith('pressing') || ending == 'skill issue' && PlayState.SONG.song.toLowerCase() == '81.281.1.192')
            {
                bfslide();
            }
            else
            {
                remove(endingscene);
                remove(bf);
                remove(dave);
                remove(bambi);
                remove(mami);
                FlxG.sound.music.stop();
                FlxG.switchState(new MainMenuState());
            }
        }
    }

    function skip()
    {
        PlayState.SONG = Song.loadFromJson('unfairness', 'unfairness'); // cause theres no other ending that will use this
        FlxG.sound.music.stop();
        FlxG.sound.play(Paths.music('gameOverEnd'));
        FlxG.camera.flash(FlxColor.WHITE, 0.5);
        remove(endingscene);
        new FlxTimer().start(0.1, function(tmr:FlxTimer)
        {
            LoadingState.loadAndSwitchState(new PlayState());
        });
    }
    function bfslide()
    {
        if (ending == 'cheater')
        {
            FlxG.save.data.cheaterew = true;
            PlayState.SONG = Song.loadFromJson('cheating', 'cheating');
        }
        FlxG.keys.enabled = false;
        FlxG.sound.music.stop();
        FlxG.camera.flash(FlxColor.WHITE, 0.5);
        remove(endingscene);
        FlxG.sound.play(Paths.music('gameOverEnd', 'shared'));
        bf.playAnim('idle', true);
        FlxTween.tween(bf, {
			x: bfxthing,
			y: bfything
		}, 1.2, {ease:FlxEase.cubeOut});

        if (FlxG.save.data.newending)
        {
            switch (ending)
            {
                case 'worst':
                    bambi.loadGraphic(Paths.image('sad', 'shared'));
                    FlxTween.angle(bambi, 300, 360, 0.3, {ease:FlxEase.cubeOut});
                default:
                    trace('nothing');
            }
            new FlxTimer().start(0.7, function(daveandbambi2point6:FlxTimer)
            {
                switch (ending)
                {
                    case 'headshot':
                        dave.frames = Paths.getSparrowAtlas('dave/Yeah 2', 'shared');
                        dave.animation.addByIndices('yeah', 'YEAH!', [6, 5, 4, 3, 2, 1], "", 24, false);
                        dave.animation.play('yeah', true);
                    case 'skill issue' | 'worst':
                        dave.loadGraphic(Paths.image('awhen bambi is there or something i dont know', 'shared'));
                        FlxTween.angle(dave, 350, 360, 0.25, {ease:FlxEase.cubeOut});
                    case 'pretakeover':
                        dave.frames = (Paths.getSparrowAtlas('dave/Yeah old version', 'shared'));
                        dave.animation.addByPrefix('yes', 'YEAH!', 24, true);
                        dave.animation.play('yes', true);
                        dave.setGraphicSize(Std.int(dave.height * 0.37));
                        FlxTween.angle(dave, 350, 360, 0.25, {ease:FlxEase.cubeOut});
                    default:
                        trace('something is supposed to happen here');
                }
            });
        }

        new FlxTimer().start(0.8, function(daveandbambi2point6:FlxTimer)
        {
            bf.playAnim('hey', true);
            if (ending == 'cheater' && FlxG.save.data.newending)
            {
                new FlxTimer().start(0.1, function(tmr:FlxTimer)
                {
                    FlxG.sound.play(Paths.soundRandom('missnote', 1, 3, 'shared'));
                    bf.playAnim('singLEFTmiss', true);
                });
            }
            new FlxTimer().start(0.85, function(tmr:FlxTimer)
            {
                FlxG.camera.fade(FlxColor.BLACK, 0.7, false, function()
                {
                    FlxG.keys.enabled = true;
                    LoadingState.loadAndSwitchState(new PlayState());
                });
            });
        });
    }
}