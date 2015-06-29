package language
{
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class Language extends Object
    {
        public var txtCls:Class;
        private static var URL:String = "lang_tw.ini";
        private static const SEPERATOR:String = "\n";
        private static var _instance:Language;
        private static var loader:URLLoader;
        private static var dictionary:Dictionary = new Dictionary();
        private static var count:int = 0;
        private static var bLoad:Boolean = false;

        public function Language()
        {
            this.txtCls = Language_txtCls;
            if (_instance)
            {
                throw new IllegalOperationError("请使用getInstance()方法获取实例");
            }
            this.init0();
            return;
        }// end function

        public function init0() : void
        {
            var _loc_1:* = new this.txtCls();
            var _loc_2:* = _loc_1.readUTFBytes(_loc_1.bytesAvailable);
            var _loc_3:* = _loc_2.split(SEPERATOR);
            setUpData(_loc_3);
            return;
        }// end function

        public function getLgById(param1:int, ... args) : String
        {
            args = dictionary[param1];
            if (args && args.length > 0)
            {
                args = this.build(args, args);
            }
            return args;
        }// end function

        public function getString(param1:int) : String
        {
            return this.getLgById(param1);
        }// end function

        private function build(param1:String, param2:Array) : String
        {
            var _loc_5:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = param2.length;
            while (_loc_3 < _loc_4)
            {
                
                _loc_5 = param1.replace(/%\d+%/, param2[_loc_3]);
                param1 = _loc_5;
                _loc_3++;
            }
            return _loc_5;
        }// end function

        public static function init() : void
        {
            if (bLoad)
            {
                return;
            }
            bLoad = true;
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            loader.addEventListener(Event.COMPLETE, onLoadComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            loader.load(new URLRequest(URL));
            return;
        }// end function

        public static function getInstance() : Language
        {
            if (!_instance)
            {
                _instance = new Language;
            }
            return _instance;
        }// end function

        private static function onLoadComplete(event:Event) : void
        {
            var _loc_2:* = event.target.data;
            var _loc_3:* = _loc_2.split(SEPERATOR);
            setUpData(_loc_3);
            return;
        }// end function

        private static function setUpData(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_3 in param1)
            {
                
                if (!_loc_3 || _loc_3 == "")
                {
                    continue;
                }
                _loc_2 = _loc_3.split("=");
                if (_loc_2.length >= 2 && _loc_2[0] != "")
                {
                    dictionary[_loc_2[0]] = _loc_2[1];
                }
            }
            return;
        }// end function

        private static function ioErrorHandler(event:IOErrorEvent) : void
        {
            count = (count + 1);
            if (count <= 3)
            {
                loader.load(new URLRequest(URL));
            }
            else
            {
                bLoad = false;
                throw new Error("加载语言包失败。。。。");
            }
            return;
        }// end function

    }
}
