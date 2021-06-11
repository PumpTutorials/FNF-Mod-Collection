package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxSubState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;


class ScrollState extends MusicBeatState
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;
	public var menuItems:Array<String> = ['Up','Down'];

	public var curSelected:Int = 0;

	public var pauseMusic:FlxSound;
	public static var up:Int = 1;
	public static var down:Int = 0;
	public static var keys:FlxText;

	
	


	
	override function create()
	{
		
	
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		if (CategoryState.chara != 1)
			bg = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
	 	else
		    bg = new FlxSprite().loadGraphic(Paths.image('chara-menu'));
		bg.scrollFactor.set();
		add(bg);
		keys = new FlxText(70, 0, 0, "", 32);
					
					
					
					
					
		keys.text = "CurSelected: " + FlxG.save.data.down.toUpperCase();
		keys.scrollFactor.set();
		keys.setFormat(Paths.font('vcr.ttf'), 32);
		keys.updateHitbox();
		add(keys);
		FlxTween.tween(keys, {alpha: 1, y: 0}, 0.4, {ease: FlxEase.quartInOut});


	


	
	
		
	

		pauseMusic = new FlxSound().loadEmbedded(Paths.music('category'), true, true);


		FlxG.sound.list.add(pauseMusic);




		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;
		var back = controls.BACK;
		var controlsStrings:Array<String> = [];

		
		

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		
		if (controls.BACK)
		{
			FlxG.switchState(new OptionsMenuState());
		}
		if (accepted)
		{
			var daSelected:String = menuItems[curSelected];

			switch (daSelected)
			{
				case "Up":
					FlxG.save.data.down = 'up';
					
					FlxTween.tween(keys, {alpha: 1, y: 0}, 0.4, {ease: FlxEase.quartInOut});
					keys.text = "CurSelected: " + FlxG.save.data.down.toUpperCase();
					keys.scrollFactor.set();
					keys.setFormat(Paths.font('vcr.ttf'), 32);
					keys.updateHitbox();
					add(keys);
					
					
				case "Down":
				
					
					FlxG.save.data.down = 'down';
					FlxTween.tween(keys, {alpha: 1, y: 0}, 0.4, {ease: FlxEase.quartInOut});
					keys.text = "CurSelected: " + FlxG.save.data.down.toUpperCase();
					keys.scrollFactor.set();
					keys.setFormat(Paths.font('vcr.ttf'), 32);
					keys.updateHitbox();
					add(keys);
				
	
			}


		}

		if (FlxG.keys.justPressed.J)
		{
			// for reference later!
			// PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxKey.J, null);
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}