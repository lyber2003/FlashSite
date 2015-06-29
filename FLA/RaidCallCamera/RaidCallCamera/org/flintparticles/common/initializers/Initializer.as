package org.flintparticles.common.initializers
{
    import org.flintparticles.common.behaviours.*;
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;

    public interface Initializer extends Behaviour
    {

        public function Initializer();

        function initialize(param1:Emitter, param2:Particle) : void;

    }
}
