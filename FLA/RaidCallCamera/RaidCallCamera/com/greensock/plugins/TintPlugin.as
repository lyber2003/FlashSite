package com.greensock.plugins
{
    import com.greensock.*;
    import com.greensock.core.*;
    import flash.display.*;
    import flash.geom.*;

    public class TintPlugin extends TweenPlugin
    {
        protected var _transform:Transform;
        static var _props:Array = ["redMultiplier", "greenMultiplier", "blueMultiplier", "alphaMultiplier", "redOffset", "greenOffset", "blueOffset", "alphaOffset"];
        public static const API:Number = 2;

        public function TintPlugin()
        {
            super("tint,colorTransform,removeTint");
            return;
        }// end function

        override public function setRatio(param1:Number) : void
        {
            var _loc_2:* = _transform.colorTransform;
            var _loc_3:* = _firstPT;
            while (_loc_3)
            {
                
                _loc_2[_loc_3.p] = _loc_3.c * param1 + _loc_3.s;
                _loc_3 = _loc_3._next;
            }
            _transform.colorTransform = _loc_2;
            return;
        }// end function

        override public function _onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            if (!(param1 is DisplayObject))
            {
                return false;
            }
            var _loc_4:* = new ColorTransform();
            if (param2 != null && param3.vars.removeTint != true)
            {
                _loc_4.color = uint(param2);
            }
            _transform = DisplayObject(param1).transform;
            var _loc_5:* = _transform.colorTransform;
            _loc_4.alphaMultiplier = _loc_5.alphaMultiplier;
            _loc_4.alphaOffset = _loc_5.alphaOffset;
            _init(_loc_5, _loc_4);
            return true;
        }// end function

        public function _init(param1:ColorTransform, param2:ColorTransform) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = _props.length;
            while (--_loc_3 > -1)
            {
                
                _loc_4 = _props[_loc_3];
                if (param1[_loc_4] != param2[_loc_4])
                {
                    _addTween(param1, _loc_4, param1[_loc_4], param2[_loc_4], "tint");
                }
            }
            return;
        }// end function

    }
}
