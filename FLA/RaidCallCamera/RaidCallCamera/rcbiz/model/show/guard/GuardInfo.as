package rcbiz.model.show.guard
{

    public class GuardInfo extends Object
    {
        public var myApply:Array;
        public var applyForMe:Array;
        public var myGuard:Array;
        public var guardForMe:Array;

        public function GuardInfo()
        {
            this.myApply = [];
            this.applyForMe = [];
            this.myGuard = [];
            this.guardForMe = [];
            return;
        }// end function

        public function updateData(param1:Object) : void
        {
            if (param1 == null)
            {
                return;
            }
            this.objToApplyItem(param1.myApply, this.myApply, 1);
            this.objToApplyItem(param1.applyForMe, this.applyForMe, 2);
            this.objToGuardItem(param1.myGuard, this.myGuard, 3);
            this.objToGuardItem(param1.guardForMe, this.guardForMe, 4);
            return;
        }// end function

        public function updateGuardState(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this.applyForMe.length)
            {
                
                _loc_2 = this.applyForMe[_loc_3];
                if (_loc_2.id == param1)
                {
                    this.applyForMe.splice(_loc_3, 1);
                    break;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function objToGuardItem(param1:Array, param2:Array, param3:int) : void
        {
            var _loc_5:* = null;
            if (!param1)
            {
                return;
            }
            param2.splice(0, param2.length);
            var _loc_4:* = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_5 = new GuardForItemInfo(param1[_loc_4]);
                _loc_5.type = param3;
                param2.push(_loc_5);
                _loc_4++;
            }
            return;
        }// end function

        private function objToApplyItem(param1:Array, param2:Array, param3:int) : void
        {
            var _loc_5:* = null;
            if (!param1)
            {
                return;
            }
            param2.splice(0, param2.length);
            var _loc_4:* = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_5 = new GuardApplyItemInfo(param1[_loc_4]);
                _loc_5.type = param3;
                param2.push(_loc_5);
                _loc_4++;
            }
            return;
        }// end function

    }
}
