package com.raidcall.rclive.__internal__
{
    import __AS3__.vec.*;
    import com.raidcall.rclive.__internal__.kernel.*;
    import com.raidcall.rclive.__internal__.vfs.*;
    import flash.utils.*;

    public class CModule extends Object
    {
        private var sections:Object;
        private var init:Function;
        private var script:Object;
        private var modSyms:Array;
        private var modPackage:String;
        private var fixups:Vector.<int>;
        public const oncep:int;
        static var weakResolvers:Vector.<Function> = new Vector.<Function>;
        private static var workerSprite:Object = null;
        public static var recordFixups:Boolean = false;
        public static var regsInitted:Boolean = false;
        static var preppedForThreadedExec:Boolean = false;
        static var explicitlyInittedAllModules:Boolean = false;
        static const modThunks:Dictionary = new Dictionary();
        static var text:int = -268435456;
        static const scratchBA:ByteArray = new ByteArray();
        static const modules:Vector.<CModule> = new Vector.<CModule>;
        private static var seenModuleInit:Boolean;
        private static var telemetrySupported:Boolean = true;
        private static var cachedCSyms:Dictionary = new Dictionary();
        private static var toBeMapped:Vector.<CModule> = modules;
        public static var rootSprite:Object;
        private static var _kernel:Object = null;
        public static var activeConsole:Object;
        private static var _vfs:Object = null;

        public function CModule(param1:Object, param2:Function, param3:Array, param4:String)
        {
            this.sections = param1;
            this.init = param2;
            this.modSyms = param3;
            this.modPackage = param4;
            this.oncep = (workerClass ? (workerClass.current.getSharedProperty("flascc." + param4 + ".oncep")) : (0)) || this.sbrk(1, 1);
            if (recordFixups)
            {
                fixups = new Vector.<int>;
            }
            return;
        }// end function

        public function once(param1:Function, ... args) : void
        {
            if (workerClass)
            {
                this.threadArbMutexLock();
            }
            args = 0;
            if (!read8(oncep))
            {
                write8(oncep, 1);
                param1.apply(undefined, args);
            }
            ;
            var _loc_4:* = null;
            args = 1;
            if (workerClass)
            {
                this.threadArbMutexUnlock();
            }
            switch(args) branch count is:<0>[11] default offset is:<8>;
            throw _loc_4;
            return;
        }// end function

        public function fixup32(param1:int, param2:int) : void
        {
            if (fixups)
            {
                fixups.push(param1);
            }
            write32(param1, param2);
            return;
        }// end function

        public function fixup16(param1:int, param2:int) : void
        {
            write16(param1, param2);
            return;
        }// end function

        public function fixup8(param1:int, param2:int) : void
        {
            write8(param1, param2);
            return;
        }// end function

        public function getFixups() : Vector.<int>
        {
            return fixups ? (fixups.concat()) : (null);
        }// end function

        public function getSections() : Object
        {
            var _loc_2:* = {};
            for (_loc_1 in sections)
            {
                
                _loc_2[_loc_1] = _loc_3[_loc_1].concat();
            }
            return _loc_2;
        }// end function

        private function mapCsymsWithExplicitValues(param1:Dictionary) : void
        {
            var _loc_15:* = 0;
            var _loc_12:* = 0;
            var _loc_4:* = null;
            var _loc_8:* = null;
            var _loc_16:* = null;
            var _loc_3:* = 0;
            var _loc_7:* = null;
            var _loc_11:* = null;
            var _loc_5:* = null;
            if (!script)
            {
                return;
            }
            if (modSyms)
            {
                _loc_12 = 0;
                while (_loc_12 < modSyms.length)
                {
                    
                    _loc_4 = modSyms[_loc_12];
                    if (_loc_4.length >= 4)
                    {
                        _loc_8 = _loc_4[1];
                        _loc_16 = _loc_4[2];
                        _loc_3 = _loc_4[3];
                        if (_loc_4[0] == "t")
                        {
                            _loc_15 = script[_loc_8];
                        }
                        else
                        {
                            _loc_15 = script[_loc_8];
                        }
                        param1[_loc_16 + "/" + _loc_15] = _loc_3 + sections[_loc_16][0];
                    }
                    _loc_12++;
                }
            }
            else
            {
                var _loc_10:* = CModule.describeType(script);
                var _loc_19:* = CModule.describeType(script)..metadata;
                var _loc_20:* = 0;
                var _loc_22:* = new XMLList("");
                for each (_loc_21 in _loc_19)
                {
                    
                    with (_loc_19[_loc_20])
                    {
                        if (@name == "Csym")
                        {
                            _loc_22[_loc_20] = _loc_21;
                        }
                    }
                }
                for each (_loc_14 in _loc_22)
                {
                    
                    _loc_7 = (_loc_14).parent();
                    if (!(!_loc_7 || _loc_7.name() != "constant"))
                    {
                        _loc_11 = _loc_14..arg;
                        if (_loc_11.length() >= 4)
                        {
                            _loc_5 = [];
                            var _loc_24:* = 0;
                            var _loc_23:* = _loc_11;
                            while (_loc_23 in _loc_24)
                            {
                                
                                _loc_5.push((_loc_23[_loc_24]).@value);
                            }
                            var _loc_18:* = _loc_7.@name;
                            _loc_15 = script[_loc_18];
                            param1[_loc_5[2] + "/" + _loc_15] = _loc_5[3] + sections[_loc_5[2]][0];
                        }
                    }
                }
            }
            return;
        }// end function

        public function getSymsUsingMD() : Array
        {
            var _loc_1:* = CModule.mapCsymsWithExplicitValues();
            return getSymsUsingMDWithExplicitSyms(_loc_1);
        }// end function

        private function getSymsUsingMDWithExplicitSyms(param1:Dictionary) : Array
        {
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_14:* = 0;
            var _loc_5:* = null;
            var _loc_15:* = null;
            var _loc_9:* = null;
            var _loc_20:* = null;
            var _loc_6:* = null;
            var _loc_12:* = null;
            var _loc_17:* = null;
            var _loc_8:* = null;
            var _loc_4:* = null;
            var _loc_13:* = getScript();
            var _loc_2:* = [];
            if (modSyms)
            {
                _loc_14 = 0;
                while (_loc_14 < modSyms.length)
                {
                    
                    _loc_5 = modSyms[_loc_14];
                    _loc_15 = _loc_5[0];
                    _loc_9 = _loc_5[1];
                    if (_loc_5.length == 2)
                    {
                        _loc_2.push([_loc_15, _loc_9]);
                    }
                    else
                    {
                        _loc_20 = _loc_5[2];
                        if (_loc_15 == "t")
                        {
                            _loc_18 = _loc_13[_loc_9];
                        }
                        else
                        {
                            _loc_18 = _loc_13[_loc_9];
                        }
                        _loc_19 = _loc_20 + "/" + _loc_18;
                        if (typeof(param1[_loc_19]) != "undefined")
                        {
                            _loc_18 = param1[_loc_19];
                        }
                        _loc_2.push([_loc_15, _loc_9, _loc_20, _loc_18]);
                    }
                    _loc_14++;
                }
            }
            else
            {
                var _loc_11:* = CModule.describeType(_loc_13);
                var _loc_23:* = CModule.describeType(_loc_13)..metadata;
                var _loc_24:* = 0;
                var _loc_26:* = new XMLList("");
                for each (_loc_25 in _loc_23)
                {
                    
                    with (_loc_23[_loc_24])
                    {
                        if (@name == "Csym")
                        {
                            _loc_26[_loc_24] = _loc_25;
                        }
                    }
                }
                for each (_loc_16 in _loc_26)
                {
                    
                    _loc_6 = [];
                    var _loc_28:* = 0;
                    var _loc_27:* = _loc_16..arg;
                    while (_loc_27 in _loc_28)
                    {
                        
                        _loc_6.push((_loc_27[_loc_28]).@value);
                    }
                    _loc_12 = _loc_6[0];
                    _loc_17 = _loc_6[1];
                    _loc_8 = _loc_16.parent();
                    if (_loc_8 && _loc_8.name() == "constant")
                    {
                        _loc_4 = _loc_6[2];
                        var _loc_22:* = _loc_8.@name;
                        _loc_18 = _loc_13[_loc_22];
                        _loc_19 = _loc_4 + "/" + _loc_18;
                        if (typeof(param1[_loc_19]) != "undefined")
                        {
                            _loc_18 = param1[_loc_19];
                        }
                        _loc_2.push([_loc_12, _loc_17, _loc_4, _loc_18]);
                        continue;
                    }
                    _loc_2.push([_loc_12, _loc_17]);
                }
            }
            return _loc_2;
        }// end function

        public function notifyInit(param1:Object) : void
        {
            var _loc_3:* = com.raidcall.rclive.__internal__;
            seenModuleInit = true;
            var _loc_2:* = modThunks[modPackage];
            if (_loc_2)
            {
                this._loc_2();
            }
            this.script = param1;
            this.init = null;
            try
            {
                AlcDbgHelper.notifyScriptInit(this);
            }
            catch (e)
            {
                try
                {
                }
                if (param1["ESP"])
                {
                    CModule.regsInitted = true;
                }
            }
            catch (e)
            {
            }
            return;
        }// end function

        public function getScript() : Object
        {
            if (!script)
            {
                this.init();
            }
            return script;
        }// end function

        public function getPublicSym(param1:String) : int
        {
            var _loc_3:* = getScript();
            return _loc_3["_" + param1];
        }// end function

        public function runCtors() : void
        {
            var _loc_5:* = 0;
            var _loc_1:* = undefined;
            var _loc_2:* = 0;
            var _loc_4:* = 0;
            var _loc_3:* = sections[".ctors"];
            if (_loc_3)
            {
                _loc_5 = _loc_3[1];
                _loc_1 = new Vector.<int>;
                if (_loc_5)
                {
                    getScript();
                }
                _loc_2 = _loc_3[0];
                while (_loc_5 >= 4)
                {
                    
                    _loc_4 = read32(_loc_2);
                    if (_loc_4)
                    {
                        callI(_loc_4, _loc_1);
                    }
                    _loc_5 = _loc_5 - 4;
                    _loc_2 = _loc_2 + 4;
                }
            }
            return;
        }// end function

        public function runDtors() : void
        {
            var _loc_5:* = 0;
            var _loc_3:* = 0;
            var _loc_2:* = undefined;
            var _loc_4:* = 0;
            var _loc_1:* = sections[".dtors"];
            if (_loc_1)
            {
                _loc_5 = _loc_1[1];
                _loc_3 = _loc_1[0];
                _loc_2 = new Vector.<int>;
                if (_loc_5)
                {
                    getScript();
                }
                while (_loc_5 >= 4)
                {
                    
                    _loc_4 = read32(_loc_3);
                    if (_loc_4)
                    {
                        callI(_loc_4, _loc_2);
                    }
                    _loc_5 = _loc_5 - 4;
                    _loc_3 = _loc_3 + 4;
                }
            }
            return;
        }// end function

        public static function get ram() : ByteArray
        {
            return ram;
        }// end function

        public static function get throwWhenOutOfMemory() : Boolean
        {
            return throwWhenOutOfMemory;
        }// end function

        public static function set throwWhenOutOfMemory(param1:Boolean) : void
        {
            throwWhenOutOfMemory = param1;
            return;
        }// end function

        public static function get canUseWorkers() : Boolean
        {
            return workerClass;
        }// end function

        public static function resolveWeaks(param1:Function) : void
        {
            weakResolvers.unshift(param1);
            while (weakResolvers.length)
            {
                
                if (!CModule.weakResolvers.pop()())
                {
                    weakResolvers.unshift(param1);
                }
            }
            return;
        }// end function

        public static function runningAsWorker() : Boolean
        {
            var _loc_1:* = false;
            if (!CModule.rootSprite)
            {
                throw new Error("specify a rootSprite using \"CModule.rootSprite = ...\"");
            }
            try
            {
                workerSWFBytes = CModule.rootSprite.loaderInfo.bytes;
                if (workerClass["current"].getSharedProperty("flascc.ram"))
                {
                    _loc_1 = true;
                }
            }
            catch (e)
            {
                _loc_1 = false;
            }
            if (_loc_1)
            {
                workerSprite = new AlcWorkerSprite();
            }
            return _loc_1;
        }// end function

        public static function getPublicSymbol(param1:String) : int
        {
            var _loc_3:* = "_" + param1;
            return [_loc_3];
        }// end function

        public static function getSymsUsingMD() : Array
        {
            var _loc_3:* = mapCsymsWithExplicitValues();
            var _loc_1:* = [];
            for (_loc_1 in modules)
            {
                
            }
            return _loc_1;
        }// end function

        public static function prepForThreadedExec() : void
        {
            if (preppedForThreadedExec)
            {
                return;
            }
            if (typeof(ptr2fun) == "undefined" || ptr2fun is Array)
            {
                explicitlyInitAllModules();
            }
            preppedForThreadedExec = true;
            return;
        }// end function

        public static function explicitlyInitAllModules() : void
        {
            if (explicitlyInittedAllModules)
            {
                return;
            }
            var _loc_2:* = false;
            try
            {
                AlcDbgHelper.pauseLibraryNotifications();
                _loc_2 = true;
            }
            catch (e)
            {
            }
            var _loc_5:* = 0;
            for each (_loc_1 in getModuleVector())
            {
                
                _loc_1.getScript();
            }
            ;
            var _loc_8:* = null;
            _loc_5 = 1;
            try
            {
                if (_loc_2)
                {
                    AlcDbgHelper.resumeLibraryNotifications();
                }
            }
            catch (e)
            {
            }
            switch(_loc_5) branch count is:<0>[11] default offset is:<8>;
            throw _loc_8;
            explicitlyInittedAllModules = true;
            return;
        }// end function

        static function makeThunk(param1:String, param2:Dictionary, param3:int, param4:int, param5:int) : Function
        {
            return new ThunkMaker(param1, param2, param3, param4, param5).thunk;
        }// end function

        public static function allocFunPtrs(param1:String, param2:int, param3:int) : int
        {
            var _loc_4:* = null;
            var _loc_8:* = 0;
            if (param3 < 1)
            {
                param3 = 1;
            }
            ptr2fun_init.length = (ptr2fun_init.length + param3 - 1) / param3 * param3;
            var _loc_5:* = ptr2fun_init.length;
            ptr2fun_init.length = ptr2fun_init.length + param2;
            if (param1 != null && workerClass)
            {
                _loc_4 = new Dictionary();
                _loc_8 = _loc_5;
                while (_loc_8 < _loc_5 + param2)
                {
                    
                    var _loc_6:* = makeThunk(param1, _loc_4, _loc_5, _loc_5 + param2, _loc_8);
                    _loc_4[_loc_6] = true;
                    ptr2fun_init[_loc_8] = _loc_6;
                    _loc_8++;
                }
                var _loc_7:* = makeThunk(param1, _loc_4, _loc_5, _loc_5 + param2, -1);
                modThunks[param1] = _loc_7;
                _loc_4[_loc_7] = true;
            }
            return _loc_5;
        }// end function

        public static function allocTextSect(param1:String, param2:String, param3:int) : int
        {
            var _loc_4:* = text + 15 & -16;
            text = (text + 15 & -16) + param3;
            return _loc_4;
        }// end function

        public static function allocDataSect(param1:String, param2:String, param3:int, param4:int) : int
        {
            var _loc_5:* = 0;
            if (workerClass)
            {
                _loc_5 = workerClass.current.getSharedProperty("flascc.sect." + param1 + "." + param2);
            }
            if (!_loc_5)
            {
                if (param4 < 1)
                {
                    param4 = 1;
                }
                _loc_5 = CModule.sbrk(param3, param4);
            }
            return _loc_5;
        }// end function

        public static function describeType(param1) : XML
        {
            var _loc_3:* = null;
            _loc_3 = new Namespace("flash.utils");
            var _loc_5:* = "describeType";
            var _loc_6:* = _loc_3;
            _loc_5 = CModule.[_loc_5](param1);
            return _loc_5;
            _loc_6 = new catch0;
            e;
            var _loc_2:* = new Namespace("avmplus");
            var _loc_7:* = "describeType";
            var _loc_8:* = _loc_2;
            _loc_7 = "FLASH10_FLAGS";
            _loc_8 = _loc_2;
            return CModule.[_loc_7](param1, [_loc_7]);
        }// end function

        public static function write8(param1:int, param2:int) : void
        {
            ram_init.position = param1;
            ram_init.writeByte(param2);
            return;
        }// end function

        public static function write16(param1:int, param2:int) : void
        {
            ram_init.position = param1;
            ram_init.writeShort(param2);
            return;
        }// end function

        public static function write32(param1:int, param2:int) : void
        {
            ram_init.position = param1;
            ram_init.writeInt(param2);
            return;
        }// end function

        public static function writeFloat(param1:int, param2:Number) : void
        {
            ram_init.position = param1;
            ram_init.writeFloat(param2);
            return;
        }// end function

        public static function writeDouble(param1:int, param2:Number) : void
        {
            ram_init.position = param1;
            ram_init.writeDouble(param2);
            return;
        }// end function

        public static function writeBytes(param1:int, param2:uint, param3:IDataInput) : void
        {
            param3.readBytes(ram_init, param1, param2);
            return;
        }// end function

        public static function read8(param1:int) : int
        {
            ram_init.position = param1;
            return ram_init.readUnsignedByte();
        }// end function

        public static function read16(param1:int) : int
        {
            ram_init.position = param1;
            return ram_init.readUnsignedShort();
        }// end function

        public static function read32(param1:int) : int
        {
            ram_init.position = param1;
            return ram_init.readInt();
        }// end function

        public static function readFloat(param1:int) : Number
        {
            ram_init.position = param1;
            return ram_init.readFloat();
        }// end function

        public static function readDouble(param1:int) : Number
        {
            ram_init.position = param1;
            return ram_init.readDouble();
        }// end function

        public static function readBytes(param1:int, param2:uint, param3:IDataOutput) : void
        {
            param3.writeBytes(ram_init, param1, param2);
            return;
        }// end function

        public static function push32(param1:int) : void
        {
            ESP = ESP - 4;
            write32(ESP, param1);
            return;
        }// end function

        public static function pop32() : int
        {
            var _loc_1:* = read32(ESP);
            ESP = ESP + 4;
            return _loc_1;
        }// end function

        public static function malloc(param1:int) : int
        {
            var _loc_2:* = new Vector.<int>;
            _loc_2.push(param1);
            return callI(_malloc, _loc_2);
        }// end function

        public static function free(param1:int) : void
        {
            var _loc_2:* = new Vector.<int>;
            _loc_2.push(param1);
            callI(_free, _loc_2);
            return;
        }// end function

        public static function alloca(param1:int) : int
        {
            ESP = (ESP - param1) / 16 * 16;
            return ESP;
        }// end function

        public static function writeString(param1:int, param2:String) : int
        {
            ram_init.position = param1;
            ram_init.writeUTFBytes(param2);
            return ram_init.position - param1;
        }// end function

        public static function readString(param1:int, param2:int) : String
        {
            ram_init.position = param1;
            var _loc_3:* = ram_init.readUTFBytes(param2);
            return _loc_3;
        }// end function

        public static function writeLatin1String(param1:int, param2:String) : int
        {
            ram_init.position = param1;
            ram_init.writeUTFBytes(param2);
            return ram_init.position - param1;
        }// end function

        public static function readLatin1String(param1:int, param2:int) : String
        {
            ram_init.position = param1;
            var _loc_3:* = ram_init.readUTFBytes(param2);
            return _loc_3;
        }// end function

        public static function readIntVector(param1:int, param2:int) : Vector.<int>
        {
            var _loc_3:* = new Vector.<int>;
            ram_init.position = param1;
            do
            {
                
                _loc_3.push(ram_init.readInt());
                param2--;
            }while (param2)
            return _loc_3;
        }// end function

        public static function writeIntVector(param1:int, param2:Vector.<int>) : void
        {
            var _loc_3:* = 0;
            ram_init.position = param1;
            _loc_3 = 0;
            while (_loc_3 < param2.length)
            {
                
                ram_init.writeInt(param2[_loc_3]);
                _loc_3++;
            }
            return;
        }// end function

        public static function mallocString(param1:String) : int
        {
            scratchBA.position = 0;
            scratchBA.writeUTFBytes(param1);
            scratchBA.writeByte(0);
            var _loc_2:* = scratchBA.position;
            var _loc_3:* = malloc(_loc_2);
            ram_init.position = _loc_3;
            ram_init.writeBytes(scratchBA, 0, _loc_2);
            if (_loc_2 > 4096)
            {
                scratchBA.length = 4096;
            }
            return _loc_3;
        }// end function

        public static function allocaString(param1:String) : int
        {
            scratchBA.position = 0;
            scratchBA.writeUTFBytes(param1);
            scratchBA.writeByte(0);
            var _loc_2:* = scratchBA.position;
            var _loc_3:* = alloca(_loc_2);
            ram_init.position = _loc_3;
            ram_init.writeBytes(scratchBA, 0, _loc_2);
            if (_loc_2 > 4096)
            {
                scratchBA.length = 4096;
            }
            return _loc_3;
        }// end function

        public static function mallocLatin1String(param1:String) : int
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = malloc((_loc_2 + 1));
            ram_init.position = _loc_3;
            ram_init.writeUTFBytes(param1);
            ram_init[_loc_3 + _loc_2] = 0;
            return _loc_3;
        }// end function

        public static function allocaLatin1String(param1:String) : int
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = alloca((_loc_2 + 1));
            ram_init.position = _loc_3;
            ram_init.writeUTFBytes(param1);
            ram_init[_loc_3 + _loc_2] = 0;
            return _loc_3;
        }// end function

        public static function regFun(param1:int, param2:Function) : void
        {
            if (param1 == 0)
            {
                throw new Error("Error: Attempting to register the null function pointer");
            }
            ptr2fun_init[param1] = param2;
            return;
        }// end function

        public static function callI(param1:int, param2:Vector.<int>, param3:int = 0, param4:Boolean = false) : int
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_5:* = ESP;
            var _loc_8:* = 0;
            if (param3)
            {
                ESP = param3;
            }
            ESP = ESP / 16 * 16;
            _loc_6 = (16 - param2.length * 4 % 16) % 16;
            ESP = ESP - _loc_6;
            _loc_7 = param2.length - 1;
            while (_loc_7 >= 0)
            {
                
                push32(param2[_loc_7]);
                _loc_7--;
            }
            ptr2fun_init.ptr2fun_init[param1]();
            ;
            var _loc_9:* = null;
            _loc_8 = 1;
            if (!param4)
            {
                ESP = _loc_5;
            }
            switch(_loc_8) branch count is:<0>[11] default offset is:<8>;
            throw _loc_9;
            return eax;
        }// end function

        public static function callN(param1:int, param2:Vector.<int>, param3:int = 0, param4:Boolean = false) : Number
        {
            callI(param1, param2, param3);
            return st0;
        }// end function

        public static function regModule(param1:Object, param2:Function, param3:Array, param4:String) : CModule
        {
            if (seenModuleInit)
            {
                CModule.trace("WARNING: module registration after module initialization has begun");
            }
            var _loc_5:* = new CModule(param1, param2, param3, param4);
            modules.push(_loc_5);
            return _loc_5;
        }// end function

        public static function getModuleByPackage(param1:String) : CModule
        {
            for each (_loc_2 in modules)
            {
                
                if (_loc_2.modPackage == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public static function getModuleVector() : Vector.<CModule>
        {
            return modules.concat();
        }// end function

        public static function sendMetric(param1:String, param2) : void
        {
            try
            {
                if (telemetrySupported)
                {
                    Telemetry.sendMetric(param1, param2);
                }
            }
            catch (e)
            {
                CModule.trace("failed to send metric \'" + param1 + "\' value \'" + param2 + "\'");
            }
            return;
        }// end function

        public static function sendSpanMetric(param1:String, param2:Number, param3 = null) : void
        {
            if (telemetrySupported)
            {
                Telemetry.sendMetric(param1, param2, param3);
            }
            return;
        }// end function

        private static function mapCsymsWithExplicitValues() : Dictionary
        {
            var _loc_1:* = null;
            var _loc_2:* = new Vector.<CModule>;
            for each (_loc_1 in toBeMapped)
            {
                
                if (_loc_1.script)
                {
                    _loc_1.mapCsymsWithExplicitValues(cachedCSyms);
                    continue;
                }
                _loc_2.push(_loc_1);
            }
            toBeMapped = _loc_2;
            return cachedCSyms;
        }// end function

        public static function get kernel() : Object
        {
            if (!_kernel)
            {
                try
                {
                    _kernel = new ShellPosix();
                }
                catch (e:ReferenceError)
                {
                    _kernel = new PlayerKernel();
                }
            }
            return _kernel;
        }// end function

        public static function set kernel(param1:Object) : void
        {
            _kernel = param1;
            return;
        }// end function

        public static function get vfs() : IVFS
        {
            if (!_vfs)
            {
                _vfs = new DefaultVFS();
            }
            return _vfs;
        }// end function

        public static function set vfs(param1:IVFS) : void
        {
            _vfs = param1;
            return;
        }// end function

        private static function mallocStrings(param1:Vector.<String>) : Vector.<int>
        {
            var _loc_3:* = 0;
            var _loc_2:* = new Vector.<int>;
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2.push(mallocString(param1[_loc_3]));
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private static function mallocPtrArray(param1:Vector.<int>) : int
        {
            var _loc_3:* = 0;
            if (param1.length == 0)
            {
                return 0;
            }
            var _loc_2:* = malloc(param1.length * 4);
            ram_init.position = _loc_2;
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                ram_init.writeInt(param1[_loc_3]);
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private static function allocaStrings(param1:Vector.<String>) : Vector.<int>
        {
            var _loc_3:* = 0;
            var _loc_2:* = new Vector.<int>;
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2.push(allocaString(param1[_loc_3]));
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private static function allocaPtrArray(param1:Vector.<int>) : int
        {
            var _loc_3:* = 0;
            if (param1.length == 0)
            {
                return 0;
            }
            var _loc_2:* = alloca(param1.length * 4);
            ram_init.position = _loc_2;
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                ram_init.writeInt(param1[_loc_3]);
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public static function runCtors() : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = getModuleVector().reverse();
            while (_loc_2 in _loc_3)
            {
                
                (_loc_2[_loc_3]).runCtors();
            }
            return;
        }// end function

        public static function runDtors() : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = getModuleVector();
            while (_loc_2 in _loc_3)
            {
                
                (_loc_2[_loc_3]).runDtors();
            }
            return;
        }// end function

        public static function serviceUIRequests() : void
        {
            var _loc_1:* = read32(_flascc_uiTickProc);
            if (_loc_1)
            {
                callI(_loc_1, new Vector.<int>(0));
            }
            return;
        }// end function

        public static function start(param1:Object, param2:Vector.<String>, param3:Vector.<String>, param4:Boolean = true) : int
        {
            var _loc_6:* = 0;
            var _loc_8:* = undefined;
            var _loc_9:* = 0;
            var _loc_7:* = undefined;
            if (param1)
            {
                if (activeConsole)
                {
                    throw new Error("calling start with a console with an already active console");
                }
                activeConsole = param1;
            }
            var _loc_5:* = ESP;
            var _loc_10:* = 0;
            try
            {
                _loc_8 = allocaStrings(param2);
                _loc_8.push(0);
                _loc_8 = _loc_8.concat(allocaStrings(param3));
                _loc_8.push(0);
                _loc_9 = allocaPtrArray(_loc_8);
                _loc_5 = ESP;
                _loc_7 = new Vector.<int>;
                _loc_7.push(0, param2.length, _loc_9);
                _loc_6 = callI(__start1, _loc_7);
            }
            catch (exitCode:Exit)
            {
                _loc_6 = exitCode.code;
                _loc_10 = 0;
                ;
                _loc_11 = null;
                _loc_10 = 1;
            }
            if (!param4)
            {
                ESP = _loc_5;
            }
            switch(_loc_10) branch count is:<0>[11] default offset is:<8>;
            throw _loc_11;
            return _loc_6;
        }// end function

        public static function startAsync(param1:Object = null, param2:Vector.<String> = null, param3:Vector.<String> = null, param4:Boolean = true) : void
        {
            if (activeConsole)
            {
                throw new Error("calling startAsync with an active console");
            }
            if (!param2)
            {
                param2 = new Vector.<String>;
            }
            if (!param3)
            {
                param3 = new Vector.<String>;
            }
            try
            {
                workerClass["current"].setSharedProperty("flascc.uiThread.threadId", realThreadId);
            }
            catch (e)
            {
                try
                {
                }
                CModule.start(param1, param2, param3, param4);
            }
            catch (e:GoingAsync)
            {
                ;
            }
            catch (e)
            {
                activeConsole = undefined;
                throw e;
            }
            return;
        }// end function

        public static function startBackground(param1:Object = null, param2:Vector.<String> = null, param3:Vector.<String> = null, param4:int = 65536) : void
        {
            var _loc_8:* = undefined;
            var _loc_10:* = 0;
            var _loc_7:* = undefined;
            var _loc_9:* = 0;
            var _loc_5:* = undefined;
            var _loc_11:* = 0;
            if (param1)
            {
                if (activeConsole)
                {
                    throw new Error("calling startBackground with a console with an already active console");
                }
                activeConsole = param1;
            }
            if (param4 < 8192 || param4 % 4096)
            {
                throw new Error("invalid stack size");
            }
            if (!param2)
            {
                param2 = new Vector.<String>;
            }
            if (!param3)
            {
                param3 = new Vector.<String>;
            }
            var _loc_6:* = ESP;
            var _loc_12:* = 0;
            _loc_8 = allocaStrings(param2);
            _loc_8.push(0);
            _loc_8 = _loc_8.concat(allocaStrings(param3));
            _loc_8.push(0);
            _loc_10 = allocaPtrArray(_loc_8);
            _loc_6 = ESP;
            _loc_7 = new Vector.<int>;
            _loc_7.push(0, param2.length, _loc_10);
            _loc_9 = _loc_6;
            _loc_5 = CModule.newThread(0, _loc_9, __start1, _loc_7);
            realThreadId = 1;
            threadId = 1;
            _loc_5.setSharedProperty("flascc.uiThread.threadId", threadId);
            _loc_11 = CModule.sbrk(param4, 4096);
            ESP_init = _loc_11 + param4;
            _loc_6 = _loc_11 + param4;
            _loc_5.setSharedProperty("flascc.uiThread.esp_init", _loc_6);
            _loc_5.setSharedProperty("flascc.uiThread.stackSize", param4);
            _loc_5.setSharedProperty("flascc.uiThread.tcbpp", _loc_11);
            CModule.threadArbMutexLock();
            _loc_5.start();
            ESP = _loc_11 + 4096;
            
            CModule.threadArbCondWait(1);
            serviceUIRequests();
            tcbp = read32(_loc_11);
            if (!read32(_loc_11)) goto 354;
            write32(_loc_11, 0);
            CModule.threadArbCondsNotify(-1);
            CModule.threadArbMutexUnlock();
            ;
            var _loc_13:* = null;
            _loc_12 = 1;
            ESP = _loc_6;
            switch(_loc_12) branch count is:<0>[11] default offset is:<8>;
            throw _loc_13;
            return;
        }// end function

        try
        {
            if (Telemetry != null)
            {
            }
        }
        catch (e)
        {
            telemetrySupported = false;
        }
        workerInits.push(function (param1) : void
        {
            var _loc_3:* = null;
            var _loc_6:* = null;
            prepForThreadedExec();
            var _loc_2:* = getModuleVector();
            for each (_loc_4 in _loc_2)
            {
                
                _loc_3 = (_loc_4).modPackage;
                _loc_6 = _loc_4.getSections();
                for (_loc_5 in _loc_6)
                {
                    
                    param1.setSharedProperty("flascc.sect." + _loc_3 + "." + _loc_5, _loc_6[_loc_5][0]);
                }
                param1.setSharedProperty("flascc." + _loc_3 + ".oncep", _loc_4.oncep);
            }
            return;
        }// end function
        );
    }
}
