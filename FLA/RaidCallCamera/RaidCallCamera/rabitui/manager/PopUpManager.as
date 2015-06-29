package rabitui.manager
{
    import flash.display.*;
    import flash.utils.*;
    import rabitui.component.*;
    import rabitui.controls.*;

    public class PopUpManager extends Object
    {
        private static var _holder:DisplayObjectContainer;
        private static var _mutexCon:Sprite;
        private static var _modalList:Dictionary = new Dictionary(true);

        public function PopUpManager()
        {
            return;
        }// end function

        public static function init(param1:DisplayObjectContainer) : void
        {
            _holder = param1;
            _mutexCon = new Sprite();
            _holder.addChild(_mutexCon);
            return;
        }// end function

        public static function Alert(param1:String, param2:int = 0, param3:String = "提示", param4:Boolean = true, param5:Boolean = false) : AlertWindow
        {
            var _loc_7:* = null;
            var _loc_6:* = new AlertWindow(param1, param2, param3, param4);
            _loc_6.setSize(340, 150, true);
            if (param5)
            {
                _loc_7 = new ModalBackground();
                _holder.addChild(_loc_7);
                _modalList[_loc_6] = _loc_7;
            }
            _holder.addChild(_loc_6);
            centerPopUp(_loc_6);
            return _loc_6;
        }// end function

        public static function AlertCustom(param1:String, param2:Class, param3:int = 0, param4:String = "提示", param5:Boolean = true, param6:Boolean = false) : AlertWindow
        {
            var _loc_8:* = null;
            var _loc_7:* = new param2(param1, param3, param4, param5);
            _loc_7.setSize(340, 150, true);
            if (param6)
            {
                _loc_8 = new ModalBackground();
                _holder.addChild(_loc_8);
                _modalList[_loc_7] = _loc_8;
            }
            _holder.addChild(_loc_7);
            centerPopUp(_loc_7);
            return _loc_7;
        }// end function

        public static function bringToFront(param1:Sprite) : Sprite
        {
            _holder.setChildIndex(param1, (_holder.numChildren - 1));
            return param1;
        }// end function

        public static function createPopUp(param1:Class, param2:Boolean = false) : Sprite
        {
            var _loc_3:* = new param1;
            addPopUp(_loc_3, param2);
            return _loc_3;
        }// end function

        public static function getLayer() : DisplayObjectContainer
        {
            return _holder;
        }// end function

        public static function addPopUp(param1:DisplayObject, param2:Boolean = false) : DisplayObject
        {
            var _loc_3:* = null;
            if (param2)
            {
                _loc_3 = new ModalBackground();
                _holder.addChild(_loc_3);
                _modalList[param1] = _loc_3;
            }
            _holder.addChild(param1);
            return param1;
        }// end function

        public static function removePopUp(param1:DisplayObject) : void
        {
            if (_modalList[param1] != null)
            {
                _holder.removeChild(_modalList[param1]);
                _modalList[param1] = null;
                delete _modalList[param1];
            }
            if (_holder.contains(param1))
            {
                _holder.removeChild(param1);
            }
            return;
        }// end function

        public static function addMutexPopup(param1:DisplayObject, param2:Boolean = false) : DisplayObject
        {
            var _loc_3:* = null;
            removeOtherWindow();
            if (param2)
            {
                _loc_3 = new ModalBackground();
                _mutexCon.addChild(_loc_3);
                _modalList[param1] = _loc_3;
            }
            _mutexCon.addChild(param1);
            return param1;
        }// end function

        private static function removeOtherWindow() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < _mutexCon.numChildren)
            {
                
                _loc_2 = _mutexCon.getChildAt(_loc_1);
                removeMutexPopUp(_loc_2);
            }
            return;
        }// end function

        public static function isWindowShow(param1:DisplayObject) : Boolean
        {
            if (_mutexCon && param1)
            {
                return _mutexCon.contains(param1);
            }
            return false;
        }// end function

        public static function removeMutexPopUp(param1:DisplayObject) : void
        {
            if (_modalList[param1] != null)
            {
                _mutexCon.removeChild(_modalList[param1]);
                _modalList[param1] = null;
                delete _modalList[param1];
            }
            if (_mutexCon.contains(param1))
            {
                _mutexCon.removeChild(param1);
            }
            return;
        }// end function

        public static function centerPopUp(param1:DisplayObject) : DisplayObject
        {
            param1.x = int((_holder.stage.stageWidth - param1.width) / 2);
            param1.y = int((_holder.stage.stageHeight - param1.height) / 2);
            return param1;
        }// end function

        public static function centerPopUpBySize(param1:DisplayObject, param2:int, param3:int) : DisplayObject
        {
            param1.x = int((_holder.stage.stageWidth - param2) / 2);
            param1.y = int((_holder.stage.stageHeight - param3) / 2);
            return param1;
        }// end function

    }
}
