                      
.model small
.stack 200h
.data
    xaxis  dw 40D    ; cx--> x-axis
    yaxis  dw 30D    ;dx -> y-axis
    widths  dw 141D
    height  dw 141D     ; the widths and the height of the shape
    middle    dw ?
    block_helper_var_1 dw ?
    block_helper_var_2 dw ?

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

end main