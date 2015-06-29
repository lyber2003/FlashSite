package animation
{
    import ExtEffect.*;
    import com.greensock.*;
    import com.greensock.data.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.geom.*;

    public class AnimationManager extends Object
    {
        private static var animationList:Array = new Array();
        private static var animationList2:Array = new Array();
        private static var animationList3:Array = new Array();
        private static var randomFlayList:Array = new Array();
        public static var _holder:DisplayObjectContainer;
        private static var currentAnimation2:Sprite;
        private static var currentAnimation3:Sprite;
        private static var _mouseEnableHolder:Sprite;
        private static var _mouseDisableHolder:Sprite;
        private static var MAX_RANDOM_FLY:int = 20;
        private static var MAX_WAIT_RANDOM_FLY:int = 100;
        private static var _flower:BitmapData = new Asset_Effect_flower1();
        private static var _aniPlaying:Array = new Array(5);

        public function AnimationManager()
        {
            return;
        }// end function

        public static function init(param1:DisplayObjectContainer) : void
        {
            _holder = param1;
            _mouseEnableHolder = new Sprite();
            _holder.addChild(_mouseEnableHolder);
            _mouseDisableHolder = new Sprite();
            _holder.addChild(_mouseDisableHolder);
            _mouseDisableHolder.mouseEnabled = false;
            _mouseDisableHolder.mouseChildren = false;
            return;
        }// end function

        public static function addAnimation(param1:IAnimation) : void
        {
            _mouseDisableHolder.addChild(param1 as DisplayObject);
            param1.start();
            return;
        }// end function

        public static function addRandomFlyGifts(param1:BitmapData, param2:int, param3:int, param4:Number) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_5:* = 0;
            while (_loc_5 < param3)
            {
                
                _loc_6 = new Bitmap(param1);
                var _loc_8:* = param4;
                _loc_6.scaleY = param4;
                _loc_6.scaleX = _loc_8;
                _loc_6.x = Math.random() * _mouseDisableHolder.stage.stageWidth;
                _loc_6.y = 0;
                if (_mouseDisableHolder.numChildren < MAX_RANDOM_FLY)
                {
                    _mouseDisableHolder.addChild(_loc_6);
                    _loc_7 = Math.random() * 2;
                    TweenLite.to(_loc_6, 3, new TweenLiteVars({delay:_loc_7, y:_mouseDisableHolder.stage.stageHeight}).onComplete(onGiftflyComplete, [_loc_6]).ease(Quad.easeIn));
                }
                else
                {
                    pushToRandomList(_loc_6, param2);
                }
                _loc_5++;
            }
            return;
        }// end function

        public static function pushToRandomList(param1:DisplayObject, param2:int) : void
        {
            var _loc_3:* = new RandomFlyData();
            _loc_3.price = param2;
            _loc_3.display = param1;
            randomFlayList.push(_loc_3);
            while (randomFlayList.length > MAX_WAIT_RANDOM_FLY)
            {
                
                randomFlayList.pop();
            }
            return;
        }// end function

        public static function popRandomList() : void
        {
            if (randomFlayList.length == 0)
            {
                return;
            }
            var _loc_1:* = randomFlayList.shift();
            _mouseDisableHolder.addChild(_loc_1.display);
            TweenLite.to(_loc_1.display, 3, new TweenLiteVars({y:_mouseDisableHolder.stage.stageHeight}).onComplete(onGiftflyComplete, [_loc_1.display]).ease(Quad.easeIn));
            return;
        }// end function

        public static function addRandomFlyPiaoGifts(param1:DisplayObject, param2:int, param3:int) : void
        {
            var _loc_5:* = NaN;
            var _loc_4:* = 0;
            while (_loc_4 < param3)
            {
                
                param1.x = Math.random() * _mouseDisableHolder.stage.stageWidth;
                param1.y = 0;
                if (_mouseDisableHolder.numChildren < MAX_RANDOM_FLY)
                {
                    _mouseDisableHolder.addChild(param1);
                    _loc_5 = Math.random() * 2;
                    TweenLite.to(param1, 3, new TweenLiteVars({delay:_loc_5, y:_mouseDisableHolder.stage.stageHeight}).onComplete(onPiaoGiftflyComplete, [param1]).ease(Quad.easeIn));
                }
                else
                {
                    pushToRandomList(param1, param2);
                }
                _loc_4++;
            }
            return;
        }// end function

        public static function addFlyGiftAnimation(param1:BitmapData, param2:Point, param3:Point, param4:Number = 1) : void
        {
            var _loc_5:* = new Bitmap(param1);
            _mouseDisableHolder.addChild(_loc_5);
            _loc_5.x = param2.x;
            _loc_5.y = param2.y;
            var _loc_7:* = param4;
            _loc_5.scaleY = param4;
            _loc_5.scaleX = _loc_7;
            param3.x = param3.x + (Math.random() * 50 - 25);
            param3.y = param3.y + (Math.random() * 50 - 25);
            var _loc_6:* = new TimelineLite();
            _loc_6._gc = true;
            _loc_6.append(new TweenLite(_loc_5, 1, new TweenLiteVars().move(param3.x, param3.y)));
            _loc_6.append(new TweenLite(_loc_5, 0.3, new TweenLiteVars({alpha:0}).onComplete(onGiftflyComplete, [_loc_5])));
            return;
        }// end function

        private static function onPiaoGiftflyComplete(param1:DisplayObject) : void
        {
            var _loc_2:* = null;
            _mouseDisableHolder.removeChild(param1);
            if (param1 is EffectLoder)
            {
                _loc_2 = param1 as EffectLoder;
                _loc_2.unloadEffect();
            }
            param1 = null;
            popRandomList();
            return;
        }// end function

        private static function onGiftflyComplete(param1:DisplayObject) : void
        {
            _mouseDisableHolder.removeChild(param1);
            param1 = null;
            popRandomList();
            return;
        }// end function

        public static function addFlowerAnimation() : void
        {
            var _loc_1:* = new Bitmap(_flower);
            _loc_1.x = Math.random() * _mouseDisableHolder.stage.stageWidth;
            _loc_1.y = 0;
            var _loc_2:* = Math.random() * 0.6 + 0.4;
            _loc_1.scaleY = Math.random() * 0.6 + 0.4;
            _loc_1.scaleX = _loc_2;
            if (_mouseDisableHolder.numChildren < MAX_RANDOM_FLY)
            {
                _mouseDisableHolder.addChild(_loc_1);
                TweenLite.to(_loc_1, 3, new TweenLiteVars({y:_mouseDisableHolder.stage.stageHeight}).onComplete(onGiftflyComplete, [_loc_1]).ease(Linear.easeNone).rotation(Math.random() * 360).x(Math.random() * 100 - 50, true));
            }
            else
            {
                pushToRandomList(_loc_1, 0);
            }
            return;
        }// end function

        public static function addQueueAnimation(param1:IAnimation, param2:Boolean = false) : void
        {
            if (param2)
            {
                animationList.unshift(param1);
            }
            else
            {
                animationList.push(param1);
            }
            startAniQueue();
            return;
        }// end function

        public static function clearQueueAnimation() : void
        {
            while (animationList.length)
            {
                
                animationList.pop();
            }
            return;
        }// end function

        private static function startAniQueue() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_1:* = false;
            var _loc_2:* = 0;
            while (_loc_2 < _aniPlaying.length)
            {
                
                if (_aniPlaying[_loc_2] == null)
                {
                    _loc_1 = true;
                    break;
                }
                _loc_2++;
            }
            if (_loc_1 && animationList.length > 0)
            {
                _loc_3 = animationList.shift();
                _loc_3.addEventListener(AnimationEvent.COMPLETE, onAnimationComplete, false, 0, true);
                _mouseDisableHolder.addChild(_loc_3);
                _loc_4 = 0;
                while (_loc_4 < _aniPlaying.length)
                {
                    
                    if (_aniPlaying[_loc_4] == null)
                    {
                        _aniPlaying[_loc_4] = _loc_3;
                        _loc_3.y = _mouseDisableHolder.stage.stageHeight - 40 - _loc_4 * 40;
                        (_loc_3 as IAnimation).start();
                        break;
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

        private static function onAnimationComplete(event:AnimationEvent) : void
        {
            var _loc_2:* = event.target as Sprite;
            _aniPlaying[_aniPlaying.indexOf(_loc_2)] = null;
            _loc_2.removeEventListener(AnimationEvent.COMPLETE, onAnimationComplete, true);
            _mouseDisableHolder.removeChild(_loc_2);
            startAniQueue();
            return;
        }// end function

        public static function clearQueueAnimation2() : void
        {
            while (animationList2.length)
            {
                
                animationList2.pop();
            }
            return;
        }// end function

        public static function addQueueAnimation2(param1:IAnimation, param2:Boolean = false) : void
        {
            if (param2)
            {
                animationList2.unshift(param1);
            }
            else
            {
                animationList2.push(param1);
            }
            startAniQueue2();
            return;
        }// end function

        private static function startAniQueue2() : void
        {
            var _loc_1:* = null;
            if (currentAnimation2 == null && animationList2.length > 0)
            {
                _loc_1 = animationList2.shift();
                _loc_1.addEventListener(AnimationEvent.COMPLETE, onAnimationComplete2, false, 0, true);
                _mouseDisableHolder.addChild(_loc_1);
                currentAnimation2 = _loc_1;
                (currentAnimation2 as IAnimation).start();
            }
            return;
        }// end function

        private static function onAnimationComplete2(event:AnimationEvent) : void
        {
            currentAnimation2.removeEventListener(AnimationEvent.COMPLETE, onAnimationComplete2, true);
            _mouseDisableHolder.removeChild(currentAnimation2);
            currentAnimation2 = null;
            startAniQueue2();
            return;
        }// end function

        public static function clearQueueAnimation3() : void
        {
            while (animationList3.length)
            {
                
                animationList3.pop();
            }
            return;
        }// end function

        public static function addQueueAnimation3(param1:IAnimation, param2:Boolean = false) : void
        {
            if (param2)
            {
                animationList3.unshift(param1);
            }
            else
            {
                animationList3.push(param1);
            }
            startAniQueue3();
            return;
        }// end function

        private static function startAniQueue3() : void
        {
            var _loc_1:* = null;
            if (currentAnimation3 == null && animationList3.length > 0)
            {
                _loc_1 = animationList3.shift();
                _loc_1.addEventListener(AnimationEvent.COMPLETE, onAnimationComplete3, false, 0, true);
                _mouseEnableHolder.addChild(_loc_1);
                currentAnimation3 = _loc_1;
                (currentAnimation3 as IAnimation).start();
            }
            return;
        }// end function

        private static function onAnimationComplete3(event:AnimationEvent) : void
        {
            currentAnimation3.removeEventListener(AnimationEvent.COMPLETE, onAnimationComplete3, true);
            _mouseEnableHolder.removeChild(currentAnimation3);
            currentAnimation3 = null;
            startAniQueue3();
            return;
        }// end function

    }
}
