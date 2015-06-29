﻿package com.greensock.plugins
{
    import com.greensock.*;
    import flash.media.*;

    public class VolumePlugin extends TweenPlugin
    {
        protected var _target:Object;
        protected var _st:SoundTransform;
        public static const API:Number = 2;

        public function VolumePlugin()
        {
            super("volume");
            return;
        }// end function

        override public function setRatio(param1:Number) : void
        {
            super.setRatio(param1);
            _target.soundTransform = _st;
            return;
        }// end function

        override public function _onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            if (isNaN(param2) || param1.hasOwnProperty("volume") || !param1.hasOwnProperty("soundTransform"))
            {
                return false;
            }
            _target = param1;
            _st = _target.soundTransform;
            _addTween(_st, "volume", _st.volume, param2, "volume");
            return true;
        }// end function

    }
}
