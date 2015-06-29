package rabitui.uicore
{
    import flash.display.*;
    import flash.events.*;

    public class UIObject extends Sprite
    {
        protected var _preferWidth:Number = 0;
        protected var _preferHeight:Number = 0;
        private var bWaitingForUpdate:Boolean = false;

        public function UIObject()
        {
            tabEnabled = false;
            tabChildren = false;
            this.preinit();
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            this.createChildren();
            this.init();
            return;
        }// end function

        protected function init() : void
        {
            return;
        }// end function

        public function setSize(param1:Number, param2:Number, param3:Boolean = false) : void
        {
            this._preferWidth = param1;
            this._preferHeight = param2;
            this._update(param3);
            return;
        }// end function

        public function get preferWidth() : Number
        {
            return this._preferWidth;
        }// end function

        public function set preferWidth(param1:Number) : void
        {
            if (this._preferWidth != param1)
            {
                this._preferWidth = param1;
                this._update();
            }
            return;
        }// end function

        public function get preferHeight() : Number
        {
            return this._preferHeight;
        }// end function

        public function set preferHeight(param1:Number) : void
        {
            if (this._preferHeight != param1)
            {
                this._preferHeight = param1;
                this._update();
            }
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            return;
        }// end function

        protected function onRemovedFromStage(event:Event) : void
        {
            return;
        }// end function

        protected function preinit() : void
        {
            return;
        }// end function

        protected function createChildren() : void
        {
            return;
        }// end function

        protected function _update(param1:Boolean = false) : void
        {
            if (param1)
            {
                this.bWaitingForUpdate = false;
                removeEventListener(Event.ENTER_FRAME, this._onLaterFrame);
                this.updateDisplay();
                return;
            }
            if (this.bWaitingForUpdate)
            {
                return;
            }
            this.bWaitingForUpdate = true;
            addEventListener(Event.ENTER_FRAME, this._onLaterFrame);
            return;
        }// end function

        protected function _onLaterFrame(event:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME, this._onLaterFrame);
            this.updateDisplay();
            this.bWaitingForUpdate = false;
            return;
        }// end function

        protected function updateDisplay() : void
        {
            dispatchEvent(new Event("updateDisplay"));
            return;
        }// end function

        public function gc() : void
        {
            var _loc_1:* = null;
            while (numChildren)
            {
                
                _loc_1 = getChildAt(0);
                if (_loc_1.hasOwnProperty("gc"))
                {
                    _loc_1.gc();
                }
                removeChild(_loc_1 as DisplayObject);
                _loc_1 = null;
            }
            return;
        }// end function

    }
}
