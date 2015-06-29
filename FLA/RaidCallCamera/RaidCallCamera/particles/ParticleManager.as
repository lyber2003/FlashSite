package particles
{
    import flash.display.*;
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.twoD.renderers.*;

    public class ParticleManager extends Object
    {
        private static var holder:Sprite;
        private static var displayObjectRenderer:DisplayObjectRenderer = new DisplayObjectRenderer();

        public function ParticleManager()
        {
            return;
        }// end function

        public static function init(param1:Sprite) : void
        {
            holder = param1;
            holder.addChild(displayObjectRenderer);
            return;
        }// end function

        public static function addEmitter(param1:Emitter) : void
        {
            displayObjectRenderer.addEmitter(param1);
            return;
        }// end function

        public static function removeEmitter(param1:Emitter) : void
        {
            displayObjectRenderer.removeEmitter(param1);
            return;
        }// end function

        public static function addEffect(param1:DisplayObject) : void
        {
            holder.addChild(param1);
            return;
        }// end function

        public static function removeEffect(param1:DisplayObject) : void
        {
            holder.removeChild(param1);
            return;
        }// end function

    }
}
