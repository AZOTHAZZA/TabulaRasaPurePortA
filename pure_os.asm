[org 0x7c00]

; --- 初期化 ---
xor ax, ax
mov ds, ax
mov es, ax
mov ax, 0x0003      ; 80x25 テキストモード
int 0x10
mov ax, 0xb800      ; VRAMセグメント
mov gs, ax

call init_port

; --- メインループ: 多通貨貿易の執行 ---
main_trade_loop:
    call draw_port_a_ui

    ; 7通貨のベース値（黄金比に基づきレジスタに保持）
    mov eax, 625000000 ; PURE
    mov ebx, 386271000 ; USD
    ; (他通貨も同様のレジスタ操作で執行)

    ; --- 通貨パケットの射出 ---
    ; PUREの送信
    mov al, 'P'
    call send_byte
    mov edi, 625000000
    call send_dword

    ; USDの送信
    mov al, 'U'
    call send_byte
    mov edi, 386271000
    call send_dword

    ; 1/z の周期待機
    mov cx, 0xFFFF
.delay:
    loop .delay
    jmp main_trade_loop

; --- サブルーチン: 物理層の執行 ---

init_port:
    mov dx, 0x3fb
    mov al, 0x80
    out dx, al
    mov dx, 0x3f8
    mov al, 0x03
    out dx, al
    xor al, al
    mov dx, 0x3f9
    out dx, al
    mov dx, 0x3fb
    mov al, 0x03
    out dx, al
    ret

send_byte:
    push dx
    push ax
    mov dx, 0x3fd
.wait:
    in al, dx
    test al, 0x20
    jz .wait
    pop ax
    mov dx, 0x3f8
    out dx, al
    pop dx
    ret

send_dword:
    ; EDIの内容を4回に分けて送信
    mov al, bl          ; 下位8ビット
    call send_byte
    mov al, bh          ; 次の8ビット
    call send_byte
    ; ... (本来はシフト演算で全ビット送りますが、まずは基礎を)
    ret

; --- UI描写: 黄金比の配置 ---
draw_port_a_ui:
    ; 画面をクリアして "PORT A: PURE GENERATOR" と表示
    ; (以前の UI 描画コードをここに記述)
    ret

times 510-($-$$) db 0
dw 0xaa55
