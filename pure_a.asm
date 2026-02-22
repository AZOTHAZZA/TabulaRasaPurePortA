; ======================================================
; PURE ARCHE - Port A (Value Basis & Immutable Law)
; 100億の価値根源と、34資産の法を習合させた完成体
; ======================================================
[BITS 16]
[ORG 0x7C00]

start:
    cli             ; 沈黙（Silence）：既存のノイズを遮断
    xor ax, ax      ; 初期化
    mov ds, ax
    mov es, ax

    ; --- [数] 100億の価値根源を二つのレジスタで受肉 ---
    ; 10,000,000,000 = 0x00000002 (EDX) : 0x540BE400 (EAX)
    mov eax, 0x540BE400 ; 下位32ビット
    mov edx, 0x00000002 ; 上位32ビット（これで100億の価値を物理固定）
    mov ebx, 1618       ; 黄金比 φ

    ; --- [法] 34スロットの価値固定宣言 ---
    mov si, label_syncretism_a
    call print_string

hang:
    ; この比率を世界に固定し、法を監視し続ける
    hlt
    jmp hang

; --- 習合された真名 ---
label_syncretism_a db 'PURE: 10B RATIO DEFINED. 34 SLOTS IMMUTABLE.', 0

print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

; --- 512バイトの物理的な封印 ---
times 510-($-$$) db 0
dw 0xAA55               ; 聖域の印（共通の鍵）：Port B との共鳴点
