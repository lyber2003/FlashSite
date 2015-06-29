package com.raidcall.rclive.__internal__.kernel
{
    import __AS3__.vec.*;
    import com.raidcall.rclive.__internal__.*;
    import com.raidcall.rclive.__internal__.kernel.*;
    import com.raidcall.rclive.__internal__.vfs.*;
    import flash.utils.*;

    public class PlayerKernel extends Object implements IKernel
    {
        private var _ruid:int = 0;
        private var _euid:int = 0;
        private var _egid:int = 0;

        public function PlayerKernel()
        {
            return;
        }// end function

        private function getFileHandleFromFileDescriptor(param1:int, param2:int) : FileHandle
        {
            var _loc_3:* = CModule.vfs.getFileHandleFromFileDescriptor(param1);
            if (!_loc_3)
            {
                CModule.write32(param2, 9);
            }
            return _loc_3;
        }// end function

        private function create(param1:String) : FileHandle
        {
            CModule.vfs.addFile(param1, new ByteArray());
            return CModule.vfs.getFileHandleFromPath(param1);
        }// end function

        private function readNullTerminatedStr(param1:int) : String
        {
            var _loc_2:* = 0;
            _loc_2 = 0;
            while (CModule.read8(param1 + _loc_2) != 0)
            {
                
                _loc_2 = _loc_2 + 1;
            }
            return CModule.readString(param1, _loc_2);
        }// end function

        public function read(param1:int, param2:int, param3:int, param4:int) : int
        {
            var _loc_6:* = getFileHandleFromFileDescriptor(param1, param4);
            if (!getFileHandleFromFileDescriptor(param1, param4))
            {
                return -1;
            }
            if (!_loc_6.readable)
            {
                CModule.write32(param4, 9);
                return -1;
            }
            if (_loc_6.isDirectory)
            {
                CModule.write32(param4, 21);
                return -1;
            }
            if (_loc_6.callback)
            {
                return _loc_6.callback.read(param1, param2, param3, param4);
            }
            _loc_6.bytes.position = _loc_6.position;
            var _loc_5:* = Math.min(param3, _loc_6.bytes.bytesAvailable);
            if (Math.min(param3, _loc_6.bytes.bytesAvailable) > 0)
            {
                CModule.writeBytes(param2, _loc_5, _loc_6.bytes);
            }
            _loc_6.position = _loc_6.bytes.position;
            return _loc_5;
        }// end function

        public function write(param1:int, param2:int, param3:int, param4:int) : int
        {
            var _loc_6:* = 0;
            var _loc_5:* = getFileHandleFromFileDescriptor(param1, param4);
            if (!getFileHandleFromFileDescriptor(param1, param4))
            {
                return -1;
            }
            if (_loc_5.callback)
            {
                return _loc_5.callback.write(param1, param2, param3, param4);
            }
            if (_loc_5.writeable)
            {
                _loc_5.bytes.position = _loc_5.appending ? (_loc_5.bytes.length) : (_loc_5.position);
                _loc_6 = 0;
                while (_loc_6 < param3)
                {
                    
                    _loc_5.bytes.writeByte(CModule.read8(param2 + _loc_6));
                    _loc_6 = _loc_6 + 1;
                }
                _loc_5.position = _loc_5.bytes.position;
            }
            else
            {
                CModule.write32(param4, 9);
                param3 = -1;
            }
            return param3;
        }// end function

        private function iov(param1:int, param2:int, param3:int, param4:int, param5:Function) : int
        {
            var _loc_8:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_8 = 0;
            while (_loc_8 < param3)
            {
                
                _loc_6 = this.param5(param1, CModule.read32(param2), CModule.read32(param2 + 4), param4);
                if (_loc_6 < 0)
                {
                    return -1;
                }
                _loc_7 = _loc_7 + _loc_6;
                param2 = param2 + 8;
                _loc_8 = _loc_8 + 1;
            }
            return _loc_7;
        }// end function

        public function writev(param1:int, param2:int, param3:int, param4:int) : int
        {
            return iov(param1, param2, param3, param4, write);
        }// end function

        public function readv(param1:int, param2:int, param3:int, param4:int) : int
        {
            return iov(param1, param2, param3, param4, read);
        }// end function

        public function open(param1:int, param2:int, param3:int, param4:int) : int
        {
            var _loc_6:* = null;
            var _loc_7:* = readNullTerminatedStr(param1);
            var _loc_12:* = CModule.vfs.getFileHandleFromPath(_loc_7);
            var _loc_9:* = param2 & 512;
            var _loc_8:* = param2 & 512 && param2 & 2048;
            var _loc_5:* = -1;
            if (!_loc_7.length)
            {
                CModule.write32(param4, 2);
                return -1;
            }
            if (!_loc_12 && _loc_9)
            {
                _loc_6 = CModule.vfs.checkPath(_loc_7);
                if (_loc_6 == "pathComponentDoesNotExist")
                {
                    CModule.write32(param4, 2);
                    return -1;
                }
                if (_loc_6 == "pathComponentIsNotDirectory")
                {
                    CModule.write32(param4, 20);
                    return -1;
                }
                var _loc_10:* = CModule.vfs.getFileHandleFromPath(PathUtils.getDirectory(_loc_7));
                if (!_loc_10.writeable)
                {
                    CModule.write32(param4, 30);
                    return -1;
                }
                _loc_12 = create(_loc_7);
            }
            else if (_loc_12 && _loc_8)
            {
                CModule.write32(param4, 17);
                return _loc_5;
            }
            if (_loc_12)
            {
                if (param2 & (1 | 2 | 512 | 1024) && !_loc_12.writeable)
                {
                    CModule.write32(param4, 30);
                    return -1;
                }
                if (param2 & (1 | 2) && _loc_12.isDirectory)
                {
                    CModule.write32(param4, 21);
                    return -1;
                }
                if (param2 & 1024)
                {
                    _loc_12.bytes.length = 0;
                }
                else if (param2 & 8)
                {
                    _loc_12.appending = true;
                }
                _loc_12.writeable = param2 & 1 || param2 & 2;
                _loc_12.readable = !(param2 & 1) || param2 & 2;
                _loc_5 = CModule.vfs.openFile(_loc_12);
            }
            else
            {
                _loc_6 = CModule.vfs.checkPath(_loc_7);
                if (_loc_6 == "pathComponentIsNotDirectory")
                {
                    CModule.write32(param4, 20);
                }
                else
                {
                    CModule.write32(param4, 2);
                }
                _loc_5 = -1;
            }
            return _loc_5;
        }// end function

        public function close(param1:int, param2:int) : int
        {
            if (!CModule.vfs.isValidFileDescriptor(param1))
            {
                CModule.write32(param2, 9);
                return -1;
            }
            CModule.vfs.closeFile(param1);
            return 0;
        }// end function

        public function mkdir(param1:int, param2:int, param3:int) : int
        {
            var _loc_5:* = readNullTerminatedStr(param1);
            if (!_loc_5.length)
            {
                CModule.write32(param3, 2);
                return -1;
            }
            if (CModule.vfs.getFileHandleFromPath(_loc_5))
            {
                CModule.write32(param3, 17);
                return -1;
            }
            var _loc_4:* = CModule.vfs.checkPath(_loc_5);
            if (CModule.vfs.checkPath(_loc_5) == "pathComponentDoesNotExist")
            {
                CModule.write32(param3, 2);
                return -1;
            }
            if (_loc_4 == "pathComponentIsNotDirectory")
            {
                CModule.write32(param3, 20);
                return -1;
            }
            var _loc_6:* = CModule.vfs.getFileHandleFromPath(PathUtils.getDirectory(_loc_5));
            if (!_loc_6.writeable)
            {
                CModule.write32(param3, 30);
                return -1;
            }
            CModule.vfs.addDirectory(_loc_5);
            return 0;
        }// end function

        private function statImpl(param1:FileHandle, param2:int, param3:int) : int
        {
            var _loc_4:* = param1.callback || param1.isDirectory ? (0) : (param1.bytes.length);
            CModule.write16(param2 + 8, param1.isDirectory ? (16384) : (param1.callback ? (8192) : (32768)));
            CModule.write16(param2 + 10, 1);
            CModule.write32(param2 + 48, _loc_4);
            CModule.write32(param2 + 64, 4096);
            CModule.write32(param2 + 56, _loc_4 / 4096 + (_loc_4 % 4096 == 0 ? (0) : (1)));
            return 0;
        }// end function

        public function stat(param1:int, param2:int, param3:int) : int
        {
            var _loc_5:* = readNullTerminatedStr(param1);
            var _loc_4:* = CModule.vfs.checkPath(_loc_5);
            if (CModule.vfs.checkPath(_loc_5) == "pathComponentIsNotDirectory")
            {
                CModule.write32(param3, 20);
                return -1;
            }
            var _loc_6:* = CModule.vfs.getFileHandleFromPath(_loc_5);
            if (!CModule.vfs.getFileHandleFromPath(_loc_5))
            {
                CModule.write32(param3, 2);
                return -1;
            }
            return statImpl(_loc_6, param2, param3);
        }// end function

        public function fstat(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = CModule.vfs.getFileHandleFromFileDescriptor(param1);
            if (!CModule.vfs.getFileHandleFromFileDescriptor(param1))
            {
                CModule.write32(param3, 9);
                return -1;
            }
            return statImpl(_loc_4, param2, param3);
        }// end function

        public function lstat(param1:int, param2:int, param3:int) : int
        {
            return stat(param1, param2, param3);
        }// end function

        private function twoInts(param1:int, param2:int) : Array
        {
            return [param1, param2];
        }// end function

        private function lseekImpl(param1:int, param2:int, param3:int, param4:int)
        {
            var _loc_8:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = CModule.vfs.getFileHandleFromFileDescriptor(param1);
            if (!CModule.vfs.getFileHandleFromFileDescriptor(param1))
            {
                CModule.write32(param4, 9);
                return null;
            }
            if (_loc_6.callback)
            {
                CModule.write32(param4, 29);
                return null;
            }
            _loc_8 = _loc_6.position;
            switch(param3) branch count is:<2>[14, 22, 33] default offset is:<50>;
            _loc_5 = param2;
            ;
            _loc_5 = _loc_8 + param2;
            ;
            _loc_5 = _loc_6.bytes.length + param2;
            ;
            CModule.write32(param4, 22);
            return null;
            if (_loc_5 > 4294967295)
            {
                CModule.write32(param4, 84);
                return null;
            }
            if (_loc_5 < 0)
            {
                CModule.write32(param4, 22);
                return null;
            }
            var _loc_7:* = _loc_5;
            _loc_6.position = _loc_7;
            return _loc_7;
        }// end function

        public function lseek(param1:int, param2:int, param3:int, param4:int, param5:int) : Object
        {
            if (param2 != 0 && param2 != -1)
            {
                CModule.write32(param5, 84);
                return twoInts(-1, -1);
            }
            var _loc_6:* = lseekImpl(param1, param3, param4, param5);
            if (lseekImpl(param1, param3, param4, param5) == null)
            {
                return twoInts(-1, -1);
            }
            return twoInts(0, _loc_6);
        }// end function

        public function rmdir(param1:int, param2:int) : int
        {
            var _loc_3:* = readNullTerminatedStr(param1);
            if (_loc_3 == "." || _loc_3.substring(_loc_3.length - 2) == "/.")
            {
                CModule.write32(param2, 22);
                return -1;
            }
            var _loc_4:* = CModule.vfs.getFileHandleFromPath(_loc_3);
            if (CModule.vfs.getFileHandleFromPath(_loc_3))
            {
                if (_loc_4.isDirectory)
                {
                    if (CModule.vfs.getDirectoryEntries(_loc_3).length > 0)
                    {
                        CModule.write32(param2, 66);
                        return -1;
                    }
                    if (!_loc_4.writeable)
                    {
                        CModule.write32(param2, 30);
                        return -1;
                    }
                    CModule.vfs.deleteFile(_loc_3);
                    return 0;
                }
                CModule.write32(param2, 20);
                return -1;
            }
            CModule.write32(param2, 2);
            return -1;
        }// end function

        public function unlink(param1:int, param2:int) : int
        {
            var _loc_4:* = readNullTerminatedStr(param1);
            var _loc_3:* = CModule.vfs.checkPath(_loc_4);
            if (_loc_3 == "pathComponentIsNotDirectory")
            {
                CModule.write32(param2, 20);
                return -1;
            }
            var _loc_5:* = CModule.vfs.getFileHandleFromPath(_loc_4);
            if (CModule.vfs.getFileHandleFromPath(_loc_4))
            {
                if (_loc_5.isDirectory)
                {
                    CModule.write32(param2, 1);
                    return -1;
                }
                if (!_loc_5.writeable)
                {
                    CModule.write32(param2, 30);
                    return -1;
                }
                CModule.vfs.deleteFile(_loc_4);
                return 0;
            }
            CModule.write32(param2, 2);
            return -1;
        }// end function

        public function fcntl(param1:int, param2:int, param3:int, param4:int) : int
        {
            var _loc_6:* = 0;
            if (param2 == 0)
            {
                _loc_6 = param3;
                while (CModule.vfs.isValidFileDescriptor(_loc_6))
                {
                    
                    _loc_6++;
                }
                return dup2(param1, _loc_6, param4);
            }
            var _loc_5:* = getFileHandleFromFileDescriptor(param1, param4);
            if (!getFileHandleFromFileDescriptor(param1, param4))
            {
                return -1;
            }
            if (_loc_5.callback)
            {
                return _loc_5.callback.fcntl(param1, param2, param3, param4);
            }
            return 0;
        }// end function

        public function ioctl(param1:int, param2:int, param3:int, param4:int) : int
        {
            var _loc_5:* = getFileHandleFromFileDescriptor(param1, param4);
            if (!getFileHandleFromFileDescriptor(param1, param4))
            {
                return -1;
            }
            if (_loc_5.callback)
            {
                return _loc_5.callback.ioctl(param1, param2, param3, param4);
            }
            return 0;
        }// end function

        public function getdirentries(param1:int, param2:int, param3:int, param4:int, param5:int) : int
        {
            var _loc_9:* = 0;
            var _loc_7:* = null;
            var _loc_14:* = 0;
            var _loc_11:* = 0;
            var _loc_8:* = 0;
            var _loc_13:* = CModule.vfs.getFileHandleFromFileDescriptor(param1);
            if (!CModule.vfs.getFileHandleFromFileDescriptor(param1) || !_loc_13.path)
            {
                return 0;
            }
            var _loc_6:* = new ByteArray();
            _loc_6.endian = "littleEndian";
            var _loc_10:* = 10;
            var _loc_12:* = CModule.vfs.getDirectoryEntries(_loc_13.path);
            CModule.write32(param4, _loc_13.position);
            _loc_9 = _loc_13.position;
            while (_loc_9 < _loc_12.length)
            {
                
                _loc_7 = _loc_12[_loc_9].path.substr(_loc_13.path.length);
                _loc_7 = _loc_7.split(/\//)[1];
                _loc_14 = 8 + _loc_7.length + 1;
                _loc_11 = _loc_14 + 3 & -4;
                if (_loc_6.length + _loc_11 <= param3)
                {
                    _loc_6.writeUnsignedInt(_loc_10++);
                    _loc_6.writeShort(_loc_11);
                    _loc_6.writeByte(_loc_12[_loc_9].isDirectory ? (4) : (8));
                    _loc_6.writeByte(_loc_7.length);
                    _loc_6.writeUTFBytes(_loc_7);
                    _loc_6.writeByte(0);
                    _loc_8 = 0;
                    while (_loc_8 < _loc_11 - _loc_14)
                    {
                        
                        _loc_6.writeByte(0);
                        _loc_8 = _loc_8 + 1;
                    }
                    (_loc_13.position + 1);
                    _loc_9 = _loc_9 + 1;
                }
            }
            if (_loc_6.length <= 0)
            {
                return 0;
            }
            ram.position = param2;
            ram.writeBytes(_loc_6, 0, _loc_6.length);
            return _loc_6.length;
        }// end function

        public function dup(param1:int, param2:int) : int
        {
            var _loc_3:* = -1;
            if (CModule.vfs.isValidFileDescriptor(param1))
            {
                _loc_3 = CModule.vfs.openFile(CModule.vfs.getFileHandleFromFileDescriptor(param1));
            }
            else
            {
                CModule.write32(param2, 9);
            }
            return _loc_3;
        }// end function

        public function dup2(param1:int, param2:int, param3:int) : int
        {
            var _loc_5:* = null;
            var _loc_4:* = -1;
            if (param2 < 0)
            {
                CModule.write32(param3, 9);
            }
            else if (CModule.vfs.isValidFileDescriptor(param1))
            {
                _loc_5 = CModule.vfs.getFileHandleFromFileDescriptor(param1);
                if (CModule.vfs.isValidFileDescriptor(param2))
                {
                    CModule.vfs.closeFile(param2);
                }
                _loc_4 = CModule.vfs.openFile(_loc_5, param2);
            }
            else
            {
                CModule.write32(param3, 9);
            }
            return _loc_4;
        }// end function

        public function rename(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = readNullTerminatedStr(param1);
            var _loc_6:* = readNullTerminatedStr(param2);
            if (_loc_4.length == 0 || _loc_6.length == 0)
            {
                CModule.write32(param3, 2);
                return -1;
            }
            if (_loc_4.charAt((_loc_4.length - 1)) == ".")
            {
                CModule.write32(param3, 22);
                return -1;
            }
            _loc_4 = PathUtils.toCanonicalPath(_loc_4);
            _loc_6 = PathUtils.toCanonicalPath(_loc_6);
            if (_loc_6 == _loc_4.substr(0, _loc_6.length))
            {
                CModule.write32(param3, 22);
                return -1;
            }
            var _loc_5:* = CModule.vfs.checkPath(_loc_4);
            var _loc_8:* = CModule.vfs.checkPath(_loc_6);
            var _loc_10:* = CModule.vfs.getFileHandleFromPath(_loc_4);
            var _loc_9:* = CModule.vfs.getFileHandleFromPath(_loc_6);
            if (_loc_5 == "pathComponentIsNotDirectory" || _loc_8 == "pathComponentIsNotDirectory")
            {
                CModule.write32(param3, 20);
                return -1;
            }
            if (_loc_5 == "pathComponentDoesNotExist" || _loc_8 == "pathComponentDoesNotExist" || !_loc_10)
            {
                CModule.write32(param3, 2);
                return -1;
            }
            if (_loc_9 && _loc_9.isDirectory && !_loc_10.isDirectory)
            {
                CModule.write32(param3, 21);
                return -1;
            }
            if (_loc_9 && _loc_9.isDirectory && CModule.vfs.getDirectoryEntries(_loc_6).length)
            {
                CModule.write32(param3, 66);
                return -1;
            }
            if (_loc_10.isDirectory && _loc_9 && !_loc_9.isDirectory)
            {
                CModule.write32(param3, 20);
                return -1;
            }
            var _loc_7:* = CModule.vfs.getFileHandleFromPath(PathUtils.getDirectory(_loc_6));
            if (!_loc_7.writeable)
            {
                CModule.write32(param3, 30);
                return -1;
            }
            if (!_loc_10.writeable)
            {
                CModule.write32(param3, 30);
                return -1;
            }
            if (_loc_9)
            {
                CModule.vfs.deleteFile(_loc_6);
            }
            if (_loc_10.isDirectory)
            {
                CModule.vfs.addDirectory(_loc_6);
                moveFiles(_loc_4, _loc_6);
            }
            else
            {
                CModule.vfs.addFile(_loc_6, _loc_10.bytes);
            }
            CModule.vfs.deleteFile(_loc_4);
            return 0;
        }// end function

        private function moveFiles(param1:String, param2:String) : void
        {
            var _loc_6:* = 0;
            var _loc_4:* = null;
            var _loc_3:* = null;
            var _loc_5:* = CModule.vfs.getDirectoryEntries(param1);
            _loc_6 = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                _loc_4 = _loc_5[_loc_6];
                _loc_3 = PathUtils.toCanonicalPath(param2 + "/" + _loc_4.path.substring(param1.length));
                if (_loc_4.isDirectory)
                {
                    CModule.vfs.addDirectory(_loc_3);
                    moveFiles(_loc_4.path, _loc_3);
                }
                else
                {
                    CModule.vfs.addFile(_loc_3, _loc_4.bytes);
                }
                CModule.vfs.deleteFile(_loc_4.path);
                _loc_6 = _loc_6 + 1;
            }
            return;
        }// end function

        public function access(param1:int, param2:int, param3:int) : int
        {
            return 0;
        }// end function

        public function issetugid(param1:int) : int
        {
            return 0;
        }// end function

        public function seteuid(param1:int, param2:int) : int
        {
            _euid = param1;
            return 0;
        }// end function

        public function geteuid(param1:int) : int
        {
            return _euid;
        }// end function

        public function setreuid(param1:int, param2:int, param3:int) : int
        {
            _ruid = param1;
            _euid = param2;
            return 0;
        }// end function

        public function getuid(param1:int) : int
        {
            return _ruid;
        }// end function

        public function getpid(param1:int) : int
        {
            return 42;
        }// end function

        public function setegid(param1:int, param2:int) : int
        {
            _egid = param1;
            return 0;
        }// end function

        public function getgid(param1:int) : int
        {
            return _egid;
        }// end function

        public function __getcwd(param1:int, param2:int, param3:int) : int
        {
            CModule.write32(param3, 78);
            return -1;
        }// end function

        public function nanosleep(param1:int, param2:int, param3:int) : int
        {
            if (workerClass)
            {
                var _loc_4:* = CModule.read32(param1 + 4);
                var _loc_6:* = CModule.read32(param1) * 1000 + _loc_4 / 1000000;
                this.yield(_loc_6);
                if (param2)
                {
                    CModule.write32(param2, 0);
                    CModule.write32(param2 + 4, 0);
                }
                return 0;
            }
            CModule.write32(param3, 78);
            return -1;
        }// end function

        public function clock_gettime(param1:int, param2:int, param3:int) : int
        {
            if (param1 == 0)
            {
                var _loc_4:* = new Date();
                CModule.write32(param2, _loc_4.time / 1000);
                CModule.write32(param2 + 4, _loc_4.getMilliseconds() * 1000000);
                return 0;
            }
            CModule.write32(param3, 22);
            return -1;
        }// end function

        public function sigprocmask(param1:int, param2:int, param3:int, param4:int) : int
        {
            CModule.write32(param4, 78);
            return -1;
        }// end function

        public function fork(param1:int) : int
        {
            return -1;
        }// end function

        public function wait4(param1:int, param2:int, param3:int, param4:int, param5:int) : int
        {
            return -1;
        }// end function

        public function link(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function chdir(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function fchdir(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function chmod(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function chown(param1:int, param2:int, param3:int, param4:int) : int
        {
            return -1;
        }// end function

        public function setuid(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function sync(param1:int) : void
        {
            return;
        }// end function

        public function kill(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function getppid(param1:int) : int
        {
            return -1;
        }// end function

        public function pipe(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function getegid(param1:int) : int
        {
            return -1;
        }// end function

        public function revoke(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function symlink(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function umask(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function chroot(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function msync(param1:int, param2:int, param3:int, param4:int) : int
        {
            return -1;
        }// end function

        public function vfork(param1:int) : int
        {
            return -1;
        }// end function

        public function getgroups(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function setgroups(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function getpgrp(param1:int) : int
        {
            return -1;
        }// end function

        public function setpgid(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function getdtablesize(param1:int) : int
        {
            return -1;
        }// end function

        public function fsync(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function setpriority(param1:int, param2:int, param3:int, param4:int) : int
        {
            return -1;
        }// end function

        public function socket(param1:int, param2:int, param3:int, param4:int) : int
        {
            return -1;
        }// end function

        public function getpriority(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function setsockopt(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int
        {
            return -1;
        }// end function

        public function listen(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function sigsuspend(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function getrusage(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function getsockopt(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int
        {
            return -1;
        }// end function

        public function fchown(param1:int, param2:int, param3:int, param4:int) : int
        {
            return -1;
        }// end function

        public function fchmod(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function setregid(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function mkfifo(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function shutdown(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function socketpair(param1:int, param2:int, param3:int, param4:int, param5:int) : int
        {
            return -1;
        }// end function

        public function setsid(param1:int) : int
        {
            return -1;
        }// end function

        public function setgid(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function pathconf(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function fpathconf(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function getpgid(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function semget(param1:int, param2:int, param3:int, param4:int) : int
        {
            return -1;
        }// end function

        public function msgget(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function msgsnd(param1:int, param2:int, param3:int, param4:int, param5:int) : int
        {
            return -1;
        }// end function

        public function msgrcv(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int
        {
            return -1;
        }// end function

        public function shmdt(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function shmget(param1:int, param2:int, param3:int, param4:int) : int
        {
            return -1;
        }// end function

        public function lchown(param1:int, param2:int, param3:int, param4:int) : int
        {
            return -1;
        }// end function

        public function getsid(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function sched_yield(param1:int) : int
        {
            return -1;
        }// end function

        public function sched_get_priority_max(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function sched_get_priority_min(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function sigpending(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function sigwait(param1:int, param2:int, param3:int) : int
        {
            return -1;
        }// end function

        public function shm_unlink(param1:int, param2:int) : int
        {
            return -1;
        }// end function

        public function pselect(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
        {
            return -1;
        }// end function

    }
}
