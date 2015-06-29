package rcbiz.core
{
    import com.debug.*;
    import flash.events.*;
    import flash.external.*;
    import flash.utils.*;

    public class RCConnector extends Object
    {
        private var _cmdList:Array;
        private var timer:Timer;
        private var _widgetListener:Array;
        private var _tickCount:int;

        public function RCConnector()
        {
            this._cmdList = [];
            this._widgetListener = [];
            this.init();
            return;
        }// end function

        public function init() : void
        {
            this.timer = new Timer(50, 0);
            this.timer.addEventListener(TimerEvent.TIMER, this.onProcessTimer);
            this.timer.start();
            ExternalInterface.addCallback("RGetUserNick", this.RGetUserNick);
            ExternalInterface.addCallback("BSwitchChannel", this.BSwitchChannel);
            ExternalInterface.addCallback("BMicUserChange", this.BMicUserChange);
            ExternalInterface.addCallback("BChannelModeChange", this.BChannelModeChange);
            ExternalInterface.addCallback("BReconnected", this.BReconnected);
            ExternalInterface.addCallback("BDestroyFlash", this.BDestroyFlash);
            ExternalInterface.addCallback("RInitCompelete", this.RInitCompelete);
            ExternalInterface.addCallback("BWidgetServerCommand", this.BWidgetServerCommand);
            ExternalInterface.addCallback("CGetVideoEnable", this.CGetVideoEnable);
            ExternalInterface.addCallback("CSetVideoEnable", this.CSetVideoEnable);
            ExternalInterface.addCallback("BEnableVideoWidget", this.BEnableVideoWidget);
            ExternalInterface.addCallback("BFBBinding", this.BFBBinding);
            ExternalInterface.addCallback("BIsUserInChannel", this.BIsUserInChannel);
            ExternalInterface.addCallback("BCPUNotify", this.BCPUNotify);
            return;
        }// end function

        private function callClient(... args) : String
        {
            DebugX.l("call client:", args);
            args = ExternalInterface.call.apply(null, args);
            DebugX.trace(" => return:", args);
            return args;
        }// end function

        public function registerWidgetListenter(param1:int, param2:Object) : void
        {
            this._widgetListener[param1] = param2;
            if (param1 != WidgetID.CLIENT)
            {
                this.PRegisterWidget(param1);
            }
            return;
        }// end function

        private function onClientCMD(param1:String, param2:Array) : void
        {
            DebugX.trace("onClientCMD:", param1, param2);
            if (this._widgetListener[WidgetID.CLIENT] != null)
            {
                this._widgetListener[WidgetID.CLIENT][param1].apply(null, param2);
            }
            return;
        }// end function

        private function BWidgetServerCommand(param1:int, param2:String) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            DebugX.trace("BWidgetServerCommand:", param1, param2);
            var _loc_3:* = JSON.parse(param2);
            if (_loc_3.hasOwnProperty("cmds"))
            {
                _loc_4 = _loc_3.cmds;
                _loc_5 = _loc_4.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    this._cmdList.push({id:param1, data:_loc_4[_loc_6]});
                    _loc_6++;
                }
            }
            else
            {
                this._cmdList.push({id:param1, data:_loc_3});
            }
            return;
        }// end function

        private function onProcessTimer(event:TimerEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = (getTimer() - this._tickCount) / 50;
            this._tickCount = getTimer();
            while (this._cmdList.length > 0 && _loc_2 > 0)
            {
                
                _loc_3 = this._cmdList.shift();
                _loc_4 = _loc_3.data.cmd;
                _loc_5 = _loc_3.id;
                if (_loc_4 != null)
                {
                    var _loc_6:* = this._widgetListener[_loc_5];
                    _loc_6[_loc_4](_loc_3.data);
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        private function RGetUserNick(... args) : void
        {
            this.onClientCMD("RGetUserNick", args);
            return;
        }// end function

        private function BSwitchChannel(... args) : void
        {
            this.onClientCMD("BSwitchChannel", args);
            return;
        }// end function

        private function BMicUserChange(... args) : void
        {
            this.onClientCMD("BMicUserChange", args);
            return;
        }// end function

        private function BCPUNotify(... args) : void
        {
            this.onClientCMD("BCPUNotify", args);
            return;
        }// end function

        private function BChannelModeChange(... args) : void
        {
            this.onClientCMD("BChannelModeChange", args);
            return;
        }// end function

        private function BReconnected(... args) : void
        {
            this.onClientCMD("BReconnected", args);
            return;
        }// end function

        private function BDestroyFlash(... args) : void
        {
            this.onClientCMD("BDestroyFlash", args);
            return;
        }// end function

        private function BGetMyRole(... args) : void
        {
            this.onClientCMD("BGetMyRole", args);
            return;
        }// end function

        private function BFBBinding(... args) : void
        {
            this.onClientCMD("BFBBinding", args);
            return;
        }// end function

        private function BIsUserInChannel(... args) : void
        {
            this.onClientCMD("BIsUserInChannel", args);
            return;
        }// end function

        private function BEnableVideoWidget(... args) : void
        {
            this.onClientCMD("BEnableVideoWidget", args);
            return;
        }// end function

        private function CGetVideoEnable(... args) : void
        {
            this.onClientCMD("CGetVideoEnable", args);
            return;
        }// end function

        private function CSetVideoEnable(... args) : void
        {
            this.onClientCMD("CSetVideoEnable", args);
            return;
        }// end function

        private function RInitCompelete(... args) : void
        {
            this.onClientCMD("RInitCompelete", args);
            return;
        }// end function

        public function PRegisterWidget(param1:int) : void
        {
            this.callClient("PRegisterWidget", param1);
            return;
        }// end function

    }
}
