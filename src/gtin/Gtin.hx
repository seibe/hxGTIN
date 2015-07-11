package gtin;
import gtin.Gtin;

@:enum
abstract GtinType(Int) to Int
{
	var GTIN_14 = 14;
	var GTIN_13 = 13;
	var GTIN_12 = 12;
	var GTIN_8 = 8;
}

class Gtin
{
	public static function checkDigit(type:GtinType, code:Array<Int>):Bool
	{
		return getCheckDigit(type, code) == calcCheckDigit(type, code);
	}
	
	public static function calcCheckDigit(type:GtinType, code:Array<Int>):Int
	{
		var cd, odd, even:Int;
		
		if (code.length != type) throw "ArgumentError";
		
		switch (type)
		{
			case GTIN_14:
				even = code[0] + code[2] + code[4] + code[6] + code[8] + code[10] + code[12];
				odd = code[1] + code[3] + code[5] + code[7] + code[9] + code[11];
				
			case GTIN_13:
				even = code[1] + code[3] + code[5] + code[7] + code[9] + code[11];
				odd = code[0] + code[2] + code[4] + code[6] + code[8] + code[10];
				
			case GTIN_12:
				even = code[0] + code[2] + code[4] + code[6] + code[8] + code[10];
				odd = code[1] + code[3] + code[5] + code[7] + code[9];
				
			case GTIN_8:
				even = code[0] + code[2] + code[4] + code[6];
				odd = code[1] + code[3] + code[5];
				
			default:
				throw "ArgumentError";
		}
		
		var c3 = Std.string(even * 3 + odd);
		var c4 = Std.parseInt(c3.charAt(c3.length - 1));
		cd = c4 == 0 ? 0 : 10 - c4;
		
		return cd;
	}
	
	public static function setCheckDigit(type:GtinType, code:Array<Int>):Array<Int>
	{
		code[type - 1] = calcCheckDigit(type, code);
		return code;
	}
	
	public static function getCheckDigit(type:GtinType, code:Array<Int>):Int
	{
		return code[type - 1];
	}
	
	public static function codeToStr(type:GtinType, code:Array<Int>):String
	{
		var str:String = "";
		for (i in 0...code.length) str += Std.string(code[i]);
		return str;
	}
	
	public static function strToCode(str:String):Array<Int>
	{
		var arr:Array<Int> = new Array<Int>();
		for (i in 0...str.length) {
			var num = Std.parseInt(str.charAt(i));
			if (num > 10 || num < 0) throw "ParseError";
			arr.push(num);
		}
		return arr;
	}
}