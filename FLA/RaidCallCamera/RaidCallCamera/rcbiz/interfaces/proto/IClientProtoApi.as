package rcbiz.interfaces.proto
{

    public interface IClientProtoApi
    {

        public function IClientProtoApi();

        function SGetMyUid() : int;

        function SGetMyInfo() : String;

        function SGetCurMicUserInfo() : String;

        function SGetMyRole() : int;

        function SGetUserImageUrl(param1:int, param2:int = 30) : String;

        function SGetSid() : int;

        function SGetCid() : int;

        function SGetChannelMode() : int;

        function SGetDebug() : int;

        function SShowFbBingWindow() : void;

        function PSetFitMetric(param1:int, param2:int, param3:int) : void;

        function SecCallServer(param1:int, param2:String) : void;

        function SGetLang() : String;

        function SGetLangStrByID(param1:int) : String;

        function PDisplayChannelMsg(param1:String, param2:int = 0) : void;

        function PInitWidget() : void;

        function PShowUserInfo(param1:int) : void;

        function PChangeVoiceEffect(param1:int) : void;

        function PShowExternalUrl(param1:String) : void;

        function PStatusReport() : void;

        function PShowMagicFlash(param1:String, param2:String) : void;

        function PVideoEnableChange(param1:int) : void;

        function PPublish(param1:String, param2:String, param3:String) : void;

        function PStopPublish() : void;

        function PFollowSinger(param1:int, param2:int) : void;

        function PSetSpeaker(param1:int) : void;

        function PSetStopSpeaker() : void;

        function POpenCopPlayer(param1:String) : void;

        function PIsUserInChannel(param1:String, param2:String) : void;

        function PStreamData(param1:String, param2:Number, param3:Number) : void;

        function PSetFPS(param1:int) : void;

        function SSetCPUUsageNotify(param1:int) : void;

    }
}
