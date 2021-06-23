package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);


		animation.add('bf', [0, 1, 24], false, isPlayer);
		animation.add('bfZone-car', [0, 1, 24], false, isPlayer);
		animation.add('bf-philly', [0, 1, 24], false, isPlayer);
		animation.add('bf-car', [0, 1, 24], false, isPlayer);
		animation.add('bf-christmas', [0, 1, 24], false, isPlayer);
		animation.add('bf-pixel', [21, 38, 37], false, isPlayer);
		animation.add('bfPixel-zone', [21, 38, 37], false, isPlayer);
		animation.add('bf-glitch', [21, 38, 37], false, isPlayer);
		animation.add('spooky', [2, 3, 25], false, isPlayer);
		animation.add('pico', [4, 5, 26], false, isPlayer);
		animation.add('mom', [6, 7, 27], false, isPlayer);
		animation.add('mom-car', [6, 7, 27], false, isPlayer);
		animation.add('tankman', [8, 9, 28], false, isPlayer);
		animation.add('face', [10, 11, 30], false, isPlayer);
		animation.add('dad', [12, 13, 29], false, isPlayer);
		animation.add('senpai', [22, 39, 40], false, isPlayer);
		animation.add('senpai-angry', [41, 42, 43], false, isPlayer);
		animation.add('spirit', [23, 35, 36], false, isPlayer);
		animation.add('gf', [16, 31, 32], false, isPlayer);
		animation.add('gfZone-car', [16, 31, 32], false, isPlayer);
		animation.add('gf-spooky', [16, 31, 32], false, isPlayer);
		animation.add('gf-christmas', [16, 31, 32], false, isPlayer);
		animation.add('gf-car', [16, 31, 32], false, isPlayer);
		animation.add('gf-philly', [16, 31, 32], false, isPlayer);
		animation.add('gf-pixel', [16, 31, 32], false, isPlayer);
		animation.add('gf-spooky-zone', [16, 31, 32], false, isPlayer);
		animation.add('gfPixel-zone', [16, 31, 32], false, isPlayer);
		animation.add('parents-christmas', [17, 18, 33], false, isPlayer);
		animation.add('monster', [19, 20, 34], false, isPlayer);
		animation.add('monster-christmas', [19, 20, 34], false, isPlayer);
		animation.add('sword', [44, 46, 45], false, isPlayer);
		animation.add('eye', [47, 48, 49], false, isPlayer);
		animation.add('bf-zone', [0, 1, 24], false, isPlayer);
		animation.add('gf-zone', [16, 31, 32], false, isPlayer);
		animation.add('dad-zone', [12, 13, 29], false, isPlayer);
		animation.add('spooky-zone', [2, 3, 25], false, isPlayer);
		animation.add('pico-zone', [4, 5, 26], false, isPlayer);
		animation.add('mom-zone', [6, 7, 27], false, isPlayer);
		animation.play(char);
		switch(char){
			case 'bf-pixel' | 'senpai' | 'spirit' | 'gf-pixel' | 'gfPixel-zone' | 'bfPixel-zone' :
				{

				}
			default:
				{
					antialiasing = true;
				}
		}
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
