; the Argument Passed to this are Following
; 1) x-position  -> Variable  double_triangle_candy_initial_x_position
; 2) y -positon --> variable double_triangle_candy_initial_y_position
; 3)  width --> variable double_triangle_candy_width
; 4)  height --> variable double_triangle_candy_height
; 5) Middle value --> variable double_triangle_middle_position
double_triangle_candy macro double_triangle_candy_initial_x_position,double_triangle_candy_initial_y_position,double_triangle_candy_width,double_triangle_candy_height,double_triangle_middle_position


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
        
endm