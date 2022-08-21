package;

import Controls.KeyboardScheme;
// import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
#if newgrounds
import io.newgrounds.NG;
#end
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{

	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'credits', 'options'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.5.1" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var miniRosie:Character;
	var camFollow:FlxObject;
	var diff = 1;
	var infoTxt:Array<String> = ['EASY', 'NORMAL', 'HARD'];
	var info:FlxText;
	public static var finishedFunnyMove:Bool = false;
	var menuarrowup:FlxSprite;
	var menuarrowdown:FlxSprite;
	var letsdoit:FlxSprite;
	var arrows:FlxTypedGroup<FlxSprite>;

	override function create()
	{
//		FlxG.camera.zoom = 1.5;
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.PINK);
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.scrollFactor.set();
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		var checkerboard:FlxSprite = new FlxSprite(0, 0);
		checkerboard.frames = Paths.getSparrowAtlas('title/checkerboard_pattern_movement');
		checkerboard.antialiasing = true;
		checkerboard.scrollFactor.set();
		checkerboard.screenCenter();
		checkerboard.animation.addByPrefix('move', 'checkerboard movement instância', 24);
		checkerboard.animation.play('move');
		checkerboard.alpha = 0.8;
		checkerboard.updateHitbox();
		add(checkerboard);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.10;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.scrollFactor.set();
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		info = new FlxText(0, 15, 0, infoTxt[diff], 20);
		info.scrollFactor.set();
		info.setFormat("vcr.ttf", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		info.screenCenter(X);
		add(info);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('mainmenu/menu_buttons');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(700, FlxG.height * 1.6);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			if(i == 0)
			{
				menuItem.setGraphicSize(Std.int(menuItem.width * 1.33));
				menuItem.x = 650;
			}
			else
			{
				menuItem.setGraphicSize(Std.int(menuItem.width * 1.1));
				menuItem.x = 725;
			}
			menuItem.y = 120 + (i * 120);
			finishedFunnyMove = true; 
		}

		miniRosie = new Character(325, 275, 'mini-rosie');
		miniRosie.playAnim('idle');
		miniRosie.scrollFactor.set();
		miniRosie.antialiasing = true;
		add(miniRosie);

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));
		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		#if android
		addVirtualPad(FULL, A_B);
		#end

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (controls.RIGHT_P) diff ++;
		if (controls.LEFT_P) diff --;
		if (diff < 0) diff = 2;
		if (diff > 2) diff = 0;

		Main.diff = diff;
		info.text = '<' + infoTxt[diff] + '>';

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}
//			else
//			{
//				menuarrowup.animation.play('idle');
///			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}
/*			}
			else
			{
				menuarrowdown.animation.play('idle');
			}
*/
			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
//					fancyOpenURL("https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game");
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if (optionShit[curSelected] == 'story mode' || optionShit[curSelected] == 'freeplay')
						{
							miniRosie.playAnim('talk');
						}

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});

//							FlxTween.tween(menuarrowup, {alpha: 0}, 1.3);
//							FlxTween.tween(menuarrowdown, {alpha: 0}, 1.3);
						}
						else
						{

							new FlxTimer().start(2, function(tmr:FlxTimer)
							{
								goToState();
							});
							
						}
					});
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
//			spr.screenCenter(X);
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story mode':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'freeplay':
				FlxG.switchState(new FreeplayState());

				trace("Freeplay Menu Selected");

			case 'options':
				FlxG.switchState(new OptionsMenu());
			case 'credits':
				FlxG.switchState(new CreditsState());
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;

	/*		if(huh == 1)
				{
					arrows.members[1].animation.play('confirm');
					arrows.members[1].centerOffsets();
					arrows.members[1].offset.x -= 13;
					arrows.members[1].offset.y -= 13;
				}
				else if(huh == -1)
				{
					arrows.members[0].animation.play('confirm');
					arrows.members[0].centerOffsets();
					arrows.members[0].offset.x -= 13;
					arrows.members[0].offset.y -= 13;
				}
	*/
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
