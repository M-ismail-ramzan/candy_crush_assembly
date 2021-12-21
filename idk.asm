                   
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
    candy_arr dw 1,2,3,4,5,6,7,8,9
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
                        ; BLOCKING THE FIRST ROW....                        
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

                        ;Populate the Grid...
                        ; 40D,30D -- 1x1
                        mov double_triangle_candy_initial_x_position,46D
                        ; Fill the Board
                        fill_the_board:
                       mov double_triangle_candy_initial_y_position,20D
                        .While(double_triangle_candy_initial_y_position <= 150D)
                        add double_triangle_candy_initial_y_position,20D
                        call double_triangle_candy
                        .ENDW
                        
                         .While(double_triangle_candy_initial_x_position <= 150D)
                        add double_triangle_candy_initial_x_position,20D
                        jmp fill_the_board
                        .ENDW


                        ; This code check's when the Left key of the Mouse if Pressed
                        left_key_pressed:
                        mov ax,1
                        int 33h
                        again:

                        mov ax,3
                        int 33h

                        ;set cursor position
                        mov ax,4
                        int 33h
                        ; get draw info
                        mov ax,5
                        mov bx,0
                        int 33h
                        cmp ax,1
                        jne again

                        ; Perform anything in here..
                        ; we have the x-corrdinates and Y-corrdinates...
                        
                        loop left_key_pressed


                         MOV   AH,4ch
                         int   21h


main endp



blocky_caller proc
ret
blocky_caller endp

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