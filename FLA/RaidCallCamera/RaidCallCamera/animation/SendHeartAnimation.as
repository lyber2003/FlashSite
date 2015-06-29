package animation
{
    import animation.*;
    import com.greensock.*;
    import com.greensock.data.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import rcbiz.*;
    import rcbiz.events.*;

    public class SendHeartAnimation extends Sprite implements IAnimation
    {
        private var startPoint:Point;
        private var endPoint:Point;
        private var heart:Asset_bigHeart;
        private var reciver:uint;
        private var timeLine:TimelineLite;

        public function SendHeartAnimation(param1:Point, param2:Point, param3:uint)
        {
            mouseChildren = false;
            mouseEnabled = false;
            WidgetBiz.getInstance().clientWidget.addEventListener(ClientEvent.SINGER_CHANGE, this.onSingerChange, false, 0, true);
            this.reciver = param3;
            this.startPoint = param1;
            this.endPoint = param2;
            this.heart = new Asset_bigHeart();
            this.heart.mouseChildren = false;
            this.heart.mouseEnabled = false;
            addChild(this.heart);
            var _loc_4:* = 0.2;
            this.heart.scaleY = 0.2;
            this.heart.scaleX = _loc_4;
            this.heart.rotation = -10;
            this.heart.x = param1.x + 25;
            this.heart.y = param1.y + 25;
            this.heart.alpha = 0.3;
            this.timeLine = new TimelineLite();
            this.timeLine.append(new TweenMax(this.heart, 1.5, {onComplete:this.onComplete, bezierThrough:[{x:this.endPoint.x + 70, y:this.endPoint.y + 10}, {x:this.endPoint.x - 70, y:this.endPoint.y + 20}, {x:this.endPoint.x, y:this.endPoint.y}], scaleX:0.5, scaleY:0.5, rotation:0, alpha:1, orientToBezier:false, ease:Quad.easeOut}));
            this.timeLine.append(new TweenLite(this.heart, 0.3, new TweenLiteVars().scale(1)));
            this.timeLine.append(new TweenLite(this.heart, 1, new TweenLiteVars({alpha:0}).onComplete(this.onEComplete).scale(0)));
            this.timeLine.pause();
            return;
        }// end function

        protected function onSingerChange(event:Event) : void
        {
            this.stop();
            return;
        }// end function

        public function start() : void
        {
            this.timeLine.play();
            return;
        }// end function

        private function onComplete() : void
        {
            AnimationManager.addAnimation(new ParticleAnimation(this.endPoint, new Asset_Effect_star2(), 5));
            return;
        }// end function

        private function onEComplete() : void
        {
            this.timeLine.stop();
            this.timeLine._active = false;
            WidgetBiz.getInstance().clientWidget.removeEventListener(ClientEvent.SINGER_CHANGE, this.onSingerChange, false);
            AnimationManager.addAnimation(new ParticleAnimation(this.endPoint, new Asset_Effect_heart1(), 6));
            removeChild(this.heart);
            parent.removeChild(this);
            return;
        }// end function

        public function stop() : void
        {
            var _loc_2:* = null;
            this.timeLine.stop();
            this.timeLine._active = false;
            WidgetBiz.getInstance().clientWidget.removeEventListener(ClientEvent.SINGER_CHANGE, this.onSingerChange, false);
            var _loc_1:* = 0;
            while (_loc_1 < this.numChildren)
            {
                
                _loc_2 = getChildAt(_loc_1) as DisplayObject;
                TweenLite.killTweensOf(_loc_2);
                TweenLite.to(_loc_2, 0.2, new TweenLiteVars({alpha:0}).onComplete(this.onStopComplete, [_loc_2]));
                _loc_1++;
            }
            return;
        }// end function

        private function onStopComplete(param1:DisplayObject) : void
        {
            removeChild(param1);
            if (numChildren == 0)
            {
                if (parent != null)
                {
                    parent.removeChild(this);
                }
            }
            return;
        }// end function

    }
}
