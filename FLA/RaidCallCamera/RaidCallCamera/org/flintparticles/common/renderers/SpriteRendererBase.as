package org.flintparticles.common.renderers
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.events.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.common.renderers.*;

    public class SpriteRendererBase extends Sprite implements Renderer
    {
        protected var _emitters:Vector.<Emitter>;
        protected var _particles:Array;

        public function SpriteRendererBase()
        {
            this._emitters = new Vector.<Emitter>;
            this._particles = [];
            mouseEnabled = false;
            mouseChildren = false;
            addEventListener(Event.ADDED_TO_STAGE, this.addedToStage, false, 0, true);
            return;
        }// end function

        public function addEmitter(param1:Emitter) : void
        {
            var _loc_2:* = null;
            this._emitters.push(param1);
            if (stage)
            {
                stage.invalidate();
            }
            param1.addEventListener(EmitterEvent.EMITTER_UPDATED, this.emitterUpdated, false, 0, true);
            param1.addEventListener(ParticleEvent.PARTICLE_CREATED, this.particleAdded, false, 0, true);
            param1.addEventListener(ParticleEvent.PARTICLE_ADDED, this.particleAdded, false, 0, true);
            param1.addEventListener(ParticleEvent.PARTICLE_DEAD, this.particleRemoved, false, 0, true);
            param1.addEventListener(ParticleEvent.PARTICLE_REMOVED, this.particleRemoved, false, 0, true);
            for each (_loc_2 in param1.particlesArray)
            {
                
                this.addParticle(_loc_2);
            }
            if (this._emitters.length == 1)
            {
                addEventListener(Event.RENDER, this.updateParticles, false, 0, true);
            }
            return;
        }// end function

        public function removeEmitter(param1:Emitter) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._emitters.length)
            {
                
                if (this._emitters[_loc_2] == param1)
                {
                    this._emitters.splice(_loc_2, 1);
                    param1.removeEventListener(EmitterEvent.EMITTER_UPDATED, this.emitterUpdated);
                    param1.removeEventListener(ParticleEvent.PARTICLE_CREATED, this.particleAdded);
                    param1.removeEventListener(ParticleEvent.PARTICLE_ADDED, this.particleAdded);
                    param1.removeEventListener(ParticleEvent.PARTICLE_DEAD, this.particleRemoved);
                    param1.removeEventListener(ParticleEvent.PARTICLE_REMOVED, this.particleRemoved);
                    for each (_loc_3 in param1.particlesArray)
                    {
                        
                        this.removeParticle(_loc_3);
                    }
                    if (this._emitters.length == 0)
                    {
                        removeEventListener(Event.RENDER, this.updateParticles);
                        this.renderParticles([]);
                    }
                    else if (stage)
                    {
                        stage.invalidate();
                    }
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function addedToStage(event:Event) : void
        {
            if (stage)
            {
                stage.invalidate();
            }
            return;
        }// end function

        private function particleAdded(event:ParticleEvent) : void
        {
            this.addParticle(event.particle);
            if (stage)
            {
                stage.invalidate();
            }
            return;
        }// end function

        private function particleRemoved(event:ParticleEvent) : void
        {
            this.removeParticle(event.particle);
            if (stage)
            {
                stage.invalidate();
            }
            return;
        }// end function

        protected function emitterUpdated(event:EmitterEvent) : void
        {
            if (stage)
            {
                stage.invalidate();
            }
            return;
        }// end function

        protected function updateParticles(event:Event) : void
        {
            this.renderParticles(this._particles);
            return;
        }// end function

        protected function addParticle(param1:Particle) : void
        {
            this._particles.push(param1);
            return;
        }// end function

        protected function removeParticle(param1:Particle) : void
        {
            var _loc_2:* = this._particles.indexOf(param1);
            if (_loc_2 != -1)
            {
                this._particles.splice(_loc_2, 1);
            }
            return;
        }// end function

        protected function renderParticles(param1:Array) : void
        {
            return;
        }// end function

        public function get emitters() : Vector.<Emitter>
        {
            return this._emitters;
        }// end function

        public function set emitters(param1:Vector.<Emitter>) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._emitters)
            {
                
                this.removeEmitter(_loc_2);
            }
            for each (_loc_2 in param1)
            {
                
                this.addEmitter(_loc_2);
            }
            return;
        }// end function

    }
}
