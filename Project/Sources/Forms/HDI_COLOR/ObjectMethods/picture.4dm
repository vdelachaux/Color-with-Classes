var $picture : Picture
var $o; $offset; $rgb; $size; $skip : Integer
var $bmp; $data; $x : Blob
var $e : Object

$e:=FORM Event:C1606

Case of 
		
		//______________________________________________________
	: ($e.code=On Data Change:K2:15)
		
		If (Bool:C1537(OBJECT Get value:C1743("medium")))
			
			Form:C1466.main:=cs:C1710.bmp.new(Self:C308->).getMediumColor()
			
		Else 
			
			Form:C1466.main:=cs:C1710.bmp.new(Self:C308->).getDominantColor()
			
		End if 
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($e.code=On Mouse Enter:K2:33)\
		 | ($e.code=On Mouse Move:K2:35)
		
		If (Picture size:C356(OBJECT Get value:C1743("picture"))=0)
			
			OBJECT SET HELP TIP:C1181(*; OBJECT Get name:C1087(Object current:K67:2); "Drop an image to get its color")
			
		Else 
			
			Form:C1466.picker:=Form:C1466.picker | Macintosh option down:C545
			
			If (Form:C1466.picker)
				
				SET CURSOR:C469(2)
				OBJECT SET HELP TIP:C1181(*; OBJECT Get name:C1087(Object current:K67:2); "Select a pixel to get its color")
				
			Else 
				
				OBJECT SET HELP TIP:C1181(*; OBJECT Get name:C1087(Object current:K67:2); "Press "+(Is Windows:C1573 ? "Alt" : "Option")+" to select the pixel color")
				
			End if 
		End if 
		
		//______________________________________________________
	: ($e.code=On Mouse Leave:K2:34)
		
		SET CURSOR:C469
		
		//______________________________________________________
	: ($e.code=On Mouse Up:K2:58)
		
		Form:C1466.picker:=False:C215
		SET CURSOR:C469
		
		$picture:=OBJECT Get value:C1743("picture")
		TRANSFORM PICTURE:C988($picture; Crop:K61:7; MouseX; MouseY; 1; 1)
		CONVERT PICTURE:C1002($picture; ".bmp")
		PICTURE TO BLOB:C692($picture; $bmp; ".bmp")
		
		If (BLOB size:C605($bmp)>=18)
			
			COPY BLOB:C558($bmp; $x; 0; 0; 14)
			
			$o:=0x0000
			
			If (BLOB to integer:C549($x; PC byte ordering:K22:3; $o)=0x4D42)
				
				$size:=BLOB to longint:C551($x; PC byte ordering:K22:3; $o)
				$skip:=BLOB to integer:C549($x; PC byte ordering:K22:3; $o)
				$skip:=BLOB to integer:C549($x; PC byte ordering:K22:3; $o)
				$offset:=BLOB to longint:C551($x; PC byte ordering:K22:3; $o)
				
				COPY BLOB:C558($bmp; $data; $offset; 0; $size-$offset)
				$rgb:=BLOB to longint:C551($data; PC byte ordering:K22:3) & 0x00FFFFFF
				
			End if 
		End if 
		
		Form:C1466.main:=Form:C1466.color.setColor($rgb).main
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
End case 