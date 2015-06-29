
/*
ActionScript 3 Tutorials by Barbara Kaskosz.

www.flashandmath.com

Last modified: March 22, 2008. 

*/

/*
We are creating a Document Class for our cube. We have entered the name of the class
'FlowerMenu', into the Document Class field of menu3d.fla. You could put the corresponding code
on the MainTimeline, skipping the class wrapper and the 'private' and 'public'
attributes. In that case, the only class that you would have to import would be
the CubeMenu class; others would be automatically imported.
The nested folders com, flashandmath, bitmaps have to be in the same directory
as this class and menu3d.fla for the fla file to compile.
*/

package {
	
	 import flash.display.*;
  
     import flash.events.*;
   
     import flash.text.*;
	
	 import com.flashandmath.bitmaps.CubeMenu;
	 
	
   public class FlowerMenu extends MovieClip {
		  
	  private var cube:CubeMenu;
	  
	  private var infoBox:TextField;
		
		//The class constructor. The constructor will be evoked automatically when the movie opens.
	
	  public function FlowerMenu(){
		  
		   /*
		   We are creating an instance of our custom class, CubeMenu, and storing it in the variable
		   'cube' with datatype 'CubeMenu'. The constructor of the CubeMenu class takes two parameters:
		   an array of strings that represent local addresses of the image files to be loaded (in our case,
		   the swf, the html, and the image files are all in the same directory on the server), and the size
		   of the cube. The most natural choice is for the size of the cube to be equal to the size of
		   your squre images but it is not a requirement. The BitmapTranformer class is flexible enough
		   to handle any case. Try changing 160 to 180 or 80, for example.
		   
		   You could create more than one instance of CubeMenu in your movie with a different size
		   and different images on the sides. You just create, say, 'cube2', the same way as 'cube' below.
		   */
			
			cube=new CubeMenu(["anemon.jpg","parodia.jpg","anagallis.jpg","lila.jpg","cosmos.jpg","adonis.jpg"],160);
			
			//The CubeMenu class extends Sprite, so every instance of it is a display object. We are adding
			//our cube to the Display List as a child of the MainTimeline. (The MainTimeline is an instance of this
			//document class.)
			
			this.addChild(cube);
			
			cube.x=20;
			
			cube.y=55;
			
			setUpListeners();
			
			/*
			The commented out lines below illustrate the public methods of the CubeMenu class that allow you
			to customize the appearance of your instance. We commented them out
			as we go with the default values in our movie.
			*/
			
			//cube.fLen=1500;
			
			//cube.setBackLook(0xFFFFFF,0xFF0000,2);
			
			//cube.setErrorBoxFormat(0x0000FF,12);
			
			//cube.setErrorBoxSizeAndPos(300,80,30,30);
			
			setUpInfoBox();
			
		}
		
		/*
		Sides of 'cube' are public properties of the class and they are enabled for double-clicks.
		We add listeners that will display the names of the flowers in the infoBox. infoBox is created below
		and added to our movie. The effect of the side turning toward the user when double-clicked
		is built into the CubeMenu class.
		*/

      private function setUpListeners():void {
		 
		     cube.side0.addEventListener(MouseEvent.DOUBLE_CLICK,side0Clicked);
			 
			 cube.side1.addEventListener(MouseEvent.DOUBLE_CLICK,side1Clicked);
			 
			 cube.side2.addEventListener(MouseEvent.DOUBLE_CLICK,side2Clicked);
			 
			 cube.side3.addEventListener(MouseEvent.DOUBLE_CLICK,side3Clicked);
			 
			 cube.side4.addEventListener(MouseEvent.DOUBLE_CLICK,side4Clicked);
			 
			 cube.side5.addEventListener(MouseEvent.DOUBLE_CLICK,side5Clicked);
			 
	}
	
	  private function side0Clicked(e:MouseEvent):void {
	
	       infoBox.text="ANEMONE HUPEHENSIS";
		
      }
	
      private function side1Clicked(e:MouseEvent):void {
	
	       infoBox.text="PARODIA HERTERI";
	    
      }
	
	  private function side2Clicked(e:MouseEvent):void {
	
	       infoBox.text="ANAGALLIS MONELLI";
		 
      }
	
	
	  private function side3Clicked(e:MouseEvent):void {
	
	       infoBox.text="CALLISTEPHUS CHINENSIS";
		 
      }
	
	  private function side4Clicked(e:MouseEvent):void {
	
	       infoBox.text="COSMOS ATROSANGUINEUS";
	    
     }
	
	  private function side5Clicked(e:MouseEvent):void {
	
	       infoBox.text="ADONIS AESTIVALIS";
		 
     }

	 
	private function setUpInfoBox():void {
		
		var infoFormat:TextFormat=new TextFormat();
		
		infoBox=new TextField();
			
		this.addChild(infoBox);
			
		infoBox.x=382;

        infoBox.y=165;

        infoBox.width=255;

        infoBox.height=100;

        infoBox.wordWrap=true;

        infoBox.mouseEnabled=false;
		
		infoFormat.color=0xFF9900;

        infoFormat.align="center";

        infoFormat.size=14;

        infoFormat.font="Arial";

        infoBox.defaultTextFormat=infoFormat;

	}
		
		
	}
	
	
}