package;

import openfl.geom.Matrix;
import openfl.display.BitmapData;
import flixel.system.FlxSound;
import flixel.util.FlxAxes;
import flixel.FlxSubState;
import Options.Option;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import io.newgrounds.NG;
import lime.app.Application;
import lime.utils.Assets;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.input.FlxKeyManager;


using StringTools;

class ResultsScreen extends FlxSubState
{
    public var text:FlxText;

    public var adviceText:FlxText;
    public var comboText:FlxText;
    public var contText:FlxText;
    public var settingsText:FlxText;

    public var music:FlxSound;

    var winFinished:Bool = false;

    public var ranking:String;
    public var accuracy:String;

	override function create()
	{	
        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		add(bg);

		var scrolluwu = new FlxSprite(0, 0).loadGraphic(Paths.image("CheckerBlue"), false, 1, 1, false);
		scrolluwu.screenCenter();

		add(scrolluwu);
	
		FlxTween.tween(scrolluwu, { x: -1000, y: -500 }, 50, { type: FlxTweenType.LOOPING, loopDelay: 0 });

		var scrolluwu = new FlxSprite(0, 0).loadGraphic(Paths.image("CheckerBlue"), false, 1, 1, false);
		scrolluwu.screenCenter();

		add(scrolluwu);
	
		FlxTween.tween(scrolluwu, { x: -2000, y: -1000 }, 50, { type: FlxTweenType.LOOPING, loopDelay: 0 });

            var tex:FlxSprite = new FlxSprite();
            tex.frames = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
            tex.animation.addByPrefix('hey', 'BF HEY', 24, false);
            tex.animation.play('hey');
            add(tex);
            tex.screenCenter();

            music = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
            music.volume = 0;
            music.play(false, FlxG.random.int(0, Std.int(music.length / 2)));
    
            text = new FlxText(20,-55,0,"Track Complete!");
            text.size = 34;
            text.setBorderStyle(FlxTextBorderStyle.OUTLINE,FlxColor.BLACK,4,1);
            text.color = FlxColor.WHITE;
            text.scrollFactor.set();
            add(text);
    
            var score = PlayState.instance.songScore;
            if (PlayState.isStoryMode)
            {
                score = PlayState.campaignScore;
                text.text = "Week Complete!";
            }
    
            comboText = new FlxText(20,-75,0,'Judgements:\nSicks - ${PlayState.sicks}\nGoods - ${PlayState.goods}\nBads - ${PlayState.bads}\n\nCombo Breaks: ${(PlayState.isStoryMode ? PlayState.campaignMisses : PlayState.misses) + PlayState.shits}\nHighest Combo: ${PlayState.highestCombo + 1}\n\nScore: ${PlayState.instance.songScore}\nAccuracy: ${HelperFunctions.truncateFloat(PlayState.instance.accuracy,2)}%\n\n${Ratings.GenerateLetterRank(PlayState.instance.accuracy)}\n\nF1 - View replay\nF2 - Replay song
            ');
            comboText.size = 28;
            comboText.setBorderStyle(FlxTextBorderStyle.OUTLINE,FlxColor.BLACK,4,1);
            comboText.color = FlxColor.WHITE;
            comboText.scrollFactor.set();
            add(comboText);

            adviceText = new FlxText();
            adviceText.setBorderStyle(FlxTextBorderStyle.OUTLINE,FlxColor.BLACK,4,1);
            adviceText.size = 28;
            adviceText.color = FlxColor.WHITE;
            adviceText.scrollFactor.set();
            adviceText.screenCenter(X);
            adviceText.y = 100;
            add(adviceText);

            switch(Ratings.GenerateLetterRank(PlayState.instance.accuracy))
            {
                case 'AAAAA':
                    adviceText.text = "nuts";
                case 'AAAA:':
                    adviceText.text = "nuts";
                case 'AAAA.':
                    adviceText.text = "nuts";
                case 'AAAA':
                    adviceText.text = "nuts";
                case 'AAA:':
                    adviceText.text = "nuts";
                case 'AAA.':
                    adviceText.text = "nuts";
                case 'AAA':
                    adviceText.text = "nuts";
                case 'AA:':
                    adviceText.text = "nuts";
                case 'AA.':
                    adviceText.text = "nuts";
                case 'AA':
                    adviceText.text = "nuts";
                case 'A:':
                    adviceText.text = "nuts";
                case 'A.':
                    adviceText.text = "nuts";
                case 'A':
                    adviceText.text = "nuts";
                case 'B':
                    adviceText.text = "nuts";
                case 'C':
                    adviceText.text = "nuts";
                case 'D':
                    adviceText.text = "nuts";
            }
            
            adviceText.size = 28;
            adviceText.setBorderStyle(FlxTextBorderStyle.OUTLINE,FlxColor.BLACK,4,1);
            adviceText.color = FlxColor.WHITE;
            adviceText.scrollFactor.set();
            add(adviceText);
    
            contText = new FlxText(FlxG.width - 475,FlxG.height + 50,0,'Press ENTER to continue.');
            contText.size = 28;
            contText.setBorderStyle(FlxTextBorderStyle.OUTLINE,FlxColor.BLACK,4,1);
            contText.color = FlxColor.WHITE;
            contText.scrollFactor.set();
            add(contText);
        
            var sicks = HelperFunctions.truncateFloat(PlayState.sicks / PlayState.goods,1);
            var goods = HelperFunctions.truncateFloat(PlayState.goods / PlayState.bads,1);
    
            if (sicks == Math.POSITIVE_INFINITY)
                sicks = 0;
            if (goods == Math.POSITIVE_INFINITY)
                goods = 0;
    
            var mean:Float = 0;
    
    
            for (i in PlayState.rep.replay.songNotes)
            {
                // 0 = time
                // 1 = length
                // 2 = type
                // 3 = diff
                var diff = i[3];
                var judge = Ratings.CalculateRating(diff, Math.floor((PlayState.rep.replay.sf / 60) * 1000));
                mean += diff;
            }

            mean = HelperFunctions.truncateFloat(mean / PlayState.rep.replay.songNotes.length,2);
    
            settingsText = new FlxText(20,FlxG.height + 50,0,'SF: ${PlayState.rep.replay.sf} | Ratio (SA/GA): ${Math.round(sicks)}:1 ${Math.round(goods)}:1 | Mean: ${mean}ms | Played on ${PlayState.SONG.song} ${CoolUtil.difficultyString()}');
            settingsText.size = 16;
            settingsText.setBorderStyle(FlxTextBorderStyle.OUTLINE,FlxColor.BLACK,2,1);
            settingsText.color = FlxColor.WHITE;
            settingsText.scrollFactor.set();
            add(settingsText);
    
    
            FlxTween.tween(text, {y:20},0.5,{ease: FlxEase.expoInOut});
            FlxTween.tween(comboText, {y:145},0.5,{ease: FlxEase.expoInOut});
            FlxTween.tween(contText, {y:FlxG.height - 45},0.5,{ease: FlxEase.expoInOut});
            FlxTween.tween(settingsText, {y:FlxG.height - 35},0.5,{ease: FlxEase.expoInOut});
    
            cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
    
            super.create();
	}


    var frames = 0;

	override function update(elapsed:Float)
	{
        if (music.volume < 0.5)
			music.volume += 0.01 * elapsed;

        // render
        if (frames != 2)
        {
            frames++;
        }
        // keybinds

        if (FlxG.keys.justPressed.ENTER)
        {
            music.fadeOut(0.3);
            
            PlayState.loadRep = false;
            PlayState.rep = null;

            if (PlayState.isStoryMode)
            {
                FlxG.sound.playMusic(Paths.music('freakyMenu'));
                FlxG.switchState(new MainMenuState());
            }
            else
                FlxG.switchState(new FreeplayState());
        }

        if (FlxG.keys.justPressed.F1)
        {
            trace(PlayState.rep.path);
            PlayState.rep = Replay.LoadReplay(PlayState.rep.path);

            PlayState.loadRep = true;

            var songFormat = StringTools.replace(PlayState.rep.replay.songName, " ", "-");
            switch (songFormat) {
                case 'Dad-Battle': songFormat = 'Dadbattle';
                case 'Philly-Nice': songFormat = 'Philly';
                    // Replay v1.0 support
                case 'dad-battle': songFormat = 'Dadbattle';
                case 'philly-nice': songFormat = 'Philly';
            }

            var poop:String = Highscore.formatSong(songFormat, PlayState.rep.replay.songDiff);

            music.fadeOut(0.3);

            PlayState.SONG = Song.loadFromJson(poop, PlayState.rep.replay.songName);
            PlayState.isStoryMode = false;
            PlayState.storyDifficulty = PlayState.rep.replay.songDiff;
            PlayState.storyWeek = 0;
            LoadingState.loadAndSwitchState(new PlayState());
        }

        if (FlxG.keys.justPressed.F2 )
        {
            PlayState.rep = null;

            PlayState.loadRep = false;

            var songFormat = StringTools.replace(PlayState.SONG.song, " ", "-");
            switch (songFormat) {
                case 'Dad-Battle': songFormat = 'Dadbattle';
                case 'Philly-Nice': songFormat = 'Philly';
                case 'dad-battle': songFormat = 'Dadbattle';
                case 'philly-nice': songFormat = 'Philly';
            }

            var poop:String = Highscore.formatSong(songFormat, PlayState.storyDifficulty);

            music.fadeOut(0.3);

            PlayState.SONG = Song.loadFromJson(poop, PlayState.SONG.song);
            PlayState.isStoryMode = false;
            PlayState.storyDifficulty = PlayState.storyDifficulty;
            PlayState.storyWeek = 0;
            LoadingState.loadAndSwitchState(new PlayState());
        }

		super.update(elapsed);
		
	}
}
