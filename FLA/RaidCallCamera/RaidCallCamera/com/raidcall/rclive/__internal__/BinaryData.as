package com.raidcall.rclive.__internal__
{
    import flash.utils.*;

    public class BinaryData extends ByteArray
    {

        public function BinaryData()
        {
            var _loc_5:* = null;
            var _loc_8:* = 0;
            var _loc_10:* = 0;
            var _loc_4:* = 0;
            var _loc_6:* = 0;
            var _loc_1:* = 0;
            if (length)
            {
                return;
            }
            var _loc_7:* = CModule.describeType(this);
            var _loc_12:* = CModule.describeType(this)..metadata;
            var _loc_13:* = 0;
            var _loc_15:* = new XMLList("");
            for each (_loc_14 in _loc_12)
            {
                
                with (_loc_12[_loc_13])
                {
                    if (@name == "HexData")
                    {
                        _loc_15[_loc_13] = _loc_14;
                    }
                }
            }
            for each (_loc_9 in _loc_15)
            {
                
                var _loc_16:* = _loc_20[_loc_21]..arg;
                var _loc_17:* = 0;
                _loc_12 = new XMLList("");
                for each (_loc_13 in _loc_16)
                {
                    
                    with (_loc_13)
                    {
                        if (@key == "")
                        {
                            _loc_12[_loc_17] = _loc_13;
                        }
                    }
                }
                for (_loc_5 in _loc_12)
                {
                    
                    _loc_8 = _loc_5.length;
                    _loc_10 = 0;
                    while (_loc_10 < _loc_8)
                    {
                        
                        _loc_4 = _loc_5.charCodeAt(_loc_10);
                        _loc_6 = _loc_5.charCodeAt((_loc_10 + 1));
                        _loc_1 = 0;
                        if (_loc_4 < 58)
                        {
                            _loc_1 = _loc_4 - 48;
                        }
                        else if (_loc_4 < 71)
                        {
                            _loc_1 = 10 + (_loc_4 - 65);
                        }
                        else if (_loc_4 < 103)
                        {
                            _loc_1 = 10 + (_loc_4 - 97);
                        }
                        _loc_1 = _loc_1 * 16;
                        if (_loc_6 < 58)
                        {
                            _loc_1 = _loc_1 + (_loc_6 - 48);
                        }
                        else if (_loc_6 < 71)
                        {
                            _loc_1 = _loc_1 + (10 + (_loc_6 - 65));
                        }
                        else if (_loc_6 < 103)
                        {
                            _loc_1 = _loc_1 + (10 + (_loc_6 - 97));
                        }
                        writeByte(_loc_1);
                        _loc_10 = _loc_10 + 2;
                    }
                }
            }
            position = 0;
            return;
        }// end function

    }
}
