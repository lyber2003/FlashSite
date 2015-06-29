﻿package com.greensock.plugins
{
    import com.greensock.*;
    import flash.display.*;

    public class FramePlugin extends TweenPlugin
    {
        protected var _target:MovieClip;
        public var frame:int;
        public static const API:Number = 2;

        public function FramePlugin()
        {
            super("frame,frameLabel,frameForward,frameBackward");
            return;
        }// end function

        override public function setRatio(param1:Number) : void
        {
            super.setRatio(param1);
            if (this.frame != _target.currentFrame)
            {
                _target.gotoAndStop(this.frame);
            }
            return;
        }// end function

        override public function _onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            if (!(param1 is MovieClip) || isNaN(param2))
            {
                return false;
            }
            _target = param1 as MovieClip;
            this.frame = _target.currentFrame;
            _addTween(this, "frame", this.frame, param2, "frame", true);
            return true;
        }// end function

    }
}
