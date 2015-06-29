﻿package org.flintparticles.twoD.renderers
{
    import flash.display.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.common.renderers.*;
    import org.flintparticles.twoD.particles.*;

    public class DisplayObjectRenderer extends SpriteRendererBase
    {

        public function DisplayObjectRenderer()
        {
            return;
        }// end function

        override protected function renderParticles(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = param1.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_2 = Particle2D(param1[_loc_5]);
                _loc_3 = _loc_2.image;
                _loc_3.transform.colorTransform = _loc_2.colorTransform;
                _loc_3.transform.matrix = _loc_2.matrixTransform;
                _loc_5++;
            }
            return;
        }// end function

        override protected function addParticle(param1:Particle) : void
        {
            super.addParticle(param1);
            var _loc_2:* = param1 as Particle2D;
            addChildAt(_loc_2.image, 0);
            var _loc_3:* = _loc_2.image;
            _loc_3.transform.colorTransform = _loc_2.colorTransform;
            _loc_3.transform.matrix = _loc_2.matrixTransform;
            return;
        }// end function

        override protected function removeParticle(param1:Particle) : void
        {
            removeChild(param1.image);
            super.removeParticle(param1);
            return;
        }// end function

    }
}
