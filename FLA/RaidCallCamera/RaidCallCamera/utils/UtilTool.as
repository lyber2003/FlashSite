package utils
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    public class UtilTool extends Object
    {

        public function UtilTool()
        {
            return;
        }// end function

        public static function applyGray(param1:DisplayObject) : void
        {
            var _loc_2:* = new Array();
            _loc_2 = _loc_2.concat([0.21, 0.7, 0.09, 0, 0]);
            _loc_2 = _loc_2.concat([0.21, 0.7, 0.09, 0, 0]);
            _loc_2 = _loc_2.concat([0.21, 0.7, 0.09, 0, 0]);
            _loc_2 = _loc_2.concat([0, 0, 0, 1, 0]);
            applyFilter(param1, _loc_2);
            return;
        }// end function

        public static function clone(param1:Object)
        {
            var _loc_2:* = new ByteArray();
            _loc_2.writeObject(param1);
            _loc_2.position = 0;
            return _loc_2.readObject();
        }// end function

        public static function clearArray(param1:Array) : void
        {
            while (param1.length)
            {
                
                param1.pop();
            }
            return;
        }// end function

        public static function clearDictionary(param1:Dictionary) : void
        {
            var _loc_2:* = undefined;
            for (_loc_2 in param1)
            {
                
                delete _loc_4[_loc_2];
            }
            return;
        }// end function

        public static function disableButtonBySecond(param1:SimpleButton, param2:Number = 1) : void
        {
            var b:* = param1;
            var second:* = param2;
            b.enabled = false;
            b.mouseEnabled = false;
            TweenLite.delayedCall(second, function () : void
            {
                b.enabled = true;
                b.mouseEnabled = true;
                return;
            }// end function
            );
            return;
        }// end function

        public static function cutStr(param1:String = "", param2:uint = 0) : String
        {
            var _loc_3:* = "";
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            while (_loc_4 < param1.length && _loc_5 < param2 * 2)
            {
                
                if (param1.charCodeAt(_loc_4) > 192)
                {
                    _loc_5 = _loc_5 + 2;
                }
                else
                {
                    _loc_5 = _loc_5 + 1;
                }
                _loc_3 = _loc_3 + param1.charAt(_loc_4);
                _loc_4 = _loc_4 + 1;
            }
            if (_loc_3.length < param1.length)
            {
                _loc_3 = _loc_3 + "..";
            }
            return _loc_3;
        }// end function

        public static function htmlencode(param1:String) : String
        {
            param1 = param1.replace("&", "&amp;");
            param1 = param1.replace("<", "&lt;");
            param1 = param1.replace(">", "&gt;");
            param1 = param1.replace("\"", "&quot;");
            return param1;
        }// end function

        public static function getHtmlText(param1:String, param2:String = "SimSun,宋体", param3:String = "#000000", param4:int = 12, param5:Boolean = false) : String
        {
            var _loc_6:* = "<font color=\'" + param3 + "\' face=\'" + param2 + "\' size=\'" + param4 + "\'>" + htmlencode(param1) + "</font>";
            if (param5)
            {
                _loc_6 = "<b>" + _loc_6 + "</b>";
            }
            return _loc_6;
        }// end function

        public static function getLink(param1:String, param2:String = "") : String
        {
            var _loc_3:* = "<a href=\"event:" + htmlencode(param2) + "\">" + param1 + "</a>";
            return _loc_3;
        }// end function

        public static function getTextWidth(param1:String) : Number
        {
            var _loc_2:* = new TextField();
            _loc_2.selectable = false;
            _loc_2.autoSize = TextFieldAutoSize.LEFT;
            _loc_2.htmlText = param1;
            return Math.max(_loc_2.textWidth, _loc_2.width);
        }// end function

        public static function joinBycomma(param1:String) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = param1.length / 3;
            if (param1.length % 3 == 0 && _loc_3 > 0)
            {
                _loc_3 = _loc_3 - 1;
            }
            if (_loc_3 == 0)
            {
                return param1;
            }
            var _loc_4:* = 1;
            while (_loc_4 <= _loc_3)
            {
                
                if (_loc_2 != "")
                {
                    _loc_2 = param1.substr(param1.length - 3 * _loc_4, 3) + "," + _loc_2;
                }
                else
                {
                    _loc_2 = param1.substr(param1.length - 3 * _loc_4, 3);
                }
                _loc_4++;
            }
            if (param1.length - 3 * _loc_3 != 0)
            {
                _loc_2 = param1.substr(0, param1.length - 3 * _loc_3) + "," + _loc_2;
            }
            return _loc_2;
        }// end function

        static function applyFilter(param1:DisplayObject, param2:Array) : void
        {
            var _loc_3:* = new ColorMatrixFilter(param2);
            var _loc_4:* = new Array();
            _loc_4.push(_loc_3);
            param1.filters = _loc_4;
            return;
        }// end function

        public static function subStrByByte(param1:String, param2:int) : String
        {
            var _loc_4:* = null;
            var _loc_3:* = new ByteArray();
            _loc_3.writeMultiByte(param1, "");
            if (_loc_3.length < param2)
            {
                return param1;
            }
            _loc_3.position = 0;
            _loc_4 = _loc_3.readMultiByte(param2, "");
            if (_loc_4 == param1)
            {
                return _loc_4;
            }
            return _loc_3.readMultiByte((param2 - 1), "");
        }// end function

        public static function getStrLen(param1:String) : uint
        {
            var _loc_2:* = new ByteArray();
            _loc_2.writeMultiByte(param1, "");
            return _loc_2.length;
        }// end function

        static function isSpace(param1:String) : Boolean
        {
            switch(param1)
            {
                case String.fromCharCode(32):
                {
                    break;
                }
                case String.fromCharCode(9):
                {
                    break;
                }
                case String.fromCharCode(12288):
                {
                    break;
                }
                case String.fromCharCode(13):
                {
                    break;
                }
                default:
                {
                    return false;
                    break;
                }
            }
            return true;
        }// end function

        static function countStartSpace(param1:String) : Number
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (isSpace(param1.charAt(_loc_3)) == false)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return _loc_3;
        }// end function

        static function countEndSpace(param1:String) : Number
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = _loc_2 - 1;
            while (_loc_3 >= 0)
            {
                
                if (isSpace(param1.charAt(_loc_3)) == false)
                {
                    return _loc_3;
                }
                _loc_3 = _loc_3 - 1;
            }
            return _loc_3;
        }// end function

        public static function leftTrim(param1:String) : String
        {
            var _loc_2:* = countStartSpace(param1);
            return param1.slice(_loc_2);
        }// end function

        public static function rightTrim(param1:String) : String
        {
            var _loc_2:* = countEndSpace(param1) + 1;
            return param1.slice(0, _loc_2);
        }// end function

        public static function allTrim(param1:String) : String
        {
            var _loc_2:* = leftTrim(param1);
            if (_loc_2.length == 0)
            {
                return "";
            }
            return rightTrim(_loc_2);
        }// end function

        public static function isSwf(param1:String) : Boolean
        {
            if (param1.substr(param1.length - 4, 4) == ".swf")
            {
                return true;
            }
            return false;
        }// end function

        public static function getRegion() : int
        {
            if (Capabilities.language == "zh-CN")
            {
                return 2;
            }
            return 1;
        }// end function

    }
}
