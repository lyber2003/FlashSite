package rabitui.manager
{
    import com.greensock.plugins.*;
    import flash.display.*;
    import flash.geom.*;
    import rabitui.component.*;
    import rabitui.model.*;

    public class TipManager extends Object
    {
        private static var _holder:DisplayObjectContainer;
        private static var _tipPanel:ToolTipPanel = new ToolTipPanel();

        public function TipManager()
        {
            return;
        }// end function

        public static function init(param1:DisplayObjectContainer) : void
        {
            TweenPlugin.activate([AutoAlphaPlugin, BezierThroughPlugin]);
            _holder = param1;
            _tipPanel.visible = false;
            _holder.addChild(_tipPanel);
            return;
        }// end function

        public static function showTip(param1:String, param2:Point, param3:String = "left", param4:Number = 1) : void
        {
            if (param1 == null)
            {
                return;
            }
            _tipPanel.visible = true;
            _tipPanel.setTips(param1);
            _tipPanel.setAlpha(param4);
            switch(param3)
            {
                case TipAlignModel.CENTER_TOP:
                {
                    _tipPanel.x = param2.x;
                    _tipPanel.y = param2.y - _tipPanel.getRealHeight();
                    break;
                }
                case TipAlignModel.CENTER_BOTTOM:
                {
                    _tipPanel.x = param2.x;
                    _tipPanel.y = param2.y;
                    break;
                }
                case TipAlignModel.LEFT:
                {
                    _tipPanel.x = param2.x - _tipPanel.getRealWidth();
                    _tipPanel.y = param2.y;
                    break;
                }
                case TipAlignModel.RIGHT:
                {
                    _tipPanel.x = param2.x;
                    _tipPanel.y = param2.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function showTipDisplay(param1:DisplayObject) : void
        {
            _holder.addChild(param1);
            return;
        }// end function

        public static function removeTipDisplay(param1:DisplayObject) : void
        {
            if (_holder.contains(param1))
            {
                _holder.removeChild(param1);
            }
            return;
        }// end function

        public static function removeTip() : void
        {
            _tipPanel.visible = false;
            return;
        }// end function

        public static function showWarnTip(param1:String, param2:Point = null, param3:Number = 3, param4:Boolean = true) : WarnTip
        {
            if (param2 == null)
            {
                param2 = new Point(0, 0);
            }
            var _loc_5:* = new WarnTip(param1, param3, param4);
            _loc_5.x = param2.x;
            _loc_5.y = param2.y;
            _holder.addChild(_loc_5);
            return _loc_5;
        }// end function

        public static function showCustomTip(param1:DisplayObject) : DisplayObject
        {
            _holder.addChild(param1);
            return param1;
        }// end function

        public static function removeCustomTip(param1:DisplayObject) : void
        {
            if (_holder.contains(param1))
            {
                _holder.removeChild(param1);
            }
            return;
        }// end function

    }
}
