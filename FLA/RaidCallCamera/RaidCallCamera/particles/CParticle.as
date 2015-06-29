package particles
{
    import flash.display.*;

    public class CParticle extends Bitmap
    {
        public var speedX:Number = 0;
        public var speedY:Number = 0;
        public var duration:Number = 0;
        public var time:Number = 0;
        public var dead:Boolean;

        public function CParticle(param1:BitmapData = null)
        {
            super(param1);
            cacheAsBitmap = true;
            return;
        }// end function

        public function renderer() : void
        {
            x = x + this.speedX;
            y = y + this.speedY;
            alpha = alpha - 0.005;
            if (alpha == 0)
            {
                this.dead = true;
            }
            return;
        }// end function

    }
}
