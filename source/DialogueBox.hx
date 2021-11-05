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
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';
	var curExpression:String = '';
	public var cutsceneimage:FlxSprite;
	var curLine:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	var skipText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitLeft2:FlxSprite;
	var portraitLeft3:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var fader:FlxSprite;
	var fader2:FlxSprite;
	

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			default:
				FlxG.sound.playMusic(Paths.music('Your_Sweet_Barista'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		cutsceneimage = new FlxSprite(0,0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);	
		cutsceneimage.setGraphicSize(1280,720);
		cutsceneimage.updateHitbox();
		cutsceneimage.screenCenter();
		cutsceneimage.visible = false;
		add(cutsceneimage);

		box = new FlxSprite(0, 425);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			default:
				hasDialog = true;
				box.loadGraphic(Paths.image('dabox'));
				box.animation.add('normalOpen',[0], 24, false);
				box.animation.add('normal', [0], 24, true);
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * 0.9));
		box.updateHitbox();
		box.alpha = 0;
		add(box);

		box.screenCenter(X);
		
		portraitLeft = new FlxSprite(100, 425);
		portraitLeft.frames = Paths.getSparrowAtlas('portraits/rosie portrait');
		portraitLeft.animation.addByPrefix('normal', 'rosie portrait rosie default', 24, false);
		portraitLeft.animation.addByPrefix('talking', 'rosie portrait rosie mouth open', 24, false);
		portraitLeft.animation.addByPrefix('smile', 'rosie portrait rosie smile 1', 24, false);
		portraitLeft.animation.addByPrefix('smile2', 'rosie portrait rosie smile 2', 24, false);
		portraitLeft.animation.addByPrefix('confused', 'rosie portrait rosie confused', 24, false);
		portraitLeft.animation.addByPrefix('sad', 'rosie portrait rosie sad', 24, false);
		portraitLeft.animation.addByPrefix('inlove1', 'rosie portrait rosie in love 1', 24, false);
		portraitLeft.animation.addByPrefix('inlove2', 'rosie portrait rosie in love 2', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitLeft2 = new FlxSprite(100, 425);
		portraitLeft2.frames = Paths.getSparrowAtlas('portraits/gf portrait');
		portraitLeft2.animation.addByPrefix('normal', 'gf portrait gf default', 24, false);
		portraitLeft2.animation.addByPrefix('talking', 'gf portrait gf mouth open', 24, false);
		portraitLeft2.animation.addByPrefix('smile', 'gf portrait gf smile', 24, false);
		portraitLeft2.animation.addByPrefix('confused', 'gf portrait gf confused', 24, false);
		portraitLeft2.animation.addByPrefix('sad', 'gf portrait gf sad', 24, false);
		portraitLeft2.animation.addByPrefix('yeah', 'gf portrait gf yeah 1', 24, false);
		portraitLeft2.animation.addByPrefix('yeah2', 'gf portrait gf yeah 2', 24, false);
		portraitLeft2.setGraphicSize(Std.int(portraitLeft2.width * 0.9));
		portraitLeft2.updateHitbox();
		portraitLeft2.scrollFactor.set();
		add(portraitLeft2);
		portraitLeft2.visible = false;

		portraitLeft3 = new FlxSprite(100, 425);
		portraitLeft3.frames = Paths.getSparrowAtlas('portraits/alucard portrait');
		portraitLeft3.animation.addByPrefix('normal', 'alucard portrait alucard default', 24, false);
		portraitLeft3.animation.addByPrefix('talking', 'alucard portrait alucard mouth open', 24, false);
		portraitLeft3.animation.addByPrefix('smile', 'alucard portrait alucard smile', 24, false);
		portraitLeft3.animation.addByPrefix('confused', 'alucard portrait alucard confused', 24, false);
		portraitLeft3.animation.addByPrefix('sad', 'alucard portrait alucard sad', 24, false);
		portraitLeft3.animation.addByPrefix('inlove1', 'alucard portrait alucard in love 1', 24, false);
		portraitLeft3.animation.addByPrefix('inlove2', 'alucard portrait alucard in love 2', 24, false);
		portraitLeft3.animation.addByPrefix('fear', 'alucard portrait alucard fear', 24, false);
		portraitLeft3.setGraphicSize(Std.int(portraitLeft3.width * 0.9));
		portraitLeft3.updateHitbox();
		portraitLeft3.scrollFactor.set();
		add(portraitLeft3);
		portraitLeft3.visible = false;

		portraitRight = new FlxSprite(100, 425);
		portraitRight.frames = Paths.getSparrowAtlas('portraits/bf portrait');
		portraitRight.animation.addByPrefix('normal', 'bf portrait bf default', 24, false);
		portraitRight.animation.addByPrefix('talking', 'bf portrait bf mouth open', 24, false);
		portraitRight.animation.addByPrefix('smile', 'bf portrait bf smile', 24, false);
		portraitRight.animation.addByPrefix('confused', 'bf portrait bf confused', 24, false);
		portraitRight.animation.addByPrefix('sad', 'bf portrait bf sad', 24, false);
		portraitRight.animation.addByPrefix('yeah', 'bf portrait bf yeah 1', 24, false);
		portraitRight.animation.addByPrefix('yeah2', 'bf portrait bf yeah 2', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox', 'week6'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(372, 527, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'VeniceClassic.ttf';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(370, 525, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'VeniceClassic.ttf';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);

		skipText = new FlxText(0, 0, Std.int(FlxG.width * 0.6), "Press Shift to Skip", 32);
		skipText.font = 'vcr.ttf';
		skipText.color = FlxColor.BLACK;
		add(skipText);

		fader = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
		fader.screenCenter();
		add(fader);
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
				FlxTween.tween(fader, {alpha: 0}, .75, {
					ease: FlxEase.quadInOut,
					onComplete: function(twn:FlxTween)
					{
						if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
							{
								box.animation.play('normal');
								dialogueOpened = true;
							}
					}
				  });
			}
			

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ENTER  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						cutsceneimage.alpha -= 1 / 5;
						box.alpha -= 1 / 5;
						handSelect.alpha -= 1 / 5;
						portraitLeft.visible = false;
						portraitLeft2.visible = false;
						portraitLeft3.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
						skipText.alpha = swagDialogue.alpha;
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

		if (FlxG.keys.justPressed.SHIFT  && dialogueStarted == true)
		{
			if (!isEnding)
				{
					isEnding = true;

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						cutsceneimage.alpha -= 1 / 5;
						box.alpha -= 1 / 5;
						portraitLeft.visible = false;
						portraitLeft2.visible = false;
						portraitLeft3.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
						skipText.alpha -= 1 / 5;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						dialogueList.remove(dialogueList[0]);
						finishThing();
						kill();
					});
				}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		var effects:Array<String> = ['bgonly', 'sound', 'shift', 'fade'];

		fader2 = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
		fader2.screenCenter();
		fader2.alpha = 0;
		add(fader2);

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'coffee-shop':
				cutsceneimage.loadGraphic(Paths.image('cutscenes/Act1/c' + curLine, 'shared'));
				cutsceneimage.visible = true;
				cutsceneimage.antialiasing = true;
				cutsceneimage.updateHitbox();
			case 'bubble-tea':
				cutsceneimage.loadGraphic(Paths.image('cutscenes/Act2/c' + curLine, 'shared'));
				cutsceneimage.visible = true;
				cutsceneimage.antialiasing = true;
				cutsceneimage.updateHitbox();
			case 'love-shortcake':
				cutsceneimage.loadGraphic(Paths.image('cutscenes/Act3/c' + curLine, 'shared'));
				cutsceneimage.visible = true;
				cutsceneimage.antialiasing = true;
				cutsceneimage.updateHitbox();
			case 'girl-from-the-cafe':
				cutsceneimage.loadGraphic(Paths.image('cutscenes/Act4/c' + curLine, 'shared'));
				cutsceneimage.visible = true;
				cutsceneimage.antialiasing = true;
				cutsceneimage.updateHitbox();
		}

		if(effects.contains(curCharacter))
		{
			swagDialogue.resetText(dialogueList[0]);
			swagDialogue.start(0.04, true);
			switch (curCharacter)
			{
				case 'bgonly':
					hideDialogue();
					portraitRight.visible = false;
					portraitLeft2.visible = false;
					portraitLeft3.visible = false;
					portraitLeft.visible = false;
				case 'sound':
					FlxG.sound.play(Paths.sound(dialogueList[0]));
					dialogueList.remove(dialogueList[0]);
					startDialogue();
				case 'shift':
					dialogueList.remove(dialogueList[0]);
					startDialogue();
				case 'fade':
					hideDialogue();
					dialogueList.remove(dialogueList[0]);
					FlxTween.tween(fader2, {alpha: 1}, 1, {
						ease: FlxEase.quadInOut,
						onComplete: function(twn:FlxTween)
						{
							new FlxTimer().start(0.05, function(tmr:FlxTimer)
							{
								startDialogue();
							});	
							FlxTween.tween(fader2, {alpha: 0}, 1, {ease: FlxEase.quadInOut});
						}
					});
			}
		}
		else
		{
			
			swagDialogue.resetText(dialogueList[0]);
			if (box.alpha == 0)
			{
				FlxTween.tween(box, {alpha: 0.7}, .75, {
					ease: FlxEase.quadInOut,
					onComplete: function(twn:FlxTween)
					{
						showDialogue();
						swagDialogue.start(0.04, true);
					}
				});
			}
			else
			{
				showDialogue();
				swagDialogue.start(0.04, true);
			}
			

			switch (curCharacter)
			{
				case 'rosie':
					swagDialogue.color = FlxColor.PINK;
					dropText.color = FlxColor.BLACK;
					if (curExpression != '')
						{
						portraitLeft.animation.play(curExpression);
						}
					portraitRight.visible = false;
					portraitLeft2.visible = false;
					portraitLeft3.visible = false;
					if (!portraitLeft.visible)
					{
						portraitLeft.visible = true;
					}
				case 'bf':
					swagDialogue.color = FlxColor.BLUE;
					dropText.color = 0xFFD89494;
					if (curExpression != '')
						{
						portraitRight.animation.play(curExpression);
						}
					portraitLeft.visible = false;
					portraitLeft2.visible = false;
					portraitLeft3.visible = false;
					if (!portraitRight.visible)
					{
						portraitRight.visible = true;
					}
				case 'gf':
					swagDialogue.color = FlxColor.RED;
					dropText.color = 0xFFD89494;
					if (curExpression != '')
						{
						portraitLeft2.animation.play(curExpression);
						}
					portraitRight.visible = false;
					portraitLeft.visible = false;
					portraitLeft3.visible = false;
					if (!portraitLeft2.visible)
					{
						portraitLeft2.visible = true;
					}
				case 'alucard':
					swagDialogue.color = FlxColor.PURPLE;
					dropText.color = 0xFFD89494;
					if (curExpression != '')
						{
						portraitLeft3.animation.play(curExpression);
						}
					portraitRight.visible = false;
					portraitLeft.visible = false;
					portraitLeft2.visible = false;
					if (!portraitLeft3.visible)
					{
						portraitLeft3.visible = true;
					}
			}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		curExpression = splitName[2];
		curLine = splitName[0];
		dialogueList[0] = dialogueList[0].substr(splitName[2].length + splitName[1].length + splitName[0].length + 3).trim();
	}

	function hideDialogue()
		{
			box.alpha = 0;
			portraitLeft.alpha = 0;
			portraitLeft2.alpha = 0;
			portraitLeft3.alpha = 0;
			portraitRight.alpha = 0;
			swagDialogue.alpha = 0;
			dropText.alpha = 0;
			handSelect.alpha = 0;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0)];
		}
	
	function showDialogue()
		{
			box.alpha = 0.7;
			portraitLeft.alpha = 0.9;
			portraitLeft2.alpha = 0.9;
			portraitLeft3.alpha = 0.9;
			portraitRight.alpha = 0.9;
			swagDialogue.alpha = 0.9;
			dropText.alpha = 0.9;
			handSelect.alpha = 0.9;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		}	
}
