; ref: https://autohotkey.com/board/topic/5545-base64-coderdecoder/page-3

;string based base64 encode
Base64Encode(String)
{
    static CharSet := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    VarSetCapacity(Output,Ceil(Length / 3) << 2)
    Index := 1, Length := StrLen(String)
    Loop, % Length // 3
    {
        Value := Asc(SubStr(String,Index,1)) << 16
            | Asc(SubStr(String,Index + 1,1)) << 8
            | Asc(SubStr(String,Index + 2,1))
        Index += 3
        Output .= SubStr(CharSet,(Value >> 18) + 1,1)
            . SubStr(CharSet,((Value >> 12) & 63) + 1,1)
            . SubStr(CharSet,((Value >> 6) & 63) + 1,1)
            . SubStr(CharSet,(Value & 63) + 1,1)
    }
    Length := Mod(Length,3)
    If Length = 0 ;no characters remain
        Return, Output
    Value := Asc(SubStr(String,Index,1)) << 10
    If Length = 1
    {
        Return, Output ;one character remains
            . SubStr(CharSet,(Value >> 12) + 1,1)
            . SubStr(CharSet,((Value >> 6) & 63) + 1,1) . "=="
    }
    Value |= Asc(SubStr(String,Index + 1,1)) << 2 ;insert the third character
    Return, Output ;two characters remain
        . SubStr(CharSet,(Value >> 12) + 1,1)
        . SubStr(CharSet,((Value >> 6) & 63) + 1,1)
        . SubStr(CharSet,(Value & 63) + 1,1) . "="
}

;string based base64 decode
Base64Decode(Code)
{
    static CharSet := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    Length := StrLen(Code)

    ;remove padding if present
    If SubStr(Code,0) = "="
    {
        If SubStr(Code,-1,1) = "="
            Length -= 2
        Else
            Length --
    }

    BufferSize := Ceil((Length / 4) * 3), VarSetCapacity(Data,BufferSize) ;calculate the correct buffer size
    Index := 1, BinPos := 0
    Loop, % Length >> 2 ;process 4 characters per iteration
    {
        ;decode the characters and store them in the output buffer
        Value := ((InStr(CharSet,SubStr(Code,Index,1),1) - 1) << 18)
            | ((InStr(CharSet,SubStr(Code,Index + 1,1),1) - 1) << 12)
            | ((InStr(CharSet,SubStr(Code,Index + 2,1),1) - 1) << 6)
            | (InStr(CharSet,SubStr(Code,Index + 3,1),1) - 1)
        Index += 4
        Data .= Chr(Value >> 16) . Chr((Value >> 8) & 255) . Chr(Value & 255)
    }
    Length &= 3 ;determine the number of characters that remain
    If Length > 0 ;characters remain
    {
        ;decode the first of the remaining characters and store it in the output buffer
        Value := ((InStr(CharSet,SubStr(Code,Index,1),1) - 1) << 18)
            | ((InStr(CharSet,SubStr(Code,Index + 1,1),1) - 1) << 12)
        Data .= Chr(Value >> 16)

        ;another character remains
        If Length = 3
        {
            ;decode the character and store it in the output buffer
            Value |= (InStr(CharSet,SubStr(Code,Index + 2,1),1) - 1) << 6
            Data .= Chr((Value >> 8) & 255)
        }
    }
    Return, Data
}
