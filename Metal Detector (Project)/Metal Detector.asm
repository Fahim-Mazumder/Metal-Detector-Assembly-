.Model Small

.Stack 100h

.Data segment

start db 10,13, "-------------- METAL DETECTOR ------------------- $"    
 
crime db 10,13,"---------------------Criminal Found------------------------------ $"

police db 10,13, "----------------You are arrested.---------------------------- $"  

legally db 10,13, " Legal metal found. Search again.. $"
     
msg db 10,13, "Wrong input. Please input number again  $"

entry db 10,13,"Please, Entry  --> $"

warn1 db 10,13,"Warning ! $"

warn2 db 10,13,"Warning !! $"

warn3 db 10,13,"Warning !!! $"

input db 10,13,"Press any of this serial number : $"  

pros db 10,13, "Reciving signals from machine : $" 

msg1 db 10,13, "There is a metal detected.$"
 
msg2 db 10,13, "Which metal is it?  $"

msg3 db 10,13, "There is no illegal metal detected. Free to go. $"

met1 db 10,13, "1. Is it a Gun? $"

met2 db 10,13, "2. Is it a Grenade? $"

met3 db 10,13, "3. Is it a Knife? $"  

met4 db 10,13, "4. Is it a Blade? $" 

met5 db 10,13, "5. Is it a Brass knuckles? $"
  
met6 db 10,13, "6. Is it a Push Dagger? $"

met7 db 10,13, "7. Is it a Watch? $"

met8 db 10,13, "8. Is it a Key ? $"

met9 db 10,13, "9. Is it a Coin? $" 


msg4 db 10,13, "< Punishment for having illegal items such as Knife,Blade,Brass knuckles,         Push Dagger depending on their explanation   ->                                 1. From 6 months upto 2 years jail.     2. Maximum fine of 10 Thousands taka.   3. Will be allowed to enter without that item. > $"


msg5 db 10,13, "< Punishment for having illegal items such as Gun,Grenade   ->                  1. From 2 years upto 10 years jail.     2. Maximum fine of 50 Thousands taka.   3. Life imprisonment. > $"
 


.Code

main proc 
    
mov ax,@data
mov ds,ax

 
 
 ;-------------------- First searching for metal signals.---------------------------------- 

 
              
              
             lea dx,start
             mov ah,9
             int 21h
             
             mov dx,10
             mov ah,2
             int 21h 
             
             mov bl,0
             
             lea dx,entry
             mov ah,9
             int 21h 
             
             
      search:

             mov dx,10
             mov ah,2
             int 21h
             
             Lea dx,pros  ;reciving signals
             mov ah,9
             int 21h
  
             mov ah,1
             int 21h 
             mov cl,al

             cmp cl,'0'   ;comparing signal
             jne beep     ;if the signal is not zero there is no metal exist, else goto beep function.

             cmp bl,9
             jge output2  ;if there is no metalic signal goto output

             inc bl

             jmp search
      
            
             
  ;--------------------If metalic signal found (beep function) --------------------------------          
  
        beep:
        
             mov dx,10
             mov ah,2
             int 21h
             
             lea dx,warn1
             mov ah,9
             int 21h
             
             lea dx,warn2
             mov ah,9
             int 21h
             
             lea dx,warn3
             mov ah,9
             int 21h
             
              
     beeping:
        
             mov ah, 02
             mov dl, 07h ;value to produce the beep tone
             int 21h     ;producing beep sound  
             
             
             mov ah, 02
             mov dl, 07h ;value to produce the beep tone
             int 21h     ;producing beep sound
             
             mov ah, 02
             mov dl, 07h ;value to produce the beep tone
             int 21h     ;producing beep sound

          
           
   ;----------------- output for metalic signal found--------------------------         
           
           
      output:
              
             mov dx,10
             mov ah,2
             int 21h
             
             lea dx,msg1
             mov ah,9
             int 21h
      
             lea dx,msg2
             mov ah,9
             int 21h
             
             jmp metals 
             
             
   ;---------------------output for no metalic signals found---------------------          
             
             
      output2: 
             
              mov dx,10
              mov ah,2
              int 21h
      
              lea dx,msg3
              mov ah,9
              int 21h
             
              jmp exit_it
             
             
   ;----------------options for legal & illegal metals-----------------------           
     
     
      metals:
             
             mov dx,10
             mov ah,2
             int 21h 
            
             lea dx,met1
             mov ah,9
             int 21h
            
            
             lea dx,met2
             mov ah,9
             int 21h
            
             lea dx,met3
             mov ah,9
             int 21h
            
            
             lea dx,met4
             mov ah,9
             int 21h
            
            
             lea dx,met5
             mov ah,9
             int 21h 
            
             lea dx,met6
             mov ah,9
             int 21h
            
            
             lea dx,met7
             mov ah,9
             int 21h
                       
                       
             lea dx,met8
             mov ah,9
             int 21h                   
      
           
             lea dx,met9
             mov ah,9
             int 21h
            
             jmp check
             
             
   ;-------------------Checking for the metal detected-----------------
            
            
     check: 
            
             mov dx,10
             mov ah,2
             int 21h
             
             lea dx,input
             mov ah,9
             int 21h
             
             mov ah,1    ;Input value for the metal detection.
             int 21h
             mov cl,al
             
             cmp cl,'9'   ;Checking for wrong input
             jg wrong  
             
             cmp cl,'1'
             jl wrong
            
             cmp cl,'7'  ;Checking for legal metal
             jge legal
            
             cmp cl,'3'
             jge mid_illegal  ;Checking for short range illegal metal
            
            
             cmp cl,'1'      ; Checking for dangerous metal
             jge illegal
             
             
   ;-----------------Legal metal detection---------------------          
         
         
       legal:
       
             mov dx,10
             mov ah,2
             int 21h 
               
             lea dx,legally
             mov ah,9
             int 21h
      
             inc bl
             jmp search
                
                  
   ;-----------------Short range illegal metal punishment message---------              
        
            
 mid_illegal:
             mov dx,10
             mov ah,2
             int 21h
             
             lea dx,crime
             mov ah,9
             int 21h
             
             mov dx,10
             mov ah,2
             int 21h
             
             lea dx,police
             mov ah,9
             int 21h
                
             mov dx,10
             mov ah,2
             int 21h
       
             lea dx,msg4
             mov ah,9
             int 21h
             
             
 
             jmp exit_it
        
                
   ;-----------------Dangerous illegal metal punishment metal message---------             
            
       
     illegal: 
          
             mov dx,10
             mov ah,2
             int 21h
             
             lea dx,crime
             mov ah,9
             int 21h
             
             mov dx,10
             mov ah,2
             int 21h
             
             lea dx,police
             mov ah,9
             int 21h
                
             mov dx,10
             mov ah,2
             int 21h
      
             lea dx,msg5
             mov ah,9
             int 21h 
             
             jmp exit_it
             
   ;---------------------For wrong input-----------------------------------
   
   
   
    wrong:
    
           lea dx,msg
           mov ah,9
           int 21h
           
           mov dx,10
           mov ah,2
           int 21h
           
           jmp check                   
       
       
   ;------------------------End of The code--------------------------------                    
    
      exit_it:
      
             mov ah,4ch
             int 21h 
   
    
      main endp
end main
          
     
   
   
   
   
   
   
   
   