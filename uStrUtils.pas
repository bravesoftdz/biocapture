unit uStrUtils;

interface

uses
  Classes, SysUtils, Graphics{, uTStringsContainer};

const
  Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';

type
  TStringArray = array of string;
  TCharSet = set of Char;

  TAdvStringList = class (TStringList)
  private
    FKeepBlankTokens: Boolean;
    FTokenSeparator: Char;
    FQuoteChar: Char;
    function GetTokenizedText: string;
    procedure SetTokenizedText(const Value: string);
  public
    constructor Create;
    property KeepBlankTokens: Boolean read FKeepBlankTokens write FKeepBlankTokens;
    property TokenizedText: string read GetTokenizedText write SetTokenizedText;
    property TokenSeparator: Char read FTokenSeparator write FTokenSeparator;
    property QuoteChar: Char read FQuoteChar write FQuoteChar;
  end;

//function RemoveEscapeChars (const s : string; EscChar : char) : string;
//function TextToBool (const Value : string) : boolean;
//function BoolToText (Value : boolean) : char;
//function EliminateWhiteSpaces (const s : string) : string;
//function EliminateChars (const s : string; const chars : TCharSet) : string;
//function LastPartOfName (const s : String) : string;
//function FirstPartOfName(const s : string): string;
//procedure MixTStrings(Source, Dest : TStrings; FromIndex : Integer = 0);
//function CommaList(const Items : string): string;
//function ListOfItems(const Items : array of string): String;
//function QuotedListOfItems(const Items : array of string): String;
//procedure RemoveBlankItems(List : TStringList);
//function FirstNonEmptyString(const Strs : array of string): string;
//function AddStrings(const Items : array of string): String; overload;
//function AddStrings(const Items, Items2 : array of string): String; overload;
//function IndexOf(const Items : array of string; const Item : String;
//    CaseSensitive : boolean = false): Integer;
//procedure DeleteFromArray(var Items: TStringArray; AElementIndex: integer);
//function ExtractValue(const s : string): string;
//function ExtractName(const s : string): string;
//function SplitNameAndValue(const s : string; var AName, AValue : string): Boolean;
//function ConvertToMixedCaseString(const s : string): string;
//function CnvWrapText(const Line, BreakStr: string; MaxWidth: Integer; Canvas :
//    TCanvas): string;
//
//function HexToInt(Value : string) : integer;
//function StringToHex(const s : string): string;
//function HexToString(const s : string): string;
//
//function StringListToTStringArray(l : TStrings): TStringArray;
//function StrToIntEx(const s : string): Integer;
//procedure StrCount(const s : string; var Alpha, Numeric : Integer);
//function MatchRegEx(const Criteria, Value : string): Boolean;
//function FormatBytes(const b : int64): string;
//
//function SoundSimilar(const s1, s2 : string): Boolean;
//
//function RemoveSymbolsAndNumbers(const s : string): string;
//
//{ String to type conversion routing with cleaning of data capabilities }
//
//function CleanStr(const s: string; const ValidChars: TCharSet): string;
//
//function CleanStrToInt(const s: string; var IsNull: Boolean): integer;
//function CleanStrToCurr(const s: string; var IsNull: Boolean): currency;
//function CleanStrToFloat(const s: string; var IsNull: Boolean): double;
//function CleanStrToDateTime(const s: string; var IsNull: Boolean): TDateTime;
//
//function IsSimpleInteger(const s: string; var AInt: Integer): boolean;
//function IsSimpleFloat(const s: string; var AFloat: Double): boolean;

//var
//  UpperArray : array [char] of char;

implementation

uses
  Windows{,{ mkRegEx, Soundex};

//const
//  _BoolToText : array [False..True] of char = ('0', '1');

//var
//  RegMatcher : TmkreExpr;

//function RemoveEscapeChars;
//var
//  j : Integer;
//begin
//  Result := s;
//  repeat
//    j := Pos (EscChar, Result);
//    if j > 0
//      then system.Delete (Result, j, 2);
//  until j <= 0;
//end;
//
//function TextToBool;
//begin
//  if Trim (Value) <> ''
//    then case Value [1] of
//      '0', 'F' : Result := False;
//      '1', 'T' : Result := True;
//      else Result := False;
//    end
//    else Result := False;
//end;
//
//function BoolToText;
//begin
//  Result := _BoolToText [Value];
//end;
//
//function EliminateChars (const s : string; const chars : TCharSet) : string;
//var
//  i : Integer;
//begin
//  Result := '';
//  for i := 1 to Length (s) do
//    if not (s [i] in chars)
//      then Result := Result + s [i];
//end;
//
//function EliminateWhiteSpaces (const s : string) : string;
//begin
//  Result := EliminateChars (s, [' ', #255, #13, #10]);
//end;
//
//function LastPartOfName (const s : String) : string;
//var
//  i : Integer;
//begin
//  Result := '';
//  for i := Length (s) downto 1 do
//   if s [i] = '.'
//     then
//     begin
//       Result := system.Copy (s, i + 1, Length (s) - i);
//       Exit;
//     end;
//  Result := s;
//end;
//
//procedure MixTStrings(Source, Dest : TStrings; FromIndex : Integer = 0);
//var
//  i, j : Integer;
//begin
//  if (Source <> nil) and (Dest <> nil)
//    then
//    begin
//      Dest.BeginUpdate;
//      try
//        for i := FromIndex to Source.Count - 1 do
//          begin
//            j := Dest.IndexOfName (Source.Names [i]);
//            if j < 0
//              then
//              begin
//                j := Dest.IndexOf (Source [i]);
//                if j < 0
//                  then Dest.Add (Source [i]);
//              end;
//          end;
//      finally
//        Dest.EndUpdate;
//      end;
//    end;
//end;
//
//function CommaList(const Items : string): string;
//begin
//  if Items <> ''
//    then Result := ',' + Items
//    else Result := '';
//end;
//
//function ListOfItems(const Items : array of string): String;
//var
//  i : integer;
//begin
//  Result := '';
//  for i := Low (Items) to High (Items) do
//    Result := Result + Items [i] + ',';
//  system.Delete (Result, Length (Result), 1);
//end;
//
//procedure RemoveBlankItems(List : TStringList);
//var
//  i : Integer;
//begin
//  List.BeginUpdate;
//  try
//    i := 0;
//    while i < List.Count do
//      if Trim (List [i]) = ''
//        then List.Delete (i)
//        else Inc (i);
//  finally
//    List.EndUpdate;
//  end;
//end;
//
//function FirstNonEmptyString(const Strs : array of string): string;
//var
//  i : Integer;
//begin
//  Result := '';
//  for i := Low (Strs) to High (Strs) do
//    if Strs [i] <> ''
//      then
//      begin
//        Result := Strs [i];
//        Exit;
//      end;
//end;
//
//function AddStrings(const Items : array of string): String;
//var
//  i : integer;
//begin
//  Result := '';
//  for i := Low (Items) to High (Items) do
//    Result := Result + Items [i];
//end;
//
//function AddStrings(const Items, Items2 : array of string): String;
//var
//  i : integer;
//begin
//  Result := '';
//  for i := Low (Items) to High (Items) do
//    Result := Result + Items [i] + Items2 [i];
//end;
//
//function IndexOf(const Items : array of string; const Item : String; 
//    CaseSensitive : boolean = false): Integer;
//var
//  i : Integer;
//  UpItem : string;
//begin
//  if not CaseSensitive
//    then UpItem := UpperCase (Item)
//    else UpItem := '';
//  Result := -1;
//  for i := Low (Items) to High (Items) do
//    if (CaseSensitive and (Items [i] = Item)) or
//       ((not CaseSensitive) and (UpperCase (Items [i]) = UpItem))
//      then
//      begin
//        Result := i;
//        Exit;
//      end;
//end;
//
//function HexDigitToInt(Ch : char) : integer;
//var
//  sb : byte;
//begin
//  sb := ord(ch);
//  if (sb >= ord('A')) and (sb <= ord('F')) then
//    Result := sb - ord('A') + 10
//  else if (sb >= ord('a')) and (sb <= ord('f')) then
//    Result := sb - ord('a') + 10
//  else if (sb >= ord('0')) and (sb <= ord('9')) then
//    Result := sb - ord('0')
//  else
//    raise Exception.Create(ch + ' is not a hex digit');
//end;
//
//function HexToInt(Value : string) : integer;
//var
//  i : integer;
//  base : integer;
//begin
//  Result := 0;
//  Value := UpperCase(Value);
//  base := 1;
//  for i := Length(Value) downto 1 do
//  begin
//    Result := Result + HexDigitToInt(Value[i])*base;
//    base := base*16
//  end;
//end;
//
//function StringToHex(const s : string): string;
//var
//  j : Integer;
//  Hex : string [2];
//begin
//  SetLength (Result, Length (s) * 2);
//  for j := 1 to Length (s) do
//    begin
//      Hex := IntToHex (Ord (s [j]), 2);
//      Move (Hex [1], Result [(j - 1) * 2 + 1], 2);
//    end;
//end;
//
//function HexToString(const s : string): string;
//var
//  i : Integer;
//  c : Char;
//  Hex : string [2];
//begin
//  SetLength (Hex, 2);
//  SetLength (Result, Length (s) div 2);
//  i := 1;
//  while i <= Length (s)  do
//    begin
//      Move (s [i], Hex [1], 2);
//      c := char (HexToInt (Hex));
//      Move (c, Result [(i + 1) div 2], 1);
//      Inc (i, 2);
//    end;
//end;
//
//function FirstPartOfName(const s : string): string;
//var
//  i : Integer;
//begin
//  Result := '';
//  for i := 1 to Length (s) do
//   if s [i] = '.'
//     then
//     begin
//       Result := system.Copy (s, 1, i - 1);
//       Exit;
//     end;
//  Result := s;
//end;
//
//function StringListToTStringArray(l : TStrings): TStringArray;
//var
//  i : Integer;
//begin
//  SetLength (Result, l.Count);
//  for i := 0 to l.Count - 1 do
//    Result [i] := l [i];
//end;
//
//function StrToIntEx(const s : string): Integer;
//begin
//  if s <> ''
//    then
//    try
//      Result := StrToInt (s);
//    except
//      on EConvertError do Result := 0;
//    end
//    else Result := 0;
//end;
//
//procedure StrCount(const s : string; var Alpha, Numeric : Integer);
//var
//  i : Integer;
//begin
//  Alpha := 0;
//  Numeric := 0;
//  for i := 0 to Length (s) do
//    if s [i] in ['0'..'9']
//      then Inc (Numeric)
//      else Inc (Alpha);
//end;
//
//function MatchRegEx(const Criteria, Value : string): Boolean;
//begin
//  with RegMatcher do
//    begin
//      Pattern := Criteria;
//      Str := Value;
//      Execute;
//      Result := Matches.Count > 0;
//    end;
//end;
//
//function ExtractValue(const s : string): string;
//var
//  p : Integer;
//begin
//  p := Pos ('=', s);
//  if p > 0
//    then Result := system.Copy (s, p + 1, Length (s) - p)
//    else Result := '';
//end;
//
//function ExtractName(const s : string): string;
//var
//  p : Integer;
//begin
//  p := Pos ('=', s);
//  if p > 0
//    then Result := system.Copy (s, 1, p - 1)
//    else Result := s;
//end;
//
//function SplitNameAndValue(const s : string; var AName, AValue : string): 
//    Boolean;
//var
//  p : Integer;
//begin
//  p := Pos ('=', s);
//  if p > 0
//    then
//    begin
//      AName := system.Copy (s, 1, p - 1);
//      AValue := system.Copy (s, p + 1, Length (s) - p);
//      Result := True;
//    end
//    else Result := False;
//end;
//
//function ConvertToMixedCaseString(const s : string): string;
//var
//  i : Integer;
//  NextUp : Boolean;
//begin
//  SetLength (Result, Length (s));
//  NextUp := True;
//  for i := 1 to Length (s) do
//    if s [i] <> ' '
//      then if NextUp
//        then
//        begin
//          Result [i] := UpCase (s [i]);
//          NextUp := False;
//        end
//        else Result [i] := LowerCase (s [i])[1]
//      else
//      begin
//        NextUp := True;
//        Result [i] := ' ';
//      end;
//end;
//
//function FormatBytes(const b : int64): string;
//const
//  Units : array[0..4] of string[5] = ('Bytes', 'KB', 'MB', 'GB', 'TB');
//var
//  I : double;
//  UnitType : byte;
//begin
//  i := b div 1024;
//  UnitType := 1;
//  while i > 1024 do
//    begin
//      i := i / 1024;
//      Inc(UnitType);
//    end;
//  if i <= 0 then
//    Result := IntToStr(b) + ' ' + Units[UnitType-1]
//  else
//    Result := FloatToStrF(i, ffNumber, 15, 2) + ' ' + Units[UnitType]
//end;
//
//function RemoveSymbolsAndNumbers(const s : string): string;
//var
//  i : Integer;
//begin
//  Result := '';
//  for i := 1 to Length (s) do
//    if s [i] in ['a'..'z', 'A'..'Z']
//      then Result := Result + s [i];
//end;
//
//function SoundSimilar(const s1, s2 : string): Boolean;
//var
//  Res : integer;
//begin
//  Res := _SoundSimilar (PChar (s1), PChar (s2));
//  if Res < 0
//    then raise Exception.Create ('There was an error calling c function _SoundSimilar')
//    else Result := Res <> 0;
//end;
//
//function QuotedListOfItems(const Items : array of string): String;
//var
//  i : integer;
//begin
//  Result := '';
//  for i := Low (Items) to High (Items) do
//    Result := Result + '''' + Items [i] + ''',';
//  system.Delete (Result, Length (Result), 1);
//end;
//
//function CnvWrapText(const Line, BreakStr: string; MaxWidth: Integer; Canvas :
//    TCanvas): string;
//const
//  QuoteChars = ['''', '"'];
//var
//  Pos: Integer;
//  LinePos, LineLen: Integer;
//  BreakLen, OldBreakPos, BreakPos: Integer;
//  QuoteChar, CurChar: Char;
//  ExistingBreak: Boolean;
//  BreakChars : set of char;
//  procedure CheckBreak;
//  begin
//    if not (QuoteChar in QuoteChars) and (ExistingBreak or
//        ((Canvas.TextWidth (system.copy (Line, LinePos, BreakPos - LinePos + 1)) >= MaxWidth) and
//         (BreakPos > LinePos))) then
//      begin
//        BreakPos := OldBreakPos;
//        pos := BreakPos;
//        Result := Result + Copy(Line, LinePos, BreakPos - LinePos + 1);
//        if not (CurChar in QuoteChars) then
//          while (Pos <= LineLen) and (Line[Pos] in BreakChars + [#13, #10]) do Inc(Pos);
//        if not ExistingBreak and (Pos < LineLen) then
//          Result := Result + BreakStr;
//        Inc(BreakPos);
//        LinePos := BreakPos;
//        ExistingBreak := False;
//      end;
//  end;
//begin
//  BreakChars := ['.', ' ',#9,'-'];
//  Pos := 1;
//  LinePos := 1;
//  BreakPos := 0;
//  OldBreakPos := 0;
//  QuoteChar := ' ';
//  ExistingBreak := False;
//  LineLen := Length(Line);
//  BreakLen := Length(BreakStr);
//  Result := '';
//  while Pos <= LineLen do
//  begin
//    CurChar := Line[Pos];
//    if CurChar in LeadBytes then
//    begin
//      Inc(Pos);
//    end else
//      if CurChar = BreakStr[1] then
//      begin
//        if QuoteChar = ' ' then
//        begin
//          ExistingBreak := CompareText(BreakStr, Copy(Line, Pos, BreakLen)) = 0;
//          if ExistingBreak then
//          begin
//            Inc(Pos, BreakLen-1);
//            OldBreakPos := BreakPos;
//            BreakPos := Pos;
//          end;
//        end
//      end
//      else if CurChar in BreakChars then
//      begin
//        if QuoteChar = ' '
//          then
//          begin
//            OldBreakPos := BreakPos;
//            BreakPos := Pos;
//          end;
//      end
//      else if CurChar in QuoteChars then
//        if CurChar = QuoteChar then
//          QuoteChar := ' '
//        else if QuoteChar = ' ' then
//          QuoteChar := CurChar;
//    Inc(Pos);
//    CheckBreak;
//  end;
//  OldBreakPos := BreakPos;
//  BreakPos := Pos;
//  CheckBreak;
//  Result := Result + Copy(Line, LinePos, MaxInt);
//end;
//
//function CleanStr(const s: string; const ValidChars: TCharSet): string;
//var
//  i, j : integer;
//begin
//  SetLength (Result, length (s));
//  j := 0;
//  for i := 1 to length (s) do
//    if s [i] in ValidChars
//      then
//      begin
//        inc (j);
//        Result [j] := s [i];
//      end;
//  SetLength (Result, j);
//end;
//
//function CleanStrToInt(const s: string; var IsNull: Boolean): integer;
//var
//  AStr : string;
//begin
//  AStr := Trim (s);
//  IsNull := AStr = '';
//  if not IsNull
//    then Result := StrToInt (CleanStr (AStr, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']))
//    else Result := 0;
//end;
//
//function CleanStrToCurr(const s: string; var IsNull: Boolean): currency;
//var
//  AStr : string;
//begin
//  AStr := Trim (s);
//  IsNull := AStr = '';
//  if not IsNull
//    then Result := StrToCurr (CleanStr (AStr, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.']))
//    else Result := 0.0;
//end;
//
//function CleanStrToFloat(const s: string; var IsNull: Boolean): double;
//var
//  AStr : string;
//begin
//  AStr := Trim (s);
//  IsNull := AStr = '';
//  if not IsNull
//    then Result := StrToFloat (CleanStr (AStr, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.']))
//    else Result := 0.0;
//end;
//
//function CleanStrToDateTime(const s: string; var IsNull: Boolean): TDateTime;
//var
//  AStr : string;
//begin
//  AStr := Trim (s);
//  IsNull := AStr = '';
//  if not IsNull
//    then Result := StrToDateTime (s)
//    else Result := 0.0;
//end;
//
//procedure DeleteFromArray(var Items: TStringArray; AElementIndex: integer);
//var
//  i : integer;
//begin
//  for i := AElementIndex to length (Items) - 2 do
//    Items [i] := Items [i + 1];
//  SetLength (Items, length (Items) - 1);
//end;
//
//function IsSimpleFloat(const s: string; var AFloat: Double): boolean;
//var
//  i : integer;
//begin
//  Result := False;
//  for i := 1 to length (s) do
//    if ((s [i] < '0') or (s [i] > '9')) and (s [i] <> '.')
//      then exit;
//  try
//    AFloat := StrToFloat (s);
//    Result := True;
//  except
//  end;
//end;
//
//function IsSimpleInteger(const s: string; var AInt: Integer): boolean;
//var
//  i : integer;
//begin
//  Result := False;
//  for i := 1 to length (s) do
//    if (s [i] < '0') or (s [i] > '9')
//      then exit;
//  try
//    AInt := StrToInt (s);
//    Result := True;
//  except
//  end;
//end;

{ TAdvStringList }


constructor TAdvStringList.Create;
begin
  inherited Create;
  FQuoteChar := '"';
  FTokenSeparator := ',';
end;

function TAdvStringList.GetTokenizedText: string;
var
  S: string;
  P: PChar;
  I, Count: Integer;
begin
  Count := GetCount;
  if (Count = 1) and (Get(0) = '')
    then Result := FQuoteChar + FQuoteChar
    else
    begin
      Result := '';
      for I := 0 to Count - 1 do
        begin
          S := Get(I);
          P := PChar(S);
          while not (P^ in [#0, FQuoteChar, FTokenSeparator]) do
            P := CharNext(P);
          if P^ <> #0
            then S := AnsiQuotedStr(S, FQuoteChar);
          Result := Result + S + FTokenSeparator;
        end;
      System.Delete(Result, Length(Result), 1);
    end;
end;

procedure TAdvStringList.SetTokenizedText(const Value: string);
var
  P, P1: PChar;
  S: string;
begin
  BeginUpdate;
  try
    Clear;
    P := PChar(Value);
    while P^ <> #0 do
      begin
        if P^ = FQuoteChar
          then S := AnsiExtractQuotedStr(P, FQuoteChar)
          else
          begin
            P1 := P;
            while (P^ <> #0) and (P^ <> FTokenSeparator) do
              P := CharNext(P);
            SetString(S, P1, P - P1);
          end;
        Add(S);
        if not KeepBlankTokens
          then while P^ = FTokenSeparator do
            P := CharNext(P)
          else if P^ = FTokenSeparator
            then
            begin
              P := CharNext (P);
              if P^ = #0
                then Add ('');
            end;
      end;
  finally
    EndUpdate;
  end;
end;


function GeneratePWDSecutityString: string;
var
  i, x: integer;
  s1, s2: string;
begin
  s1 := Codes64;
  s2 := '';
  for i := 0 to 15 do
  begin
    x  := Random(Length(s1));
    x  := Length(s1) - x;
    s2 := s2 + s1[x];
    s1 := Copy(s1, 1,x - 1) + Copy(s1, x + 1,Length(s1));
  end;
  Result := s2;
end;

function MakeRNDString(Chars: string; Count: Integer): string;
var
  i, x: integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
  begin
    x := Length(chars) - Random(Length(chars));
    Result := Result + chars[x];
    chars := Copy(chars, 1,x - 1) + Copy(chars, x + 1,Length(chars));
  end;
end;

function EncodePWDEx(Data, SecurityString: string; MinV: Integer = 0;
  MaxV: Integer = 5): string;
var
  i, x: integer;
  s1, s2, ss: string;
begin
  if minV > MaxV then
  begin
    i := minv;
    minv := maxv;
    maxv := i;
  end;
  if MinV < 0 then MinV := 0;
  if MaxV > 100 then MaxV := 100;
  Result := '';
  if Length(SecurityString) < 16 then Exit;
  for i := 1 to Length(SecurityString) do
  begin
    s1 := Copy(SecurityString, i + 1,Length(securitystring));
    if Pos(SecurityString[i], s1) > 0 then Exit;
    if Pos(SecurityString[i], Codes64) <= 0 then Exit;
  end;
  s1 := Codes64;
  s2 := '';
  for i := 1 to Length(SecurityString) do
  begin
    x := Pos(SecurityString[i], s1);
    if x > 0 then s1 := Copy(s1, 1,x - 1) + Copy(s1, x + 1,Length(s1));
  end;
  ss := securitystring;
  for i := 1 to Length(Data) do
  begin
    s2 := s2 + ss[Ord(Data[i]) mod 16 + 1];
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
    s2 := s2 + ss[Ord(Data[i]) div 16 + 1];
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
  end;
  Result := MakeRNDString(s1, Random(MaxV - MinV) + minV + 1);
  for i := 1 to Length(s2) do Result := Result + s2[i] + MakeRNDString(s1,
      Random(MaxV - MinV) + minV);
end;

function DecodePWDEx(Data, SecurityString: string): string;
var
  i, x, x2: integer;
  s1, s2, ss: string;
begin
  Result := #1;
  if Length(SecurityString) < 16 then Exit;
  for i := 1 to Length(SecurityString) do
  begin
    s1 := Copy(SecurityString, i + 1,Length(securitystring));
    if Pos(SecurityString[i], s1) > 0 then Exit;
    if Pos(SecurityString[i], Codes64) <= 0 then Exit;
  end;
  s1 := Codes64;
  s2 := '';
  ss := securitystring;
  for i := 1 to Length(Data) do if Pos(Data[i], ss) > 0 then s2 := s2 + Data[i];
  Data := s2;
  s2   := '';
  if Length(Data) mod 2 <> 0 then Exit;
  for i := 0 to Length(Data) div 2 - 1 do
  begin
    x := Pos(Data[i * 2 + 1], ss) - 1;
    if x < 0 then Exit;
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
    x2 := Pos(Data[i * 2 + 2], ss) - 1;
    if x2 < 0 then Exit;
    x  := x + x2 * 16;
    s2 := s2 + chr(x);
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
  end;
  Result := s2;
end;
//var
//  c : char;
//
//initialization
//  RegMatcher := TmkreExpr.Create (nil);
//  RegMatcher.UseFastmap := True;
//  RegMatcher.CallProcessMessages := False;
//  for c := low (UpperArray) to high (UpperArray) do
//    UpperArray [c] := UpCase (c);
//finalization
//  FreeAndNil (RegMatcher);
end.

