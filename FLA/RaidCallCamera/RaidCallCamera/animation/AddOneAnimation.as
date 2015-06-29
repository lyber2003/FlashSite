package animation
{
    import animation.*;
    import com.greensock.*;
    import com.greensock.data.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class AddOneAnimation extends Sprite implements IAnimation
    {
        private var content:Asset_addNumTip;
        private var num:int;
        private var time:int;

        public function AddOneAnimation(param1:Point, param2:int = 1, param3:int = 0)
        {
            this.x = param1.x;
            this.y = param1.y;
            this.num = param2;
            this.time = param3;
            this.content = new Asset_addNumTip();
            this.content.label.text = "+" + param2;
            addChild(this.content);
            return;
        }// end function

        public function start() : void
        {
            TweenLite.to(this.content, this.time, new TweenLiteVars().autoAlpha(0).y(-20).onComplete(this.onComplete).ease(Back.easeIn));
            return;
        }// end function

        private function onComplete(event:Event = null) : void
        {
            TweenLite.killTweensOf(this.content);
            if (parent != null)
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
