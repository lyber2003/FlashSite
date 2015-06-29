package org.flintparticles.common.activities
{
    import org.flintparticles.common.behaviours.*;
    import org.flintparticles.common.emitters.*;

    public interface Activity extends Behaviour
    {

        public function Activity();

        function initialize(param1:Emitter) : void;

        function update(param1:Emitter, param2:Number) : void;

    }
}
