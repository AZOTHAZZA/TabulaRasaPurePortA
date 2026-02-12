; ==========================================
; PURE ARCHE - Port A (Value & Ratio)
; ==========================================
[BITS 16]           ; 16ビット・リアルモード（根源の動作モード）
[ORG 0x7C00]        ; ブートセクタの標準開始アドレス

start:
    cli             ; 既存の割り込み（ノイズ）を禁止 (Silence)
    xor ax, ax      ; レジスタを Tabula Rasa（ゼロ）に
    mov ds, ax
    mov es, ax

    ; --- [数] 黄金比 & 比率の定義 ---
    ; 100億の RATIO を数理的に受肉させる
    mov eax, 10000000000 ; 100億 (Value Basis)
    mov ebx, 1618        ; 黄金比 φ (1.618... の整数表現)
    
    ; --- [ラベル] 言語ゲームの定着 ---
    ; 画面に PURE / SOL / RATIO を刻印する (物理的なマウント)
    mov si, label_pure
    call print_string

hang:
    hlt             ; CPUを静止させ、この比率を世界に固定する
    jmp hang

; --- データの定義 (数＋ラベル) ---
label_pure db 'PURE: 10,000,000,000 RATIO (SOL)', 0

print_string:       ; 最小限の出力ロジック
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

; --- 512バイトの物理的な封印 ---
times 510-($-$$) db 0   ; 残りの領域を 0 (Tabula Rasa) で埋める
dw 0xAA55               ; ブートシグネチャ（これが鍵の正体）
