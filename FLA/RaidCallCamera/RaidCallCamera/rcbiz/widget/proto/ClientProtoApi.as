package rcbiz.widget.proto
{
    import com.debug.*;
    import flash.external.*;
    import rcbiz.core.*;
    import rcbiz.interfaces.proto.*;

    public class ClientProtoApi extends Object implements IClientProtoApi
    {
        private var r:RCConnector;

        public function ClientProtoApi(param1:RCConnector)
        {
            this.r = param1;
            return;
        }// end function

        public function PChangeVoiceEffect(param1:int) : void
        {
            this.callClient("PChangeVoiceEffect", param1);
            return;
        }// end function

        public function PGetUserNick(param1:int) : void
        {
            this.callClient("PGetUserNick", param1);
            return;
        }// end function

        public function PShowMagicFlash(param1:String, param2:String) : void
        {
            this.callClient("PShowMagicFlash", param1, param2);
            return;
        }// end function

        public function SGetDebug() : int
        {
            return int(this.callClient("SGetDebug"));
        }// end function

        public function SGetFBBinding() : int
        {
            return int(this.callClient("SGetFBBinding"));
        }// end function

        public function SGetUserImageUrl(param1:int, param2:int = 30) : String
        {
            return this.callClient("SGetUserImageUrl", param1, param2);
        }// end function

        public function PDisplayChannelMsg(param1:String, param2:int = -1) : void
        {
            this.callClient("PDisplayChannelMsg", param1, param2);
            return;
        }// end function

        public function PSetFitMetric(param1:int, param2:int, param3:int) : void
        {
            this.callClient("PSetFitMetric", param1, param2, param3);
            return;
        }// end function

        public function SGetSid() : int
        {
            return int(this.callClient("SGetSid"));
        }// end function

        public function SGetMyUid() : int
        {
            return int(this.callClient("SGetMyUid"));
        }// end function

        public function SGetCid() : int
        {
            return int(this.callClient("SGetCid"));
        }// end function

        public function SGetChannelMode() : int
        {
            return int(this.callClient("SGetChannelMode"));
        }// end function

        public function SShowFbBingWindow() : void
        {
            this.callClient("SShowFbBingWindow");
            return;
        }// end function

        public function SGetCurMicUserInfo() : String
        {
            return this.callClient("SGetCurMicUserInfo");
        }// end function

        public function PVideoEnableChange(param1:int) : void
        {
            this.callClient("PVideoEnableChange", param1);
            return;
        }// end function

        public function PShowUserInfo(param1:int) : void
        {
            this.callClient("PShowUserInfo", param1);
            return;
        }// end function

        public function PInitWidget() : void
        {
            this.callClient("PInitWidget");
            return;
        }// end function

        public function SGetMyInfo() : String
        {
            return this.callClient("SGetMyInfo");
        }// end function

        public function SGetMyRole() : int
        {
            return int(this.callClient("SGetMyRole"));
        }// end function

        public function SGetLang() : String
        {
            return this.callClient("SGetLang");
        }// end function

        public function SGetLangStrByID(param1:int) : String
        {
            return this.callClient("SGetLangStrByID", param1);
        }// end function

        public function PShowExternalUrl(param1:String) : void
        {
            this.callClient("PShowExternalUrl", param1);
            return;
        }// end function

        public function PStatusReport() : void
        {
            this.callClient("PStatusReport");
            return;
        }// end function

        public function SecCallServer(param1:int, param2:String) : void
        {
            DebugX.trace(" => return:", param1, param2);
            this.callClient("PCallWidgetServer", param1, param2);
            return;
        }// end function

        public function PPublish(param1:String, param2:String, param3:String) : void
        {
            this.callClient("PPublish", param1, param2, param3);
            return;
        }// end function

        public function PStopPublish() : void
        {
            this.callClient("PStopPublish");
            return;
        }// end function

        public function PFollowSinger(param1:int, param2:int) : void
        {
            this.callClient("PFollowSinger", param1, param2);
            return;
        }// end function

        public function PIsUserInChannel(param1:String, param2:String) : void
        {
            this.callClient("PIsUserInChannel", param1, param2);
            return;
        }// end function

        public function PStreamData(param1:String, param2:Number, param3:Number) : void
        {
            this.callClient("PStreamData", param1, param2, param3);
            return;
        }// end function

        public function PSetSpeaker(param1:int) : void
        {
            this.callClient("PSetSpeaker", param1);
            return;
        }// end function

        public function PSetStopSpeaker() : void
        {
            this.callClient("PSetStopSpeaker");
            return;
        }// end function

        public function SSetCPUUsageNotify(param1:int) : void
        {
            this.callClient("SSetCPUUsageNotify", param1);
            return;
        }// end function

        public function PSetFPS(param1:int) : void
        {
            this.callClient("PSetFPS", param1);
            return;
        }// end function

        public function POpenCopPlayer(param1:String) : void
        {
            this.callClient("POpenCopPlayer", param1);
            return;
        }// end function

        private function callClient(... args) : String
        {
            DebugX.l("call client:", args);
            args = ExternalInterface.call.apply(null, args);
            DebugX.trace(" => return:", args);
            return args;
        }// end function

    }
}
