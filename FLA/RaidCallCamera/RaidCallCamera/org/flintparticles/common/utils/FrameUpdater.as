package org.flintparticles.common.utils
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.flintparticles.common.events.*;

    public class FrameUpdater extends EventDispatcher
    {
        private var _shape:Shape;
        private var _time:Number;
        private var _running:Boolean = false;
        private static var _instance:FrameUpdater;

        public function FrameUpdater()
        {
            this._shape = new Shape();
            return;
        }// end function

        private function startTimer() : void
        {
            this._shape.addEventListener(Event.ENTER_FRAME, this.frameUpdate, false, 0, true);
            this._time = getTimer();
            this._running = true;
            return;
        }// end function

        private function stopTimer() : void
        {
            this._shape.removeEventListener(Event.ENTER_FRAME, this.frameUpdate);
            this._running = false;
            return;
        }// end function

        private function frameUpdate(event:Event) : void
        {
            var _loc_2:* = this._time;
            this._time = getTimer();
            var _loc_3:* = (this._time - _loc_2) * 0.001;
            dispatchEvent(new UpdateEvent(UpdateEvent.UPDATE, _loc_3));
            return;
        }// end function

        override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            super.addEventListener(param1, param2, param3, param4, param5);
            if (!this._running && hasEventListener(UpdateEvent.UPDATE))
            {
                this.startTimer();
            }
            return;
        }// end function

        override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            super.removeEventListener(param1, param2, param3);
            if (this._running && !hasEventListener(UpdateEvent.UPDATE))
            {
                this.stopTimer();
            }
            return;
        }// end function

        public static function get instance() : FrameUpdater
        {
            if (_instance == null)
            {
                _instance = new FrameUpdater;
            }
            return _instance;
        }// end function

    }
}
