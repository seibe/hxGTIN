package;

import gtin.Gtin;
import gtin.ItfSymbol;
import openfl.display.Sprite;
import openfl.text.TextField;

class Main extends Sprite
{
	//
	
	public function new()
	{
		super();
		
		var code = Gtin.strToCode("04571227071080");
		code = Gtin.setCheckDigit(GtinType.GTIN_14, code);
		
		if (Gtin.checkDigit(GtinType.GTIN_14, code))
		{
			var symbol = new ItfSymbol(code);
			symbol.x = symbol.y = 10;
			symbol.scaleX = symbol.scaleY = 4;
			this.addChild(symbol);
			
			var label = new TextField();
			label.text = Gtin.codeToStr(GtinType.GTIN_14, code);
			label.scaleX = label.scaleY = 2;
			label.x = symbol.x + symbol.width * 0.5 - label.width * 0.5;
			label.y = symbol.y * 2 + symbol.height;
			this.addChild(label);
		}
	}
}