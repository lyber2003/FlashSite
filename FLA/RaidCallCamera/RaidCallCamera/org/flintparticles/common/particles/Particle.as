package org.flintparticles.common.particles
{
    import flash.geom.*;
    import flash.utils.*;

    public class Particle extends Object
    {
        public var color:uint = 4.29497e+009;
        private var _colorTransform:ColorTransform = null;
        private var _previousColor:uint;
        public var scale:Number = 1;
        public var mass:Number = 1;
        public var collisionRadius:Number = 1;
        public var image:Object = null;
        public var lifetime:Number = 0;
        public var age:Number = 0;
        public var energy:Number = 1;
        public var isDead:Boolean = false;
        private var _dictionary:Dictionary = null;

        public function Particle()
        {
            return;
        }// end function

        public function get dictionary() : Dictionary
        {
            if (this._dictionary == null)
            {
                this._dictionary = new Dictionary(true);
            }
            return this._dictionary;
        }// end function

        public function initialize() : void
        {
            this.color = 4294967295;
            this.scale = 1;
            this.mass = 1;
            this.collisionRadius = 1;
            this.lifetime = 0;
            this.age = 0;
            this.energy = 1;
            this.isDead = false;
            this.image = null;
            this._dictionary = null;
            this._colorTransform = null;
            return;
        }// end function

        public function get colorTransform() : ColorTransform
        {
            if (!this._colorTransform || this._previousColor != this.color)
            {
                this._colorTransform = new ColorTransform((this.color >>> 16 & 255) / 255, (this.color >>> 8 & 255) / 255, (this.color & 255) / 255, (this.color >>> 24 & 255) / 255, 0, 0, 0, 0);
                this._previousColor = this.color;
            }
            return this._colorTransform;
        }// end function

        public function get alpha() : Number
        {
            return ((this.color & 4278190080) >>> 24) / 255;
        }// end function

        protected function cloneInto(param1:Particle) : Particle
        {
            var _loc_2:* = null;
            param1.color = this.color;
            param1.scale = this.scale;
            param1.mass = this.mass;
            param1.collisionRadius = this.collisionRadius;
            param1.lifetime = this.lifetime;
            param1.age = this.age;
            param1.energy = this.energy;
            param1.isDead = this.isDead;
            param1.image = this.image;
            if (this._dictionary)
            {
                param1._dictionary = new Dictionary(true);
                for (_loc_2 in this._dictionary)
                {
                    
                    param1._dictionary[_loc_2] = _loc_4[_loc_2];
                }
            }
            return param1;
        }// end function

        public function clone(param1:ParticleFactory = null) : Particle
        {
            var _loc_2:* = null;
            if (param1)
            {
                _loc_2 = param1.createParticle();
            }
            else
            {
                _loc_2 = new Particle();
            }
            return this.cloneInto(_loc_2);
        }// end function

        public function revive() : void
        {
            this.lifetime = 0;
            this.age = 0;
            this.energy = 1;
            this.isDead = false;
            return;
        }// end function

    }
}
