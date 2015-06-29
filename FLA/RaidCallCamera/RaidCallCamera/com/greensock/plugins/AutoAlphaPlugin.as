﻿package com.greensock.plugins
{
    import com.greensock.*;

    public class AutoAlphaPlugin extends TweenPlugin
    {
        protected var _target:Object;
        protected var _ignoreVisible:Boolean;
        public static const API:Number = 2;

        public function AutoAlphaPlugin()
        {
            super("autoAlpha,alpha,visible");
            return;
        }// end function

        override public function _kill(param1:Object) : Boolean
        {
            _ignoreVisible = "visible" in param1;
            return super._kill(param1);
        }// end function

        override public function setRatio(param1:Number) : void
        {
            super.setRatio(param1);
            if (!_ignoreVisible)
            {
                _target.visible = _target.alpha != 0;
            }
            return;
        }// end function

        override public function _onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            _target = param1;
            _addTween(param1, "alpha", param1.alpha, param2, "alpha");
            return true;
        }// end function

    }
}
