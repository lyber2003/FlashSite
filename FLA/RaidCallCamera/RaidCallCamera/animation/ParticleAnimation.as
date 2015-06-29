package animation
{
    import animation.*;
    import com.greensock.*;
    import com.greensock.data.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.geom.*;

    public class ParticleAnimation extends Sprite implements IAnimation
    {
        private var count:int;
        private var texture:BitmapData;
        private var point:Point;

        public function ParticleAnimation(param1:Point, param2:BitmapData, param3:uint = 8)
        {
            mouseChildren = false;
            mouseEnabled = false;
            this.point = param1;
            this.texture = param2;
            this.count = param3;
            return;
        }// end function

        public function start() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_1:* = 0;
            while (_loc_1 < this.count)
            {
                
                _loc_2 = new Bitmap(this.texture);
                addChild(_loc_2);
                _loc_3 = Math.random() * 0.5 + 2.5;
                _loc_4 = Math.random() * 10 + 10;
                _loc_5 = Math.random() * Math.PI * 2;
                _loc_6 = Math.random() * Math.PI * 2 - Math.PI;
                _loc_7 = this.point.x + Math.cos(_loc_6) * 50;
                _loc_8 = this.point.y + Math.sin(_loc_6) * 50;
                _loc_9 = Math.random() * 0.8 + 0.2;
                _loc_10 = Math.cos(_loc_5) * _loc_4 * _loc_3 + _loc_7;
                _loc_11 = Math.sin(_loc_5) * _loc_4 * _loc_3 + _loc_8;
                _loc_2.x = _loc_7;
                _loc_2.y = _loc_8;
                var _loc_12:* = _loc_9;
                _loc_2.scaleY = _loc_9;
                _loc_2.scaleX = _loc_12;
                _loc_2.alpha = 1;
                TweenLite.to(_loc_2, _loc_3, new TweenLiteVars({rotation:_loc_6 * 180 / Math.PI, alpha:0, x:_loc_10, y:_loc_11, ease:Cubic.easeOut}).onComplete(this.onTweenComplete, [_loc_2]));
                _loc_1++;
            }
            return;
        }// end function

        private function onTweenComplete(param1:Bitmap) : void
        {
            removeChild(param1);
            if (this.numChildren == 0)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

        public function stop() : void
        {
            return;
        }// end function

    }
}
