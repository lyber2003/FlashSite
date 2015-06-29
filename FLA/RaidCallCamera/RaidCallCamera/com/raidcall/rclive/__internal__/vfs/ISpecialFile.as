﻿package com.raidcall.rclive.__internal__.vfs
{

    public interface ISpecialFile
    {

        public function ISpecialFile();

        function read(param1:int, param2:int, param3:int, param4:int) : int;

        function write(param1:int, param2:int, param3:int, param4:int) : int;

        function fcntl(param1:int, param2:int, param3:int, param4:int) : int;

        function ioctl(param1:int, param2:int, param3:int, param4:int) : int;

    }
}
