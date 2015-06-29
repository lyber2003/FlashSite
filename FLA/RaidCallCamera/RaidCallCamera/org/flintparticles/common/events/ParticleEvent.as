package org.flintparticles.common.events
{
    import flash.events.*;
    import org.flintparticles.common.particles.*;

    public class ParticleEvent extends Event
    {
        public var particle:Particle;
        public var otherObject:Object;
        public static var PARTICLE_CREATED:String = "particleCreated";
        public static var PARTICLE_DEAD:String = "particleDead";
        public static var PARTICLE_ADDED:String = "particleAdded";
        public static var PARTICLE_REMOVED:String = "particleRemoved";
        public static var PARTICLES_COLLISION:String = "particlesCollision";
        public static var ZONE_COLLISION:String = "zoneCollision";
        public static var BOUNDING_BOX_COLLISION:String = "boundingBoxCollision";

        public function ParticleEvent(param1:String, param2:Particle = null, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1, param3, param4);
            this.particle = param2;
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new ParticleEvent(type, this.particle, bubbles, cancelable);
            _loc_1.otherObject = this.otherObject;
            return _loc_1;
        }// end function

    }
}
