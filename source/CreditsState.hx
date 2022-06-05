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
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
#if newgrounds
import io.newgrounds.NG;
#end
import lime.app.Application;
import flixel.addons.text.FlxTypeText;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class CreditsState extends MusicBeatState
{
    var curSelected:Int = 0;
    var creditItems:FlxTypedGroup<FlxSprite>;
    var header:Alphabet;
    var textGroup:FlxGroup;
//    var scales:Int = 0.5;
    var description:Alphabet;
    var optionShit:Array<String> = ['karans_icon', 'shibas_icon', 'pjs_icon'];
    var widescreen:Int = Std.int(FlxG.width);
    var swagDialogue:FlxText;
    override public function create()
    {
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.PINK);
		bg.antialiasing = true;
		add(bg);

		var checkerboard:FlxSprite = new FlxSprite(0, 0);
		checkerboard.frames = Paths.getSparrowAtlas('title/checkerboard_pattern_movement');
		checkerboard.antialiasing = true;
		checkerboard.animation.addByPrefix('move', 'checkerboard movement instância', 24);
		checkerboard.animation.play('move');
		checkerboard.screenCenter();
        checkerboard.alpha = 0.8;
		add(checkerboard);

 /*       var scoreBG:FlxSprite = new FlxSprite(0, 435).makeGraphic(1280, 360, 0xFF000000, false);
		scoreBG.alpha = 0.6;
        scoreBG.screenCenter(X);
		add(scoreBG);
*/

        textGroup = new FlxGroup();
		add(textGroup);

        creditItems = new FlxTypedGroup<FlxSprite>();
		add(creditItems);

        swagDialogue = new FlxText(0, 680, Std.int(FlxG.width * 0.6), "Press Enter to access social media", 32);
        swagDialogue.setFormat("vcr.ttf", 32, FlxColor.BLACK, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.PINK);
        add(swagDialogue);

		for (i in 0...optionShit.length)
		{
			var creditItem:FlxSprite = new FlxSprite((400 * i),  75);
			creditItem.frames = Paths.getSparrowAtlas('credits/' + optionShit[i]);
			creditItem.animation.addByPrefix('idle', optionShit[i] + " icon still", 24);
			creditItem.animation.addByPrefix('selected', optionShit[i] + " icon move", 6);
			creditItem.scale.x = 0.8;
			creditItem.scale.y = 0.8;
            creditItem.ID = i;
//            switch (i)
//            {

//            }
/*            if (i == curSelected)
                {
                    creditItem.animation.play('selected');
                }
            else
                {
                    creditItem.animation.play('idle');
                }
*/
			creditItems.add(creditItem);
            creditItem.scrollFactor.set(1, 0);
			creditItem.updateHitbox();
		}

        changeSelection();

        #if android
        addVirtualPad(LEFT_RIGHT, A_B);
        #end

        super.create();
    }

    override function update(elapsed:Float)
    {
        if(controls.BACK) 
            FlxG.switchState(new MainMenuState());

        if(controls.RIGHT_P)
            changeSelection(1);

        if(controls.LEFT_P)
            changeSelection(-1);
        
        if(controls.ACCEPT)
        {
            var daChoice:String = optionShit[curSelected];

            switch (daChoice)
            {
                case 'karans_icon':
                    fancyOpenURL("https://twitter.com/karanxd_");
                case 'shibas_icon':
                    fancyOpenURL("https://twitter.com/lolychichi");
                case 'pjs_icon':
                    fancyOpenURL("https://www.youtube.com/channel/UCkJvqtijU9JG57x7KLcjqqw");
            }
        }

        
        super.update(elapsed);
    }

    function changeSelection(change:Int = 0)
    {
        curSelected += change;
		if (curSelected >= creditItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = creditItems.length - 1;

        var daChoice:String = optionShit[curSelected];

        creditItems.forEach(function(icon:FlxSprite)
            {
                icon.scale.x = 0.8;
                icon.scale.y = 0.8;
                icon.animation.play('idle');
    
                if (icon.ID == curSelected)
                {
                    icon.animation.play('selected');
                    icon.scale.x = 0.85;
                    icon.scale.y = 0.85;
                    switch (icon.ID)
                    {
                        case 0:
                            deleteText();
                            addText('Epic Musician');
                        case 1:
                            deleteText();
                            addText('Director and Artist');
                        case 2:
                            deleteText();
                            addText('Lead Programmer');
                    }
                }
    
                icon.updateHitbox();
            });

//        optionShit[curSelected].animation.play('selected');
    }

    public function addText(text:String)
        {
            var coolText:Alphabet = new Alphabet(0, 535, text, true, false);
            coolText.screenCenter(X);
            textGroup.add(coolText);
        }


    public function deleteText()
        {
            textGroup.remove(textGroup.members[0], true);
        }
}