﻿package com.greensock.plugins
{
    import com.greensock.*;
    import flash.display.*;

    public class FrameLabelPlugin extends FramePlugin
    {
        public static const API:Number = 2;

        public function FrameLabelPlugin()
        {
            _propName = "frameLabel";
            return;
        }// end function

        override public function _onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            if (!param3.target is MovieClip)
            {
                return false;
            }
            _target = param1 as MovieClip;
            this.frame = _target.currentFrame;
            var _loc_4:* = _target.currentLabels;
            var _loc_5:* = param2;
            var _loc_6:* = _target.currentFrame;
            var _loc_7:* = _loc_4.length;
            while (--_loc_7 > -1)
            {
                
                if (_loc_4[_loc_7].name == _loc_5)
                {
                    _loc_6 = _loc_4[_loc_7].frame;
                    break;
                }
            }
            if (this.frame != _loc_6)
            {
                _addTween(this, "frame", this.frame, _loc_6, "frame", true);
            }
            return true;
        }// end function

    }
}
