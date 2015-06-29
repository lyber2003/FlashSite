package com.raidcall.rclive.__internal__
{

    public class RCVal extends Object
    {
        public const val:Object;
        public const id:int;
        public var rc:int;

        public function RCVal(param1, param2:int)
        {
            this.val = param1;
            this.id = param2;
            return;
        }// end function

        public function acquire(param1:int = 1)
        {
            rc = rc + param1;
            return;
        }// end function

        public function release(param1:int = 1)
        {
            var _loc_2:* = rc - param1;
            rc = rc - param1;
            if (!_loc_2)
            {
                delete as3_val2id[as3_val2key(val)];
                delete as3_id2rcv[id];
            }
            return;
        }// end function

    }
}
