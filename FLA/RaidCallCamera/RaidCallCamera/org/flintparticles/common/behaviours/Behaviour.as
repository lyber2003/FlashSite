﻿package org.flintparticles.common.behaviours
{
    import org.flintparticles.common.emitters.*;

    public interface Behaviour
    {

        public function Behaviour();

        function get priority() : int;

        function set priority(param1:int) : void;

        function addedToEmitter(param1:Emitter) : void;

        function removedFromEmitter(param1:Emitter) : void;

    }
}
