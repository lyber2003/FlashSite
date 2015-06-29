package particles
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class HeartEffect extends Sprite
    {
        private var _ps:Array;
        private var deathZone:Rectangle;
        private var texture:BitmapData;
        private var timer:Timer;
        private var _started:Boolean = false;
        private var startPoint:Point;

        public function HeartEffect()
        {
            this._ps = [];
            this.deathZone = new Rectangle();
            this.texture = new Asset_Effect_heart1();
            mouseEnabled = false;
            mouseChildren = false;
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.timer = new Timer(100, 0);
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer, false, 0, true);
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            stage.addEventListener(Event.RESIZE, this.onStageResize);
            this.deathZone = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            return;
        }// end function

        private function onStageResize(event:Event) : void
        {
            this.deathZone = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            this.pNew();
            return;
        }// end function

        public function start(param1:Point, param2:int = 5) : void
        {
            this.startPoint = param1;
            this.timer.delay = 1000 / param2;
            this.timer.start();
            if (!hasEventListener(Event.ENTER_FRAME))
            {
                addEventListener(Event.ENTER_FRAME, this.renderer, false, 0, true);
            }
            this._started = true;
            return;
        }// end function

        public function stop() : void
        {
            this.timer.stop();
            this._started = false;
            return;
        }// end function

        protected function renderer(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < numChildren)
            {
                
                _loc_3 = getChildAt(_loc_2) as CParticle;
                _loc_3.renderer();
                if (_loc_3.dead)
                {
                    this.pDead(_loc_3);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function initParticle(param1:CParticle) : CParticle
        {
            param1.duration = 90;
            param1.dead = false;
            var _loc_2:* = Math.random() * Math.PI * 2;
            var _loc_3:* = Math.random() * 1 + 0.5;
            param1.speedY = Math.sin(_loc_2) * _loc_3;
            param1.speedX = Math.cos(_loc_2) * _loc_3;
            param1.alpha = 0.4;
            var _loc_4:* = Math.random() * 0.7 + 0.3;
            param1.scaleY = Math.random() * 0.7 + 0.3;
            param1.scaleX = _loc_4;
            param1.x = this.startPoint.x - param1.width / 2;
            param1.y = this.startPoint.y - param1.height / 2;
            param1.rotation = Math.random() * 20 - 10;
            addChild(param1);
            return param1;
        }// end function

        private function pDead(param1:CParticle) : void
        {
            this._ps.push(param1);
            removeChild(param1);
            if (this.numChildren == 0 && !this._started)
            {
                removeEventListener(Event.ENTER_FRAME, this.renderer, false);
            }
            return;
        }// end function

        private function pNew() : void
        {
            if (this._ps.length > 0)
            {
                this.initParticle(this._ps.pop());
            }
            else
            {
                this.initParticle(new CParticle(this.texture));
            }
            return;
        }// end function

    }
}
