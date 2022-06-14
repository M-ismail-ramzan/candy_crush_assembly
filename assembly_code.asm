                   
.model small
.stack 200h
.data
    xaxis  dw 40D    ; cx--> x-axis  ; For center add 6D
    yaxis  dw 30D    ;dx -> y-axis   ; For center add 7D
    widths  dw 141D
    height  dw 141D     ; the widths and the height of the shape
    middle    dw ?
    block_helper_var_1 dw ?
    block_helper_var_2 dw ?
    double_triangle_candy_initial_x_position dw 65D  ; cx--> x-axis
    double_triangle_candy_initial_y_position dw 57D  ;dx -> y-axis
    double_triangle_candy_width dw 8D
    double_triangle_candy_height dw 5D ; the width and the height of the shape
    double_triangle_middle_position dw ?

    color_bomb_x_axis dw 20D
    color_bomb_y_axis dw 20D
    color_bomb_width dw 6D
    color_bomb_height dw 1D
    
    swapping_helper dw ?

    lollipop_candy_x_axis dw 10D
    lollipop_candy_y_axis dw 60D
    lollipop_candy_width dw 7D
    lollipop_candy_height dw 6D
    lollipop_candy_leggy dw 5D

    butterfly_candy_x_axis dw 10D
    butterfly_candy_y_axis dw 80D
    butterfly_candy_width dw 6D   ; double of height
    butterfly_candy_height dw 3D ; half of width
    butterfly_candy_middle dw 5D

    arr db 49 dup(?)
.code
main proc
                         mov   ax,@data
                         mov   ds,ax
                         ; Setting the Video Mode
                         mov   ah,00h
                         mov   al,13h
                         int   10h
                         ;set background color
                          mov   ah,0bh
                         mov   bh,00h
                         mov   bl,09h
                         int   10h

                         ; Defining the initial Positions
                         MOV   CX, xaxis
                         mov   Dx, yaxis
                            ; call color_bomb_candy
                         draw_horizaontal_lines:
                         ; drawing a pixel
                         mov   ah,0ch
                         mov   al,09h
                         mov   bh,00h
                         int   10H
                         inc   CX                      
                         mov   ax,CX
                         sub   ax,xaxis
                                                  ;Stop creating Line with reaches the a Particular X-axis Position
                         .WHILE (ax < widths)
                         jmp   draw_horizaontal_lines
                         .ENDW
                        ;Reset the Position of the x-axis
                         mov   cx,xaxis
                        ; Now move to the next columns..
                         add   Dx,20D
                         mov   ax,Dx
                         sub   ax,yaxis
                         ; Stop drawing when u reach the Particular Height..
                        .WHILE(ax < height)
                         jmp   draw_horizaontal_lines
                         .ENDW


                        ; Now drawing the Vertical Lines...
                          ; Defining the initial Positions
                         MOV   CX, xaxis
                         mov   Dx, yaxis

                         draw_vertical_lines:
                         ; drawing a pixel
                         mov   ah,0ch
                         mov   al,09h
                         mov   bh,00h
                         int   10H
                         inc   DX                      
                         mov   ax,DX
                         sub   ax,yaxis
                                                  ;Stop creating Line with reaches the a Particular X-axis Position
                         .WHILE (ax < height)
                         jmp   draw_vertical_lines
                         .ENDW
                         ; move cx..Further
                         add cx,20D
                         ;dx will be the same Position
                         mov dx,yaxis
                        mov ax,cx
                        sub ax,xaxis
                          .WHILE (ax < widths)
                         jmp   draw_vertical_lines
                         .ENDW

                        ; Now grid has been made..
                        ; let's block the GRIDs..
                        ; BLOCKING THE FIRST col....                        
                        mov block_helper_var_2,30D
                        .WHILE(block_helper_var_2 <= 150D)
                        mov block_helper_var_1,40D
                        call block_proc
                        .if((block_helper_var_2 != 50D && block_helper_var_2 != 90D))
                        add block_helper_var_2,20D
                        .else
                        add block_helper_var_2,40D
                        .endif
                        .ENDW
                        ; blocking the Last rcol
                        mov block_helper_var_2,30D
                        .WHILE(block_helper_var_2 <= 150D)
                        mov block_helper_var_1,160D
                        call block_proc
                        .if((block_helper_var_2 != 50D && block_helper_var_2 != 90D))
                        add block_helper_var_2,20D
                        .else
                        add block_helper_var_2,40D
                        .endif
                        .ENDW

                        ; Now blocking the Third Column..
                        mov block_helper_var_1,100D
                        mov block_helper_var_2,30D
                        call block_proc
                        
                        mov block_helper_var_1,100D
                        mov block_helper_var_2,150D
                        call block_proc
                        ; drawing the candy
                        ;call double_triangle_candy
                        
                       ; call color_bomb_candy

                      ;  call lollipop_candy
                     ;   call butterfly_candy
                      ;   call color_bomb_candy
                        ;Populate the Grid...
                        ; 40D,30D -- 1x1

                        

                        mov double_triangle_candy_initial_x_position,46D
                        mov double_triangle_candy_initial_y_position,20D
                      
                        
                        mov si, offset arr
                        mov di,1d
                        .while(di <= 49d)
                            add double_triangle_candy_initial_y_position,20D
                            ;gENERATE THE random Numbers,,,
                            mov ah,2ch
                            int 21h
                            ;int  1Ah    ; TIME - Get System time
                            ; CX:DX = number of clock ticks since midnight
                                ;  AL = midnight flag
                            mov ax,0
                            add dx,di
                            add dx,double_triangle_candy_initial_x_position
                            mov al,Dl
                            
                            mov bl,4D
                            div bl
                            ; Now add the data to the array
                           ; mov [si],ah
                            add di,1D
                                   
                            mov [arr+si],ah
                            inc si
                            ;Specifying only avaliable..
                            .if(!(di == 1D || di == 2D || di == 3D|| di == 5D || di == 7D || di == 8D ||di == 23D || di == 29D || di == 44D || di == 45D || di == 47D || di == 49D  || di == 50D))
                                .if(ah == 0D)
                                        call double_triangle_candy                            
                                .ELSEIF(ah == 1D)
                                        mov bx,double_triangle_candy_initial_x_position
                                        mov lollipop_candy_x_axis,bx
                                        mov bx,double_triangle_candy_initial_y_position
                                        mov lollipop_candy_y_axis,bx
                                        call lollipop_candy
                                .ELSEIF(ah == 2D)
                                        mov bx,0
                                        mov bx,double_triangle_candy_initial_x_position
                                        mov butterfly_candy_x_axis,bx
                                        mov bx,double_triangle_candy_initial_y_position
                                        mov butterfly_candy_y_axis,bx
                                        call butterfly_candy
                                .ELSEIF(ah == 3D)
                                        mov bx,0
                                        mov bx,double_triangle_candy_initial_x_position
                                        add bx,2D
                                        mov color_bomb_x_axis,bx
                                        mov bx,double_triangle_candy_initial_y_position
                                        sub bx,5d
                                        mov color_bomb_y_axis,bx
                                        call color_bomb_candy
                                .endif
                            .endif
                            .if(di == 8D || di == 15D || di == 22d || di == 29d ||  di == 36d || DI == 43D)
                                add double_triangle_candy_initial_x_position,20D
                                mov double_triangle_candy_initial_y_position,20D
                            .endif
                        .endw



                        ; Now al, contains the Remainder... %3 so 0,1,2 or 3

                        
                      
                         
                      ;  jmp fill_the_board
                       ; .ENDW


                        ; This code check's when the Left key of the Mouse if Pressed
                        left_key_pressed:
                        again:
                        ; get draw info
                        mov ax,5
                        mov bx,0
                        int 33h
                        cmp ax,1
                        jne again

                        ; setting the Mouse Position..
                      ; mov ax,04h
                     ;   mov cx,50D
                     ;   mov dx,30D
                        ;mov cx,0
                        ;mov dx,0
                       ; mov ax,03  
                       ; mov ax,20h
                       ; int 33h
                       ; mov ax,01h
                       ; int 33h

                        
                     ;    mov cx,0
                     ;   mov dx,0

                       mov ax,03  
                       int 33h

                        ; Perform anything in here..
                        ; we have the x-corrdinates and Y-corrdinates...
                      mov ax,01h
                        int 33h
                     
                        ;sub cx,120D
                        ; Important CODE for Exact Mouse Positions..!!
                       ; mov dx,0
                        mov ax,CX
                        mov bl,2
                        div bl
                        add ax,0                
                        mov cx,ax

                         

                        .if((cx >= 00D) && (cx <= 320D))
                        ; Iniside the Board
                            ;1) find the Box where the Button is Pressed
                                .if( (cx >= 40D) && (cx <= 60D))
                                    .if((dx >= 30D) && (dx<=50D))
                                     mov si,0
                                        
                                        mov   ah,0ch
                                        mov   al,05h
                                        mov   bh,00h
                                        int   10H
                                    .endif
                                    ; drawing a pixel
                                    .if((dx >= 50D) && (dx<=70D))
                                     mov si,0
                                        
                                        mov   ah,0ch
                                        mov   al,05h
                                        mov   bh,00h
                                        int   10H
                                    .endif

                                    .if((dx >= 70D) && (dx<=90D))
                                        mov si,3D
                                        mov swapping_helper,si           
                                        call swapping_identifier       
                                    .endif

                                    .if((dx >= 90D) && (dx<=110D))
                                        mov si,4D
                                        mov swapping_helper,si              
                                        call swapping_identifier       
                                    .endif

                                    .if((dx >= 110D) && (dx<=130D))
                                        mov si,5D
                                        mov swapping_helper,si               
                                        call swapping_identifier       
                                    .endif
                                    ; FOR SECOND COLUMN
                                .ELSEIF( (cx >= 60D) && (cx <= 80D))
                                     .if((dx >= 30D) && (dx<=50D))
                                         mov si,8D
                                        mov swapping_helper,si               
                                        call swapping_identifier
                                    .endif 
                                    ; drawing a pixel
                                    .if((dx >= 50D) && (dx<=70D))
                                        mov si,9D
                                        mov swapping_helper, si              
                                        call swapping_identifier 
                                    .endif 
                                    .if((dx >= 70D) && (dx<=90D))
                                        mov si,10D
                                        mov swapping_helper,si          
                                        call swapping_identifier       
                                    .endif

                                    .if((dx >= 90D) && (dx<=110D))
                                        mov si,11D
                                        mov swapping_helper,si              
                                        call swapping_identifier       
                                    .endif

                                    .if((dx >= 110D) && (dx<=130D))
                                        mov si,12D
                                        mov swapping_helper,si               
                                        call swapping_identifier       
                                    .endif
                                     .if((dx >= 130D) && (dx<=150D))
                                        mov si,13D
                                        mov swapping_helper,si               
                                        call swapping_identifier       
                                    .endif
                                     .if((dx >= 150D) && (dx<=170D))
                                        mov si,14D

                                       ; mov arr[si],2D
                                        mov swapping_helper,si               
                                        call swapping_identifier       
                                    .endif
                            
                                .ELSEIF( (cx >= 80D) && (cx <= 100D))
                                ; drawing a pixel
                            
                                mov   ah,0ch
                                mov   al,0fh
                                mov   bh,00h
                                int   10H
                                
                                .ELSEIF( (cx >= 100D) && (cx <= 120D))
                                ; drawing a pixel
                            
                                mov   ah,0ch
                                mov   al,04h
                                mov   bh,00h
                                int   10H

                                .ELSEIF( (cx >= 120D) && (cx <= 140D))
                                ; drawing a pixel
                            
                                mov   ah,0ch
                                mov   al,07h
                                mov   bh,00h
                                int   10H

                                .ELSEIF( (cx >= 140D) && (cx <= 160D))
                                ; drawing a pixel
                            
                                mov   ah,0ch
                                mov   al,08h
                                mov   bh,00h
                                int   10H
                                .ELSE
                                mov   ah,0ch
                                mov   al,10h
                                mov   bh,00h
                                int   10H
                                .endif 

                            
                          ;2) Remove the Candy from that Box
                          ;3) Check where the User has made Movement
                          ;4) Move the removed candy to that new Box
                          ;5) Bring the old candy to the new Box...
                          ;6) Check if there  is some crush
                          ; 7) if there is then do bubble
                          ; 8) else remove the above steps and move the candy back's 
                        .endif

                        cmp cx,9999D
                        jne left_key_pressed

                         MOV   AH,4ch
                         int   21h


main endp

swapping_identifier proc uses ax bx cx dx si

                                        mov si,swapping_helper
                                    .if([arr+si] == 0D)
                                        ; make spenceer
                                        mov double_triangle_candy_initial_x_position,20D
                                        mov double_triangle_candy_initial_x_position,20D
                                        call double_triangle_candy
                                        .endif
                                        .if([arr+si] == 1D)
                                        ; make spenceer
                                        mov lollipop_candy_x_axis,20D
                                        mov lollipop_candy_y_axis,20D
                                         call lollipop_candy
                                        .endif
                                        .if([arr+si] == 2D)
                                        ; make spenceer
                                        mov butterfly_candy_x_axis,20D
                                        mov butterfly_candy_y_axis,40D
                                        call butterfly_candy
                                        .endif
                                         .if([arr+si] == 3D)
                                        ; make spenceer
                                        mov color_bomb_x_axis,20D
                                        mov color_bomb_y_axis,40D
                                         call color_bomb_candy
                                        .endif
ret
swapping_identifier endp

block_proc proc
                         MOV   CX, block_helper_var_1
                        mov   Dx, block_helper_var_2

                         block_vertical_first_block:
                         ; drawing a pixel
                         mov   ah,0ch
                         mov   al,09h
                         mov   bh,00h
                         int   10H
                         inc   CX                      
                         mov   ax,CX
                         sub   ax,block_helper_var_1

                         .WHILE (ax < 20D)
                         jmp   block_vertical_first_block
                         .ENDW                    

                        inc dx
                        mov cx,block_helper_var_1
                        mov ax,dx
                        sub ax,block_helper_var_2
                        .WHILE(ax < 20D)
                        jmp block_vertical_first_block
                        .ENDW

ret
block_proc endp
;The code for the Butterfly Candy...
butterfly_candy proc uses di ax bx cx dx 
  ; Defining the initial Positions
MOV CX, butterfly_candy_x_axis
mov Dx,butterfly_candy_y_axis

butterfly_candy_horizontal:
    ; drawing a pixel
    mov ah,0ch
    mov al,09h
    mov bh,00h
    int 10H
    inc CX ; increase the x-axis
    ; compare the x-axis with the ball size cx - ball-x-position > size ( go to next line)
    mov ax,CX 
    sub ax,butterfly_candy_x_axis
    .while (ax < butterfly_candy_width)
    jmp butterfly_candy_horizontal 
    .endw 
    
    mov cx,butterfly_candy_x_axis
    mov dx,butterfly_candy_y_axis
butterfly_candy_left_first_tilt:
    mov ah,0ch
    mov al,09h
    mov bh,00h
    int 10H 
    inc cx
    inc dx
    mov ax,CX 
    sub ax,butterfly_candy_x_axis
    .while (ax < butterfly_candy_height)
    jmp butterfly_candy_left_first_tilt 
    .endw 
    ;changing x-axis and y-axis position..
    mov di,butterfly_candy_x_axis
    mov butterfly_candy_x_axis,cx
    mov butterfly_candy_y_axis,dx
butterfly_candy_right_first_tilt:
    mov ah,0ch
    mov al,09h
    mov bh,00h
    int 10H 
    inc cx
    dec dx
    mov ax,CX 
    sub ax,butterfly_candy_x_axis
    .while (ax < butterfly_candy_height)
    jmp butterfly_candy_right_first_tilt 
    .endw 

    
    mov cx,butterfly_candy_x_axis
    mov dx,butterfly_candy_y_axis
    butterfly_candy_right_second_tilt:
    mov ah,0ch
    mov al,09h
    mov bh,00h
    int 10H 
    inc cx
    inc dx
    mov ax,CX 
    sub ax,butterfly_candy_x_axis
    .while (ax < butterfly_candy_height)
    jmp butterfly_candy_right_second_tilt 
    .endw 

    mov si,butterfly_candy_x_axis
    sub si,butterfly_candy_height
   ; add si,2D
    mov cx,butterfly_candy_x_axis
    mov dx,butterfly_candy_y_axis
     butterfly_candy_straight_second_tilt:
    mov ah,0ch
    mov al,09h
    mov bh,00h
    int 10H 
    dec cx
    inc dx
    mov ax,CX 
    sub ax,si
    mov butterfly_candy_x_axis,cx
    mov butterfly_candy_y_axis,dx
    .while (ax < butterfly_candy_width)
    jmp butterfly_candy_straight_second_tilt 
    .endw 


    mov cx,di
    mov dx,butterfly_candy_y_axis
    draw_straight_final_line:
    mov ah,0ch
    mov al,09h
    mov bh,00h
    int 10H 
    inc cx
     mov ax,CX 
    sub ax,di
    .while (ax < butterfly_candy_width)
    jmp draw_straight_final_line 
    .endw 
   
ret
butterfly_candy endp
;This is the Lollipop Cnady...

lollipop_candy proc
; Defining the initial Positions
MOV CX, lollipop_candy_x_axis
mov Dx,lollipop_candy_y_axis

lollipop_candy_horizontal:
    ; drawing a pixel
    mov ah,0ch
    mov al,09h
    mov bh,00h
    int 10H
    inc CX ; increase the x-axis
    ; compare the x-axis with the ball size cx - ball-x-position > size ( go to next line)
    mov ax,CX 
    sub ax,lollipop_candy_x_axis
    .while (ax < lollipop_candy_width)
    jmp lollipop_candy_horizontal 
    .endw

    inc dx
    mov cx,lollipop_candy_x_axis
    mov ax,Dx
    sub ax,lollipop_candy_y_axis
    .while (ax < lollipop_candy_height)
    jmp lollipop_candy_horizontal 
    .endw

    ;Drawing the Leg of the Lollipop candy..
    mov lollipop_candy_y_axis,dx
    add cx,3D
    lollipop_candy_leg:
     mov ah,0ch
    mov al,09h
    mov bh,00h
    int 10H
    inc dx
    mov ax,dx
    sub ax,lollipop_candy_y_axis
    
    .while(ax < lollipop_candy_leggy)
    jmp lollipop_candy_leg
    .endw

ret
lollipop_candy endp
; this is the color bomb candy
color_bomb_candy proc uses ax bx cx dx di si 
; Defining the initial Positions

mov si,color_bomb_width
.while(si != 12D)
    MOV CX, color_bomb_x_axis
    mov Dx,color_bomb_y_axis
    mov al,04h
    draw_lollipop_horizontal:
        ; drawing a pixel
        mov ah,0ch
        ;mov al,04h
        mov bh,00h
        int 10H
        inc CX ; increase the x-axis
        ; compare the x-axis with the ball size cx - ball-x-position > size ( go to next line)
        mov ax,CX 
        sub ax,color_bomb_x_axis
        .while (ax < color_bomb_width)
        jmp draw_lollipop_horizontal 
        .endw

        add dx,1
        mov cx,color_bomb_x_axis
        mov ax,Dx
        sub ax, color_bomb_y_axis
        .while(ax < color_bomb_height)
        jmp draw_lollipop_horizontal
        .endw
        add si,2D
     ;   add dx,1D
      sub color_bomb_x_axis,1D
        add color_bomb_y_axis,2D  
        add color_bomb_width,2D
        inc al
    .endw

    mov si,6D
.while(si != 14D)
    MOV CX, color_bomb_x_axis
    mov Dx,color_bomb_y_axis
    mov al,01h
    draw_lollipop_horizontal_1:
        ; drawing a pixel
        mov ah,0ch
        
        mov bh,00h
        int 10H
        inc CX ; increase the x-axis
        ; compare the x-axis with the ball size cx - ball-x-position > size ( go to next line)
        mov ax,CX 
        sub ax,color_bomb_x_axis
        .while (ax < color_bomb_width)
        jmp draw_lollipop_horizontal_1 
        .endw

        add dx,1
        mov cx,color_bomb_x_axis
        mov ax,Dx
        sub ax, color_bomb_y_axis
        .while(ax < color_bomb_height)
        jmp draw_lollipop_horizontal_1
        .endw
        add si,2D
     ;   add dx,1D
     add color_bomb_x_axis,1D
        add color_bomb_y_axis,2D  
        sub color_bomb_width,2D
        inc al
    .endw
    ret
color_bomb_candy endp

double_triangle_candy proc
        

; Defining the initial Positions
MOV CX, double_triangle_candy_initial_x_position
mov Dx,double_triangle_candy_initial_y_position

draw_ball_horizontal:
    ; drawing a pixel
    mov ah,0ch
    mov al,09h
    mov bh,00h
    int 10H
    inc CX ; increase the x-axis
    ; compare the x-axis with the ball size cx - ball-x-position > size ( go to next line)
    mov ax,CX 
    sub ax,double_triangle_candy_initial_x_position
    .while (ax < double_triangle_candy_width)
    jmp draw_ball_horizontal 
    .endw
    ;cmp ax,Ball_size
    ;jng draw_ball_horizontal
    mov cx,double_triangle_candy_initial_x_position
    ; otherwise go to the next column
    inc Dx
    mov ax,Dx
    sub ax,double_triangle_candy_initial_y_position
    ; if this condition does not satisfy then stop creating
    .while(ax < double_triangle_candy_height)
    jmp draw_ball_horizontal
    .endw
    ; otherwise stop..
    
    
    
    ;Finding the Middle of the Rectangle.. for drawing of corners..
    mov dx,0
    mov ax,double_triangle_candy_height
    mov bx,2
    div bx
    add ax,double_triangle_candy_initial_y_position
    mov double_triangle_middle_position,ax


    ; Start Drawing the Left Corner of the Candy.
    mov cx,double_triangle_candy_initial_x_position
    mov dx,double_triangle_middle_position

    ; Now i need to draw the triangle's on the side of the candy
   
    ; drawing the top tilted line.
    draw_left_side:
        mov ah,0ch
        mov al,09h
        mov bh,00h
        int 10h
        dec cx
        dec dx
        mov ax,dx
        sub ax,double_triangle_candy_initial_y_position
        .while(ax < double_triangle_candy_height)
        jmp draw_left_side
        .endw
  
    ; Drawing the straight line between corners
    mov cx,cx
    mov dx,dx
    
    draw_straight_line:
        mov ah,0ch
        mov al,09h
        mov bh,00h
        int 10h
        inc dx
        mov ax,dx 
        sub ax,double_triangle_candy_initial_y_position
        .while(ax < double_triangle_candy_height)
        jmp draw_straight_line
        .endw
    ; Drawing the tilted left line
    mov cx,cx
    mov dx,dx
    draw_right_side:
        mov ah,0ch
        mov al,09h
        mov bh,00h
        int 10h
        inc cx
        dec dx
        mov ax,dx
        sub ax,double_triangle_candy_initial_y_position
        .while(ax < double_triangle_middle_position)
        jmp draw_right_side
        .endw
    
    
    ;; Now left Corner of the Candy is made.. Let's create the second Corner
    
    
    ; Get the middle value of the Shape
    mov dx,0
    mov ax,double_triangle_candy_height
    mov bx,2
    div bx
    add ax,double_triangle_candy_initial_y_position
    mov double_triangle_middle_position,ax
    
   
    mov cx,double_triangle_candy_initial_x_position
    add cx,double_triangle_candy_width
    mov cx,cx
    mov dx,double_triangle_middle_position
     ; drawing the bottom tilted line.
    draw_right_bottom_side_of_first_candy:
        mov ah,0ch
        mov al,09h
        mov bh,00h
        int 10h
        inc cx
        inc dx
        mov ax,dx
        sub ax,double_triangle_candy_initial_y_position
        .while(ax < double_triangle_candy_height)
        jmp draw_right_bottom_side_of_first_candy
        .endw
        
    mov cx,cx
    mov dx,dx
    ; drawing the Straight Line
    draw_line_side_of_first_candy:
        mov ah,0ch
        mov al,09h
        mov bh,00h
        int 10h
        dec dx
        mov ax,dx
        sub ax,double_triangle_candy_initial_y_position
        .while(ax < double_triangle_candy_height)
        jmp draw_line_side_of_first_candy
        .endw
        
     
    mov cx,cx
    mov dx,dx
    mov si,0
    mov si,dx
    ; Drawing the Left tilted line.
    draw_left_bottom_side_of_first_candy:
        mov ah,0ch
        mov al,09h
        mov bh,00h
        int 10h
        dec cx
        inc dx   
        mov ax,dx
        sub ax,si
        .while(ax < double_triangle_candy_height)
        jmp draw_left_bottom_side_of_first_candy
        .endw
ret
double_triangle_candy endp

end main
