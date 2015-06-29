package com.raidcall.rclive
{
    import com.raidcall.rclive.__internal__.*;
    import flash.net.*;
    import flash.utils.*;

    public class Player extends Object
    {
        var protocol_:String;
        var player_:int;
        var streamCreateListener_:Function;
        var streamCloseListener_:Function;
        var streamDataListener_:Function;

        public function Player(param1:String)
        {
            this.protocol_ = param1;
            this.player_ = _create_player_(this.protocol_);
            this.streamCreateListener_ = null;
            this.streamCloseListener_ = null;
            this.streamDataListener_ = null;
            if (this.player_ != 0)
            {
                _listen_(this.player_, STREAM_CREATE(), this.onStreamCreate);
                _listen_(this.player_, STREAM_CLOSE(), this.onStreamClose);
                _listen_(this.player_, STREAM_DATA(), this.onStreamData);
            }
            return;
        }// end function

        public function play(param1:String, param2:String, param3:String) : Boolean
        {
            if (this.player_ == 0)
            {
                return false;
            }
            return _play_(this.player_, param1, param2, param3);
        }// end function

        public function close() : void
        {
            if (this.player_ != 0)
            {
                return _dispose_player_(this.player_);
            }
            return;
        }// end function

        public function set streamCreateListener(param1:Function) : void
        {
            this.streamCreateListener_ = param1;
            return;
        }// end function

        public function set streamCloseListener(param1:Function) : void
        {
            this.streamCloseListener_ = param1;
            return;
        }// end function

        public function set streamDataListener(param1:Function) : void
        {
            this.streamDataListener_ = param1;
            return;
        }// end function

        function onStreamCreate(param1:NetStream) : void
        {
            if (this.streamCreateListener_ != null)
            {
                this.streamCreateListener_.call(null, param1);
            }
            return;
        }// end function

        function onStreamData(param1:Number, param2:Number, param3:ByteArray) : void
        {
            if (this.streamDataListener_ != null)
            {
                this.streamDataListener_.call(null, param1, param2, param3);
            }
            return;
        }// end function

        function onStreamClose() : void
        {
            this.player_ = 0;
            if (this.streamCloseListener_ != null)
            {
                this.streamCloseListener_.call(null);
            }
            return;
        }// end function

        public static function set logger(param1:Function) : void
        {
            _set_logger_(param1);
            return;
        }// end function

    }
}
