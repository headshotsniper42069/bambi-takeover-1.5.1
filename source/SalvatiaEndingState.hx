import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
#if desktop
import Sys;
#end

class SalvatiaEndingState extends FlxState
{
    public static var ending:String = '';
    public var endingscene:FlxSprite;
    public var bf:Boyfriend; // for worst ending
    public var systemalert:FlxText; // GUYS BAMBI TAKEOVER 1.5 IS A VIRUS DO NOT DOWNLOAD!?!?!?LKJDSFJKLFSDKLJFSD

    public function new() 
        {
            super();
        }

    override public function create()
    {
        super.create();
        endingscene = new FlxSprite(0, 0);
        endingscene.loadGraphic(Paths.image('dave/' + ending.toUpperCase() + ' ENDING!!!', 'shared'));
        add(endingscene);
        
        if (ending == 'worst' || ending == 'pretakeover' || ending == 'headshot' || ending == 'cheater')
        {
		    bf = new Boyfriend(1340, 200);
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
            if (ending == 'worst' || ending == 'pretakeover' || ending == 'headshot' || ending == 'cheater')
                bfslide();
            else if (ending == 'pressing f1' || ending == 'pressing 7')
                skip();
            else if (ending == 'amongus')
            {
                FlxG.sound.music.stop();
                TitleState.initialized = false;
                LoadingState.loadAndSwitchState(new VideoState("assets/videos/john roblos.webm", new TitleState()));
            }
            else
            {
                FlxG.sound.playMusic(Paths.music('freakyMenu'));
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
            PlayState.SONG = Song.loadFromJson('cheating', 'cheating');
        }
        FlxG.keys.enabled = false;
        FlxG.sound.music.stop();
        FlxG.camera.flash(FlxColor.WHITE, 0.5);
        remove(endingscene);
        FlxG.sound.play(Paths.music('gameOverEnd'));
        bf.playAnim('idle', true);
        FlxTween.tween(bf, {
			x: 470,
			y: 200
		}, 1.2, {ease:FlxEase.cubeOut});

        new FlxTimer().start(0.8, function(daveandbambi2point6:FlxTimer)
        {
            bf.playAnim('hey', true);
            new FlxTimer().start(0.5, function(tmr:FlxTimer)
            {
                FlxG.camera.fade(FlxColor.BLACK, 1.2, false, function()
                {
                    FlxG.keys.enabled = true;
                    LoadingState.loadAndSwitchState(new PlayState());
                });
            });
        });
    }
}