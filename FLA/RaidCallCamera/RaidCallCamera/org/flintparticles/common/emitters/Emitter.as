package org.flintparticles.common.emitters
{
    import __AS3__.vec.*;
    import flash.events.*;
    import org.flintparticles.common.actions.*;
    import org.flintparticles.common.activities.*;
    import org.flintparticles.common.behaviours.*;
    import org.flintparticles.common.counters.*;
    import org.flintparticles.common.events.*;
    import org.flintparticles.common.initializers.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.common.utils.*;

    public class Emitter extends EventDispatcher
    {
        protected var _particleFactory:ParticleFactory;
        protected var _initializers:Vector.<Initializer>;
        protected var _actions:Vector.<Action>;
        protected var _activities:Vector.<Activity>;
        protected var _particles:Array;
        protected var _counter:Counter;
        protected var _useInternalTick:Boolean = true;
        protected var _fixedFrameTime:Number = 0;
        protected var _running:Boolean = false;
        protected var _started:Boolean = false;
        protected var _updating:Boolean = false;
        protected var _maximumFrameTime:Number = 0.1;
        protected var _dispatchCounterComplete:Boolean = false;
        protected var _processLastFirst:Boolean = false;

        public function Emitter()
        {
            this._particles = [];
            this._actions = new Vector.<Action>;
            this._initializers = new Vector.<Initializer>;
            this._activities = new Vector.<Activity>;
            this._counter = new ZeroCounter();
            return;
        }// end function

        public function get maximumFrameTime() : Number
        {
            return this._maximumFrameTime;
        }// end function

        public function set maximumFrameTime(param1:Number) : void
        {
            this._maximumFrameTime = param1;
            return;
        }// end function

        public function get initializers() : Vector.<Initializer>
        {
            return this._initializers;
        }// end function

        public function set initializers(param1:Vector.<Initializer>) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._initializers)
            {
                
                _loc_2.removedFromEmitter(this);
            }
            this._initializers = param1.slice();
            _loc_4.sort(this.prioritySort);
            for each (_loc_2 in param1)
            {
                
                _loc_2.addedToEmitter(this);
            }
            return;
        }// end function

        public function addInitializer(param1:Initializer) : void
        {
            var _loc_2:* = this._initializers.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._initializers[_loc_3].priority < param1.priority)
                {
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            this._initializers.splice(_loc_3, 0, param1);
            param1.addedToEmitter(this);
            return;
        }// end function

        public function removeInitializer(param1:Initializer) : void
        {
            var _loc_2:* = this._initializers.indexOf(param1);
            if (_loc_2 != -1)
            {
                this._initializers.splice(_loc_2, 1);
                param1.removedFromEmitter(this);
            }
            return;
        }// end function

        public function hasInitializer(param1:Initializer) : Boolean
        {
            return this._initializers.indexOf(param1) != -1;
        }// end function

        public function hasInitializerOfType(param1:Class) : Boolean
        {
            var _loc_2:* = this._initializers.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._initializers[_loc_3] is param1)
                {
                    return true;
                }
                _loc_3 = _loc_3 + 1;
            }
            return false;
        }// end function

        public function get actions() : Vector.<Action>
        {
            return this._actions;
        }// end function

        public function set actions(param1:Vector.<Action>) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._actions)
            {
                
                _loc_2.removedFromEmitter(this);
            }
            this._actions = param1.slice();
            _loc_4.sort(this.prioritySort);
            for each (_loc_2 in param1)
            {
                
                _loc_2.addedToEmitter(this);
            }
            return;
        }// end function

        public function addAction(param1:Action) : void
        {
            var _loc_2:* = this._actions.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._actions[_loc_3].priority < param1.priority)
                {
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            this._actions.splice(_loc_3, 0, param1);
            param1.addedToEmitter(this);
            return;
        }// end function

        public function removeAction(param1:Action) : void
        {
            var _loc_2:* = this._actions.indexOf(param1);
            if (_loc_2 != -1)
            {
                this._actions.splice(_loc_2, 1);
                param1.removedFromEmitter(this);
            }
            return;
        }// end function

        public function hasAction(param1:Action) : Boolean
        {
            return this._actions.indexOf(param1) != -1;
        }// end function

        public function hasActionOfType(param1:Class) : Boolean
        {
            var _loc_2:* = this._actions.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._actions[_loc_3] is param1)
                {
                    return true;
                }
                _loc_3 = _loc_3 + 1;
            }
            return false;
        }// end function

        public function get activities() : Vector.<Activity>
        {
            return this._activities;
        }// end function

        public function set activities(param1:Vector.<Activity>) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._activities)
            {
                
                _loc_2.removedFromEmitter(this);
            }
            this._activities = param1.slice();
            _loc_4.sort(this.prioritySort);
            for each (_loc_2 in this._activities)
            {
                
                _loc_2.addedToEmitter(this);
            }
            return;
        }// end function

        public function addActivity(param1:Activity) : void
        {
            var _loc_2:* = this._activities.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._activities[_loc_3].priority < param1.priority)
                {
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            this._activities.splice(_loc_3, 0, param1);
            param1.addedToEmitter(this);
            return;
        }// end function

        public function removeActivity(param1:Activity) : void
        {
            var _loc_2:* = this._activities.indexOf(param1);
            if (_loc_2 != -1)
            {
                this._activities.splice(_loc_2, 1);
                param1.removedFromEmitter(this);
            }
            return;
        }// end function

        public function hasActivity(param1:Activity) : Boolean
        {
            return this._activities.indexOf(param1) != -1;
        }// end function

        public function hasActivityOfType(param1:Class) : Boolean
        {
            var _loc_2:* = this._activities.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._activities[_loc_3] is param1)
                {
                    return true;
                }
                _loc_3 = _loc_3 + 1;
            }
            return false;
        }// end function

        public function get counter() : Counter
        {
            return this._counter;
        }// end function

        public function set counter(param1:Counter) : void
        {
            this._counter = param1;
            if (this.running)
            {
                this._counter.startEmitter(this);
            }
            return;
        }// end function

        public function dispatchCounterComplete() : void
        {
            this._dispatchCounterComplete = true;
            return;
        }// end function

        public function get useInternalTick() : Boolean
        {
            return this._useInternalTick;
        }// end function

        public function set useInternalTick(param1:Boolean) : void
        {
            if (this._useInternalTick != param1)
            {
                this._useInternalTick = param1;
                if (this._started)
                {
                    if (this._useInternalTick)
                    {
                        FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE, this.updateEventListener, false, 0, true);
                    }
                    else
                    {
                        FrameUpdater.instance.removeEventListener(UpdateEvent.UPDATE, this.updateEventListener);
                    }
                }
            }
            return;
        }// end function

        public function get fixedFrameTime() : Number
        {
            return this._fixedFrameTime;
        }// end function

        public function set fixedFrameTime(param1:Number) : void
        {
            this._fixedFrameTime = param1;
            return;
        }// end function

        public function get running() : Boolean
        {
            return this._running;
        }// end function

        public function get particleFactory() : ParticleFactory
        {
            return this._particleFactory;
        }// end function

        public function set particleFactory(param1:ParticleFactory) : void
        {
            this._particleFactory = param1;
            return;
        }// end function

        public function get particles() : Vector.<Particle>
        {
            return this.Vector.<Particle>(this._particles);
        }// end function

        public function set particles(param1:Vector.<Particle>) : void
        {
            this.killAllParticles();
            this.addParticles(param1, false);
            return;
        }// end function

        public function get particlesArray() : Array
        {
            return this._particles;
        }// end function

        protected function createParticle() : Particle
        {
            var _loc_1:* = this._particleFactory.org.flintparticles.common.particles:ParticleFactory::createParticle();
            var _loc_2:* = this._initializers.length;
            this.initParticle(_loc_1);
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                Initializer(this._initializers[_loc_3]).initialize(this, _loc_1);
                _loc_3++;
            }
            this._particles.push(_loc_1);
            if (hasEventListener(ParticleEvent.PARTICLE_CREATED))
            {
                dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_CREATED, _loc_1));
            }
            return _loc_1;
        }// end function

        protected function initParticle(param1:Particle) : void
        {
            return;
        }// end function

        public function addParticle(param1:Particle, param2:Boolean = false) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (param2)
            {
                _loc_3 = this._initializers.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    this._initializers[_loc_4].initialize(this, param1);
                    _loc_4++;
                }
            }
            this._particles.push(param1);
            if (hasEventListener(ParticleEvent.PARTICLE_ADDED))
            {
                dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_ADDED, param1));
            }
            return;
        }// end function

        public function addParticles(param1:Vector.<Particle>, param2:Boolean = false) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_3:* = param1.length;
            if (param2)
            {
                _loc_5 = this._initializers.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3)
                    {
                        
                        this._initializers[_loc_6].initialize(this, param1[_loc_4]);
                        _loc_4++;
                    }
                    _loc_6++;
                }
            }
            if (hasEventListener(ParticleEvent.PARTICLE_ADDED))
            {
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    this._particles.push(param1[_loc_4]);
                    dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_ADDED, param1[_loc_4]));
                    _loc_4++;
                }
            }
            else
            {
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    this._particles.push(param1[_loc_4]);
                    _loc_4++;
                }
            }
            return;
        }// end function

        public function removeParticle(param1:Particle) : Boolean
        {
            var particle:* = param1;
            var index:* = this._particles.indexOf(particle);
            if (index != -1)
            {
                if (this._updating)
                {
                    addEventListener(EmitterEvent.EMITTER_UPDATED, function (event:EmitterEvent) : void
            {
                removeEventListener(EmitterEvent.EMITTER_UPDATED, arguments.callee);
                removeParticle(particle);
                return;
            }// end function
            );
                }
                else
                {
                    this._particles.splice(index, 1);
                    dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_REMOVED, particle));
                }
                return true;
            }
            return false;
        }// end function

        public function removeParticles(param1:Vector.<Particle>) : void
        {
            var i:int;
            var len:int;
            var index:int;
            var particles:* = param1;
            if (this._updating)
            {
                addEventListener(EmitterEvent.EMITTER_UPDATED, function (event:EmitterEvent) : void
            {
                removeEventListener(EmitterEvent.EMITTER_UPDATED, arguments.callee);
                removeParticles(particles);
                return;
            }// end function
            );
            }
            else
            {
                i;
                len = particles.length;
                while (i < len)
                {
                    
                    index = this._particles.indexOf(particles[i]);
                    if (index != -1)
                    {
                        this._particles.splice(index, 1);
                        dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_REMOVED, particles[i]));
                    }
                    i = (i + 1);
                }
            }
            return;
        }// end function

        public function killAllParticles() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = this._particles.length;
            if (hasEventListener(ParticleEvent.PARTICLE_DEAD))
            {
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD, this._particles[_loc_2]));
                    this._particleFactory.disposeParticle(this._particles[_loc_2]);
                    _loc_2++;
                }
            }
            else
            {
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    this._particleFactory.disposeParticle(this._particles[_loc_2]);
                    _loc_2++;
                }
            }
            this._particles.length = 0;
            return;
        }// end function

        public function start() : void
        {
            if (this._useInternalTick)
            {
                FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE, this.updateEventListener, false, 0, true);
            }
            this._started = true;
            this._running = true;
            var _loc_1:* = this._activities.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                Activity(this._activities[_loc_2]).org.flintparticles.common.activities:Activity::initialize(this);
                _loc_2++;
            }
            _loc_1 = this._counter.startEmitter(this);
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this.createParticle();
                _loc_2++;
            }
            return;
        }// end function

        private function updateEventListener(event:UpdateEvent) : void
        {
            if (this._fixedFrameTime)
            {
                this.update(this._fixedFrameTime);
            }
            else
            {
                this.update(event.time);
            }
            return;
        }// end function

        public function update(param1:Number) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (!this._running)
            {
                return;
            }
            if (param1 > this._maximumFrameTime)
            {
                param1 = this._maximumFrameTime;
            }
            this._updating = true;
            var _loc_4:* = this._counter.updateEmitter(this, param1);
            _loc_2 = 0;
            while (_loc_2 < _loc_4)
            {
                
                this.createParticle();
                _loc_2++;
            }
            this.sortParticles();
            _loc_4 = this._activities.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_4)
            {
                
                Activity(this._activities[_loc_2]).update(this, param1);
                _loc_2++;
            }
            if (this._particles.length > 0)
            {
                _loc_4 = this._actions.length;
                _loc_6 = this._particles.length;
                if (this._processLastFirst)
                {
                    _loc_7 = 0;
                    while (_loc_7 < _loc_4)
                    {
                        
                        _loc_5 = this._actions[_loc_7];
                        _loc_2 = _loc_6 - 1;
                        while (_loc_2 >= 0)
                        {
                            
                            _loc_3 = this._particles[_loc_2];
                            _loc_5.org.flintparticles.common.actions:Action::update(this, _loc_3, param1);
                            _loc_2 = _loc_2 - 1;
                        }
                        _loc_7++;
                    }
                }
                else
                {
                    _loc_7 = 0;
                    while (_loc_7 < _loc_4)
                    {
                        
                        _loc_5 = this._actions[_loc_7];
                        _loc_2 = 0;
                        while (_loc_2 < _loc_6)
                        {
                            
                            _loc_3 = this._particles[_loc_2];
                            _loc_5.org.flintparticles.common.actions:Action::update(this, _loc_3, param1);
                            _loc_2++;
                        }
                        _loc_7++;
                    }
                }
                this._processLastFirst = !this._processLastFirst;
                if (hasEventListener(ParticleEvent.PARTICLE_DEAD))
                {
                    _loc_2 = _loc_6;
                    while (_loc_2--)
                    {
                        
                        _loc_3 = this._particles[_loc_2];
                        if (_loc_3.isDead)
                        {
                            this._particles.splice(_loc_2, 1);
                            dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD, _loc_3));
                            if (_loc_3.isDead)
                            {
                                this._particleFactory.disposeParticle(_loc_3);
                            }
                        }
                    }
                }
                else
                {
                    _loc_2 = _loc_6;
                    while (_loc_2--)
                    {
                        
                        _loc_3 = this._particles[_loc_2];
                        if (_loc_3.isDead)
                        {
                            this._particles.splice(_loc_2, 1);
                            this._particleFactory.disposeParticle(_loc_3);
                        }
                    }
                }
            }
            else if (hasEventListener(EmitterEvent.EMITTER_EMPTY))
            {
                dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_EMPTY));
            }
            this._updating = false;
            if (hasEventListener(EmitterEvent.EMITTER_UPDATED))
            {
                dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_UPDATED));
            }
            if (this._dispatchCounterComplete)
            {
                this._dispatchCounterComplete = false;
                if (hasEventListener(EmitterEvent.COUNTER_COMPLETE))
                {
                    dispatchEvent(new EmitterEvent(EmitterEvent.COUNTER_COMPLETE));
                }
            }
            return;
        }// end function

        protected function sortParticles() : void
        {
            return;
        }// end function

        public function pause() : void
        {
            this._running = false;
            return;
        }// end function

        public function resume() : void
        {
            this._running = true;
            return;
        }// end function

        public function stop() : void
        {
            if (this._useInternalTick)
            {
                FrameUpdater.instance.removeEventListener(UpdateEvent.UPDATE, this.updateEventListener);
            }
            this._started = false;
            this._running = false;
            this.killAllParticles();
            return;
        }// end function

        public function runAhead(param1:Number, param2:Number = 10) : void
        {
            var _loc_3:* = this._maximumFrameTime;
            var _loc_4:* = 1 / param2;
            this._maximumFrameTime = _loc_4;
            while (param1 > 0)
            {
                
                param1 = param1 - _loc_4;
                this.update(_loc_4);
            }
            this._maximumFrameTime = _loc_3;
            return;
        }// end function

        private function prioritySort(param1:Behaviour, param2:Behaviour) : Number
        {
            return param1.priority - param2.priority;
        }// end function

    }
}
