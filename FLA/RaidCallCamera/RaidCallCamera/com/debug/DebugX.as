package com.debug
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;

    public class DebugX extends Object
    {
        private static var _info:String = "---debug  start---\n";
        private static var _holder:Sprite;
        private static var _tf:TextField;
        private static var _outFunction:String = "all";
        private static var _enable:Boolean = false;

        public function DebugX()
        {
            return;
        }// end function

        public static function init(param1:Sprite) : void
        {
            _holder = param1;
            _tf = new TextField();
            _tf.backgroundColor = 3355443;
            _tf.border = true;
            _tf.background = true;
            _tf.x = 20;
            _tf.y = 20;
            _tf.width = 250;
            _tf.height = 300;
            _tf.multiline = true;
            _tf.selectable = true;
            _tf.textColor = 16777215;
            _tf.htmlText = _info;
            _tf.appendText("debug inited!\n");
            if (enable)
            {
                _holder.addChild(_tf);
            }
            _tf.visible = false;
            param1.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyBoardDown);
            return;
        }// end function

        public static function out(... args) : void
        {
            if (!calNeedShow("out"))
            {
                return;
            }
            args = args.join(",") + "\n";
            if (_tf != null)
            {
                _tf.appendText(args);
            }
            else
            {
                _info = _info + args;
            }
            return;
        }// end function

        public static function trace(... args) : void
        {
            if (!calNeedShow("trace"))
            {
                return;
            }
            args = args.join(",") + "\n";
            if (_tf != null)
            {
                _tf.appendText(args);
            }
            else
            {
                _info = _info + args;
            }
            return;
        }// end function

        public static function print(... args) : void
        {
            if (!calNeedShow("print"))
            {
                return;
            }
            args = args.join(",") + "\n";
            if (_tf != null)
            {
                _tf.appendText(args);
            }
            else
            {
                _info = _info + args;
            }
            return;
        }// end function

        public static function l(... args) : void
        {
            if (!calNeedShow("l"))
            {
                return;
            }
            args = args.join(",");
            if (_tf != null)
            {
                _tf.appendText(args);
            }
            else
            {
                _info = _info + args;
            }
            return;
        }// end function

        public static function calNeedShow(param1:String) : Boolean
        {
            if (!enable)
            {
                return false;
            }
            if (_outFunction == "all" || _outFunction == param1)
            {
                return true;
            }
            return false;
        }// end function

        static function onKeyBoardDown(event:KeyboardEvent) : void
        {
            if (event.ctrlKey && event.keyCode == Keyboard.UP)
            {
                _tf.visible = !_tf.visible;
            }
            return;
        }// end function

        public static function get enable() : Boolean
        {
            return _enable;
        }// end function

        public static function set enable(param1:Boolean) : void
        {
            _enable = param1;
            if (_enable)
            {
                _holder.addChild(_tf);
            }
            return;
        }// end function

    }
}
