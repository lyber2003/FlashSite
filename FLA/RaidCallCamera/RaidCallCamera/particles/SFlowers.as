package particles
{
    import com.greensock.*;
    import com.greensock.data.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.events.*;

    public class SFlowers extends Sprite
    {
        private var texture:BitmapData;

        public function SFlowers()
        {
            this.texture = new Asset_Effect_flower1();
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        public function start() : void
        {
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }// end function

        public function stop() : void
        {
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            if (Math.random() > 0.6)
            {
                this.fire();
            }
            return;
        }// end function

        private function fire() : void
        {
            var _loc_5:* = NaN;
            var _loc_1:* = new Bitmap(this.texture);
            addChild(_loc_1);
            var _loc_2:* = Math.random() * 0.5 + 2.5;
            var _loc_3:* = Math.random() * 10 + 10;
            var _loc_4:* = Math.random() * Math.PI * 2;
            _loc_5 = Math.random() * Math.PI * 2;
            var _loc_6:* = Math.cos(_loc_5) * 20;
            var _loc_7:* = Math.sin(_loc_5) * 20;
            var _loc_8:* = Math.random() * 0.8 + 0.2;
            var _loc_9:* = Math.random() * 0.8 + 0.2;
            var _loc_10:* = Math.cos(_loc_4) * _loc_3 * _loc_2 + _loc_6;
            var _loc_11:* = Math.sin(_loc_4) * _loc_3 * _loc_2 + _loc_7;
            var _loc_12:* = Math.random() * 0.3 + 0.3;
            _loc_1.x = _loc_6;
            _loc_1.y = _loc_7;
            _loc_1.scaleX = _loc_8;
            _loc_1.scaleY = _loc_9;
            _loc_1.alpha = _loc_12;
            TweenLite.to(_loc_1, _loc_2, new TweenLiteVars({rotation:_loc_5 * 180 / Math.PI, alpha:0, x:_loc_10, y:_loc_11, ease:Cubic.easeOut}).onComplete(this.onTweenComplete, [_loc_1]));
            return;
        }// end function

        private function onTweenComplete(param1:Bitmap) : void
        {
            removeChild(param1);
            return;
        }// end function

    }
}
