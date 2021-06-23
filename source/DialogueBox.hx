package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';
	var curSong:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitGf:FlxSprite;
	var portraitLeft:FlxSprite;
	var portraitBf:FlxSprite;

	var dialogueImage:FlxSprite;

	var speech:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;
	var currentCutImage:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'roses':
				FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'prologue':
					FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'tutorial':
				FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'bopeebo':
				FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'fresh':
				FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'dadbattle':
				FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'spookeez':
				FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'south':
				FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);	
			case 'monster':
				FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);	
				case 'pico':
					FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'philly':
					FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'blammed':
					FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'satin-panties':
					FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'high':
					FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);	
				case 'milf':
					FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);			
					case 'cocoa':
						FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
						FlxG.sound.music.fadeIn(1, 0, 0.8);
					case 'eggnog':
						FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
						FlxG.sound.music.fadeIn(1, 0, 0.8);	
					case 'winter-horrorland':
						FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 0);
						FlxG.sound.music.fadeIn(1, 0, 0.8);		
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		dialogueImage = new FlxSprite(0, 0);
		dialogueImage.antialiasing = true;
		add(dialogueImage);	
		dialogueImage.visible = false;

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		speech = new FlxSprite(100, 315);
		speech.scale.set(0.7, 0.7);
		speech.frames = Paths.getSparrowAtlas('talk', 'shared');
		speech.animation.addByPrefix('bf', 'bf', 24, false);
		speech.animation.addByPrefix('bfdizzy', 'bfdizzy', 24, false);
		speech.animation.addByPrefix('bfhey', 'bfhey', 24, false);
		speech.animation.addByPrefix('bfmiss', 'bfmiss', 24, false);
		speech.animation.addByPrefix('bfready', 'bfready', 24, false);
		speech.animation.addByPrefix('bfscared', 'bfscared', 24, false);
		speech.animation.addByPrefix('bfwoah', 'bfwoah', 24, false);
		speech.animation.addByPrefix('bfyeah', 'bfyeah', 24, false);
		speech.animation.addByPrefix('dad', 'dad', 24, false);
		speech.animation.addByPrefix('eye', 'eye', 24, false);
		speech.animation.addByPrefix('gf', 'gf', 24, false);
		speech.animation.addByPrefix('gfcry', 'gfcry', 24, false);
		speech.animation.addByPrefix('gfduck', 'gfduck', 24, false);
		speech.animation.addByPrefix('gffear', 'gffear', 24, false);
		speech.animation.addByPrefix('gfhappy', 'gfhappy', 24, false);
		speech.animation.addByPrefix('gfwink', 'gfwink', 24, false);
		speech.animation.addByPrefix('jupiter', 'jupiter', 24, false);
		speech.animation.addByPrefix('mm', 'mm', 24, false);
		speech.animation.addByPrefix('neptune', 'neptune', 24, false);
		speech.animation.addByPrefix('pico', 'pico', 24, false);
		speech.animation.addByPrefix('sword', 'sword', 24, false);
		add(speech);

		box = new FlxSprite(100, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'tutorial':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;
				case 'prologue':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
					box.width = 400;
					box.height = 400;
					box.x = 95;
					box.y = 435;
			case 'bopeebo':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;
			case 'fresh':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;
			case 'dad battle':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;
			case 'spookeez':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;
			case 'south':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;	
			case 'monster':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;
			case 'pico':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;
			case 'philly nice':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;	
			case 'blammed':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 400;
				box.height = 400;
				box.x = 95;
				box.y = 435;	
				case 'satin panties':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
					box.width = 400;
					box.height = 400;
					box.x = 95;
					box.y = 435;
				case 'high':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
					box.width = 400;
					box.height = 400;
					box.x = 95;
					box.y = 435;	
				case 'milf':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
					box.width = 400;
					box.height = 400;
					box.x = 95;
					box.y = 435;
				case 'cocoa':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
					box.width = 400;
					box.height = 400;
					box.x = 95;
					box.y = 435;
				case 'eggnog':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
					box.width = 400;
					box.height = 400;
					box.x = 95;
					box.y = 435;	
				case 'winter horrorland':
					hasDialog = true;
					box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
					box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
					box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
					box.width = 400;
					box.height = 400;
					box.x = 95;
					box.y = 435;					
		}

		this.dialogueList = dialogueList;

		if (!hasDialog)
			return;

			portraitLeft = new FlxSprite(-150, 20);
			portraitLeft.frames = Paths.getSparrowAtlas('dd', 'shared');
			portraitLeft.animation.addByPrefix('normal', 'Normal', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitBf = new FlxSprite(600, 190);
			portraitBf.frames = Paths.getSparrowAtlas('portraits/bfnormal', 'shared');
			portraitBf.animation.addByPrefix('normal', 'Normal', 24, false);
			portraitBf.setGraphicSize(Std.int(portraitBf.width * PlayState.daPixelZoom * 0.175));
			portraitBf.updateHitbox();
			portraitBf.scrollFactor.set();
			add(portraitBf);
			portraitBf.visible = false;

			portraitGf = new FlxSprite(50, 190);
			portraitGf.frames = Paths.getSparrowAtlas('portraits/gfnormal', 'shared');
			portraitGf.animation.addByPrefix('normal', 'Normal', 24, false);
			portraitGf.setGraphicSize(Std.int(portraitGf.width * PlayState.daPixelZoom * 0.175));
			portraitGf.updateHitbox();
			portraitGf.scrollFactor.set();
			add(portraitGf);
			portraitGf.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		portraitLeft.screenCenter(X);

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(192, 462, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Nunito Black';
		dropText.color = 0xFFC2C2C2;
		add(dropText);

		swagDialogue = new FlxTypeText(190, 460, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Nunito Black';
		swagDialogue.color = 0xFF121212;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90; 
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')

			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		
		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'roses')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;
	var index = 0; 
	function startDialogue():Void
	{
		cleanDialog();
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curSong)
		{
			case 'ghostfight':
				FlxG.sound.playMusic(Paths.music('Undertale OST 010 - Ghost Fight'), 1);
				case 'endmusic':
					if (FlxG.sound.music.playing)
						{
							FlxG.sound.music.stop();
						}							
						case 'snowdin':
							FlxG.sound.playMusic(Paths.music('Undertale OST 022 - Snowdin Town'), 1);		
							case 'shop':
								FlxG.sound.playMusic(Paths.music('Undertale OST 023 - Shop'), 1);
								case 'datestart':
									FlxG.sound.playMusic(Paths.music('Undertale OST 025 - Dating Start!'), 1);
									case 'datetense':
										FlxG.sound.playMusic(Paths.music('Undertale OST 026 - Dating Tense!'), 1);
										case 'datefight':
											FlxG.sound.playMusic(Paths.music('Undertale OST 027 - Dating Fight!'), 1);
											case 'temshop':
												FlxG.sound.playMusic(Paths.music('Undertale OST 044 - Tem Shop'), 1);
												case 'showtime':
													FlxG.sound.playMusic(Paths.music('Undertale OST 049 - Its Showtime!'), 1);
													case 'stronger':
														FlxG.sound.playMusic(Paths.music('Undertale OST 053 - Stronger Monsters'), 1);
														case 'hotel':
														FlxG.sound.playMusic(Paths.music('Undertale OST 054 - Hotel'), 1);
		}

		switch (curCharacter)
		{ 
			case 'dad': // he's fine // MOVE ALL THE OPPONENTS TO GF POS
				portraitBf.visible = false;
				portraitGf.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/dd', 'shared');
				portraitLeft.x = 50;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dearestText'), 0.6)];
				swagDialogue.color = 0xFF575757;
				speech.animation.play('dad');
				speech.x = 625;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('Normal');
				}
				case 'neptune': // move this up a bit
					portraitBf.visible = false;
					portraitGf.visible = false;
					portraitLeft.frames = Paths.getSparrowAtlas('portraits/space', 'shared');
					portraitLeft.x = 70;
					portraitLeft.y = 30;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pumpText'), 0.6)];
					swagDialogue.color = 0xFF007FBF;
					speech.animation.play('neptune');
					speech.x = 625;
					if (!portraitLeft.visible)
					{
						portraitLeft.visible = true;
						portraitLeft.animation.play('Normal');
					}
					case 'jupiter': // move this up a bit
					portraitBf.visible = false;
					portraitGf.visible = false;
					portraitLeft.frames = Paths.getSparrowAtlas('portraits/space', 'shared');
					portraitLeft.x = 70;
					portraitLeft.y = 30;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('skidText'), 0.6)];
					swagDialogue.color = 0xFFEB6600;
					speech.animation.play('jupiter');
					speech.x = 625;
					if (!portraitLeft.visible)
					{
						portraitLeft.visible = true;
						portraitLeft.animation.play('Normal');
					}
					case 'pico': // move this down lmfao
						portraitBf.visible = false;
						portraitGf.visible = false;
						portraitLeft.frames = Paths.getSparrowAtlas('portraits/pcio', 'shared');
						portraitLeft.x = 100;
						portraitLeft.y = 140;
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('picoText'), 0.6)];
						swagDialogue.color = 0xFFEBE700;
						speech.animation.play('pico');
						speech.x = 625;
						if (!portraitLeft.visible)
						{
							portraitLeft.visible = true;
							portraitLeft.animation.play('Normal');
						}
						case 'mm': // fine
							portraitBf.visible = false;
							portraitGf.visible = false;
							portraitLeft.frames = Paths.getSparrowAtlas('portraits/mmm', 'shared');
							portraitLeft.x = 90;
							portraitLeft.y = 20;
							swagDialogue.sounds = [FlxG.sound.load(Paths.sound('momText'), 0.6)];
							swagDialogue.color = 0xFFFF36AE;
							speech.animation.play('mm');
							speech.x = 625;
							if (!portraitLeft.visible)
							{
								portraitLeft.visible = true;
								portraitLeft.animation.play('Normal');
							}
							case 'sword': // fine
								portraitBf.visible = false;
								portraitGf.visible = false;
								portraitLeft.frames = Paths.getSparrowAtlas('portraits/swoxrd', 'shared');
								portraitLeft.x = 50;
								portraitLeft.y = 20;
								swagDialogue.color = 0xFFC7C7C7;
								speech.animation.play('sword');
								speech.x = 625;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.animation.play('Normal');
								}
								case 'eye': // fine
									portraitBf.visible = false;
									portraitGf.visible = false;
									portraitLeft.frames = Paths.getSparrowAtlas('portraits/ey', 'shared');
									portraitLeft.x = 50;
									portraitLeft.y = 20;
									swagDialogue.color = 0xFF1D47D1;  
									speech.animation.play('eye');
									speech.x = 625;
									if (!portraitLeft.visible)
									{
										portraitLeft.visible = true;
										portraitLeft.animation.play('Normal');
									}
			case 'bf': //normal guy - move it up a bit			portraitBf = new FlxSprite(600, 190);
				portraitGf.visible = false;
				portraitLeft.visible = false;
				portraitBf.frames = Paths.getSparrowAtlas('portraits/bfnormal', 'shared');
				portraitBf.y = 160;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
				swagDialogue.color = 0xFF186EDE; 
				speech.animation.play('bf');
				if (!portraitBf.visible)
				{
					portraitBf.visible = true;
					portraitBf.animation.play('normal');
				}
				case 'bfdizzy': // bf dodge aaa - move it up a bit
					portraitGf.visible = false;
					portraitLeft.visible = false;
					portraitBf.frames = Paths.getSparrowAtlas('portraits/bfdizzy', 'shared');
					portraitBf.y = 170;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
					swagDialogue.color = 0xFF186EDE; 
					speech.animation.play('bf');
					if (!portraitBf.visible)
					{
						portraitBf.visible = true;
						portraitBf.animation.play('dizzy');
					}
					case 'bfhey': // bf peace - move this up a bit MORE
						portraitGf.visible = false;
						portraitLeft.visible = false;
						portraitBf.frames = Paths.getSparrowAtlas('portraits/bfhey', 'shared');
						portraitBf.y = 140;
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
						swagDialogue.color = 0xFF186EDE; 
						speech.animation.play('bf');
						if (!portraitBf.visible)
						{
							portraitBf.visible = true;
							portraitBf.animation.play('hey');
						}
						case 'bfmiss': //bf miss doy - move this like a lot more
							portraitGf.visible = false;
							portraitLeft.visible = false;
							portraitBf.frames = Paths.getSparrowAtlas('portraits/bfmiss', 'shared');
							portraitBf.y = 125;
							swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
							swagDialogue.color = 0xFF186EDE; 
							speech.animation.play('bf');
							speech.x = 100;
							if (!portraitBf.visible)
							{
								portraitBf.visible = true;
								portraitBf.animation.play('miss');
							}
							case 'bfready': // bf pre attack - this is fine but y'know just raise it a bit more
								portraitGf.visible = false;
								portraitLeft.visible = false;
								portraitBf.frames = Paths.getSparrowAtlas('portraits/bfready', 'shared');
								portraitBf.y = 165;
								swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
								swagDialogue.color = 0xFF186EDE; 
								speech.animation.play('bf');
								speech.x = 100;
								if (!portraitBf.visible)
								{
									portraitBf.visible = true;
									portraitBf.animation.play('ready');
								}	
								case 'bfscared': // bf scared weke 2 - raise it a bit more
									portraitGf.visible = false;
									portraitLeft.visible = false;
									portraitBf.frames = Paths.getSparrowAtlas('portraits/bfscared', 'shared');
									portraitBf.y = 155;
									swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
									swagDialogue.color = 0xFF186EDE; 
									speech.animation.play('bf');
									speech.x = 100;
									if (!portraitBf.visible)
									{
										portraitBf.visible = true;
										portraitBf.animation.play('scared');
									}
									case 'bfwoah': // bf dodge like woah - this guy is literally eating the dialogue box move it way up
										portraitGf.visible = false;
										portraitLeft.visible = false;
										portraitBf.frames = Paths.getSparrowAtlas('portraits/bfwoah', 'shared');
										portraitBf.y = 110;
										swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
										swagDialogue.color = 0xFF186EDE; 
										speech.animation.play('bf');
										speech.x = 100;
										if (!portraitBf.visible)
										{
											portraitBf.visible = true;
											portraitBf.animation.play('woah');
										}
										case 'bfyeah': // bf mic throw - okay i am done move this guy WAYYY UP like it's under the box 
											portraitGf.visible = false;
											portraitLeft.visible = false;
											portraitBf.frames = Paths.getSparrowAtlas('portraits/bfyeah', 'shared');
											portraitBf.y = -70;
											portraitBf.x = 560;
											swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
											swagDialogue.color = 0xFF186EDE; 
											speech.animation.play('bf');
											speech.x = 100;
											if (!portraitBf.visible)
											{
												portraitBf.visible = true;
												portraitBf.animation.play('yeah');
											}
				case 'gf': // normal gorl - move it right and up a bit
					portraitBf.visible = false;
					portraitLeft.visible = false;
					portraitGf.frames = Paths.getSparrowAtlas('portraits/gfnormal', 'shared');
					portraitGf.y = 120;
					portraitGf.x = 100;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
					swagDialogue.color = 0xFFF21A6;
					speech.animation.play('gf');
					speech.x = 625;
					if (!portraitGf.visible)
					{
						portraitGf.visible = true;
						portraitGf.animation.play('normal');
					}
					case 'gfcry': // gf sad - same as top 			portraitGf = new FlxSprite(50, 190);
						portraitBf.visible = false;
						portraitLeft.visible = false;
						portraitGf.frames = Paths.getSparrowAtlas('portraits/gfcry', 'shared');
						portraitGf.y = 120;
						portraitGf.x = 120;
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
						swagDialogue.color = 0xFFF21A6;
						speech.animation.play('gf');
						speech.x = 625;
						if (!portraitGf.visible)
						{
							portraitGf.visible = true;
							portraitGf.animation.play('cry');
						}
						case 'gfduck': // unused duck for battl - just move this to the right
							portraitBf.visible = false;
							portraitLeft.visible = false;
							portraitGf.frames = Paths.getSparrowAtlas('portraits/gfduck', 'shared');
							portraitGf.y = 100;
							portraitGf.x = 50;
							swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
							swagDialogue.color = 0xFFF21A6;
							speech.animation.play('gf');
							speech.x = 625;
							if (!portraitGf.visible)
							{
								portraitGf.visible = true;
								portraitGf.animation.play('duck');
							}
							case 'gffear': // gf scared week 2 - move it to the right and up some more lol!
								portraitBf.visible = false;
								portraitLeft.visible = false;
								portraitGf.frames = Paths.getSparrowAtlas('portraits/gfscared', 'shared');
								portraitGf.y = 100;
								portraitGf.x = 130;
								swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
								swagDialogue.color = 0xFFF21A6;
								speech.animation.play('gf');
								speech.x = 625;
								if (!portraitGf.visible)
								{
									portraitGf.visible = true;
									portraitGf.animation.play('fear');
								}
								case 'gfhappy': //gf cheer lole! - move it to the right and up some more lol!
									portraitBf.visible = false;
									portraitLeft.visible = false;
									portraitGf.frames = Paths.getSparrowAtlas('portraits/gfhappy', 'shared');
									portraitGf.y = 90;
									portraitGf.x = 30;
									swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
									swagDialogue.color = 0xFFF21A6;
									speech.animation.play('gf');
									speech.x = 625;
									if (!portraitGf.visible)
									{
										portraitGf.visible = true;
										portraitGf.animation.play('happy');
									}
									case 'gfwink': // gf right pose but wink is cute - move it right then move it up a bit more
										portraitBf.visible = false;
										portraitLeft.visible = false;
										portraitGf.frames = Paths.getSparrowAtlas('portraits/gfwink', 'shared');
										portraitGf.y = 90;
										portraitGf.x = 30;
										swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
										swagDialogue.color = 0xFFF21A6;
										speech.animation.play('gf');
										speech.x = 625;
										if (!portraitGf.visible)
										{
											portraitGf.visible = true;
											portraitGf.animation.play('wink');
										}
		}
	}
	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();

		var splitSong:Array<String> = dialogueList[0].split("|");
		curSong = splitSong[1];
		dialogueList[0] = dialogueList[0].substr(splitSong[1].length + 2).trim();
	}
}
