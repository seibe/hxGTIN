package gtin;

import openfl.display.Graphics;
import openfl.display.Shape;

class ItfSymbol extends Shape
{

	public function new(code:Array<Int>) 
	{
		super();
		if (code.length != 14) throw "ArugumentError";
		
		var g = this.graphics;
		
		g.beginFill(0x000000);
		g.drawRect(0, 0, 150, 41.3);
		g.endFill();
		g.beginFill(0xFFFFFF);
		g.drawRect(4.75, 4.75, 140.5, 31.8);
		g.endFill();
		
		g.beginFill(0x000000);
		g.drawRect(14.75, 4.75, 1, 31.8);
		g.drawRect(16.75, 4.75, 1, 31.8);
		
		var x = 18.75;
		for (i in 0...7)
		{
			var a = getModules(code[i * 2]);
			var b = getModules(code[i * 2 + 1]);
			
			for (j in 0...5)
			{
				g.drawRect(x, 4.75, a[j] ? 2.5 : 1, 31.8);
				x += a[j] ? 2.5 : 1;
				x += b[j] ? 2.5 : 1;
			}
		}
		
		g.drawRect(130.75, 4.75, 2.5, 31.8);
		g.drawRect(134.25, 4.75, 1, 31.8);
		g.endFill();
	}
	
	private function getModules(code:Int):Array<Bool>
	{
		var arr:Array<Bool> = new Array<Bool>();
		
		switch (code)
		{
			case 0: arr = [false, false, true, true, false];
			case 1: arr = [true, false, false, false, true];
			case 2: arr = [false, true, false, false, true];
			case 3: arr = [true, true, false, false, false];
			case 4: arr = [false, false, true, false, true];
			case 5: arr = [true, false, true, false, false];
			case 6: arr = [false, true, true, false, false];
			case 7: arr = [false, false, false, true, true];
			case 8: arr = [true, false, false, true, false];
			case 9: arr = [false, true, false, true, false];
			default: throw "ArugumentError";
		}
		
		return arr;
	}
	
}