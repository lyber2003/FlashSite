
package {
    import flash.display.Sprite;
    import flash.events.*;
    import flash.net.FileReference;
    import flash.net.URLRequest;
    import flash.net.FileFilter;

    public class FileReference_download extends Sprite {
        private var downloadURL:URLRequest;
        private var fileName:String = "RRC_radio.m3u";
        private var file:FileReference;

        public function FileReference_download() {
            downloadURL = new URLRequest();
            downloadURL.url = "https://6756b58dafc018bfb592ed31f2581e919baa7936.googledrive.com/host/0B-lOxB6iLdGlLWtlcFdqeEhiSDg/RRC/Radio_Ravecall.m3u";
            file = new FileReference();
            configureListeners(file);
            file.download(downloadURL, fileName);
        }

        private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.CANCEL, cancelHandler);
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(Event.SELECT, selectHandler);
        }

        private function cancelHandler(event:Event):void {
            trace("cancelHandler: " + event);
        }

        private function completeHandler(event:Event):void {
            trace("completeHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }

        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            var file:FileReference = FileReference(event.target);
            trace("progressHandler name=" + file.name + " bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }

        private function selectHandler(event:Event):void {
            var file:FileReference = FileReference(event.target);
            trace("selectHandler: name=" + file.name + " URL=" + downloadURL.url);
        }
    }
}