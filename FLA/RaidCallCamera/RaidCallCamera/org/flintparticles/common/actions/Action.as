package org.flintparticles.common.actions
{
    import org.flintparticles.common.behaviours.*;
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;

    public interface Action extends Behaviour
    {

        public function Action();

        function update(param1:Emitter, param2:Particle, param3:Number) : void;

    }
}
