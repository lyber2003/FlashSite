package components.flower
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import rabitui.uicore.*;
    import rcbiz.*;

    public class FlowerTip extends UIObject
    {
        private var back:Asset_flowerTipBack;
        private var flowers:Sprite;
        private var texture:Asset_flower_icon;
        private var timer:Timer;
        private var _num:int = -1;

        public function FlowerTip()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.back = new Asset_flowerTipBack();
            addChild(this.back);
            this.flowers = new Sprite();
            addChild(this.flowers);
            this.texture = new Asset_flower_icon();
            this.timer = new Timer(1000, 0);
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer, false, 0, true);
            return;
        }// end function

        public function remove() : void
        {
            this.timer.start();
            return;
        }// end function

        protected function onTimer(event:TimerEvent = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this._num != WidgetBiz.getInstance().flowerWidget.myFlowerNum)
            {
                this._num = WidgetBiz.getInstance().flowerWidget.myFlowerNum;
                this.flowers.removeChildren();
                _loc_2 = 0;
                while (_loc_2 < this._num)
                {
                    
                    this.flowers.addChild(new Bitmap(this.texture));
                    _loc_2++;
                }
                _loc_3 = new Bitmap(this.texture);
                _loc_3.alpha = 0.4;
                this.flowers.addChild(_loc_3);
                this.updateDisplay();
            }
            return;
        }// end function

        override protected function init() : void
        {
            this.timer.start();
            this.onTimer();
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = 4;
            var _loc_2:* = 0;
            while (_loc_2 < this.flowers.numChildren)
            {
                
                _loc_3 = this.flowers.getChildAt(_loc_2);
                _loc_3.x = _loc_1;
                _loc_3.y = 4;
                _loc_1 = _loc_1 + (_loc_3.width + 2);
                _loc_2++;
            }
            this.back.width = _loc_1 + 2;
            return;
        }// end function

    }
}
