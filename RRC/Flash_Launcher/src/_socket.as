package  
{

import flash.events.*;
import flash.errors.IOError; 
import flash.events.IOErrorEvent; 	
import flash.errors.EOFError;
import flash.net.Socket;
import flash.utils.Timer;
import flash.events.TimerEvent;	
import flash.utils.ByteArray;
	
	
	/**
	 * ...
	 * @author oleg
	 */
	public class _socket 
	{
	private var _sock:Socket = new Socket(); 
	private	var timerConnect:Timer = new Timer(1000,1);


	private	var timer:Timer = new Timer(1000);
		public function _socket()
		{
		trace("function socket")
		connect()
		
		}
			
		private function connectTimer(event:TimerEvent):void {
			connect();
		}
		
		private function connect():void {	
			
		_sock.connect("37.57.234.41", 1000);
			 _sock.addEventListener(IOErrorEvent.IO_ERROR, function():void {
				 trace("нет подключения"); 
				  //options.onError("Connection error occured");
				});
				_sock.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function():void {
					trace("Security ошибка1"); 
					 //_sock.flush();
					timerConnect.addEventListener(TimerEvent.TIMER, connectTimer);
					timerConnect.start();
					//options.onError("Security error occured");
				});
				
				_sock.addEventListener(Event.CONNECT, function(e:Event):void{
				
				trace("connected");
				timerConnect.stop()
				timerConnect.removeEventListener(TimerEvent.TIMER, connectTimer);
				timer.addEventListener(TimerEvent.TIMER, sendEnter);
				timer.start();
			});
		}
		
		private function sendEnter(event:TimerEvent):void {
			
					try 
					{ 
					   _sock.writeUTFBytes("AllMusic");
						_sock.flush();
					} 
					catch (err:Error) 
					{ 
						trace("sendEnter - отправка не удалась"); 
						timer.stop();
						timer.removeEventListener(TimerEvent.TIMER, sendEnter);
						timerConnect.addEventListener(TimerEvent.TIMER, connectTimer);
						timerConnect.start();
					} 
		
			
			if  (_sock.connected == true )  
			{
					readResponse();
			}
			trace("отправка-AllMusic");
		}
		
		public function readResponse():String {
			
					try {
						var str:String = _sock.readUTFBytes(_sock.bytesAvailable);
					} 
					catch(e:EOFError) {
							
						trace("ошибочка");
						
						trace(e);           // EOFError: Error #2030: End of file was encountered.
					}
					//trace("Принято___ " + str);
					//str = decodeStringToUTF(str);
					
						return decodeStringToUTF(str);
					
					

		}
		
		private function decodeStringToUTF(s:String):String {
			var ba:ByteArray = new ByteArray();
			ba.writeMultiByte(s, "windows-1252");
			ba.position = 0;
			return ba.readMultiByte(ba.length, "windows-1251");
		}
		
	}
		
}

