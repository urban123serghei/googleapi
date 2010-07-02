{==============================================================================|
| Project : Ararat Synapse                                       | 001.001.002 |
|==============================================================================|
| Content: Utils for FreePascal compatibility                                  |
|==============================================================================|
| Copyright (c)1999-2010, Lukas Gebauer                                        |
| All rights reserved.                                                         |
|                                                                              |
| Redistribution and use in source and binary forms, with or without           |
| modification, are permitted provided that the following conditions are met:  |
|                                                                              |
| Redistributions of source code must retain the above copyright notice, this  |
| list of conditions and the following disclaimer.                             |
|                                                                              |
| Redistributions in binary form must reproduce the above copyright notice,    |
| this list of conditions and the following disclaimer in the documentation    |
| and/or other materials provided with the distribution.                       |
|                                                                              |
| Neither the name of Lukas Gebauer nor the names of its contributors may      |
| be used to endorse or promote products derived from this software without    |
| specific prior written permission.                                           |
|                                                                              |
| THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"  |
| AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE    |
| IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE   |
| ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR  |
| ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL       |
| DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR   |
| SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER   |
| CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT           |
| LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY    |
| OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH  |
| DAMAGE.                                                                      |
|==============================================================================|
| The Initial Developer of the Original Code is Lukas Gebauer (Czech Republic).|
| Portions created by Lukas Gebauer are Copyright (c)2003-2010.                |
| All Rights Reserved.                                                         |
|==============================================================================|
| Contributor(s):                                                              |
|==============================================================================|
| History: see HISTORY.HTM from distribution package                           |
|          (Found at URL: http://www.ararat.cz/synapse/)                       |
|==============================================================================}

{:@exclude}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}
{$H+}
//old Delphi does not have MSWINDOWS define.
{$IFDEF WIN32}
  {$IFNDEF MSWINDOWS}
    {$DEFINE MSWINDOWS}
  {$ENDIF}
{$ENDIF}

unit synafpc;

interface

uses
{$IFDEF FPC}
  dynlibs, sysutils;
{$ELSE}
  {$IFDEF MSWINDOWS}
  Windows;
  {$ELSE}
  SysUtils;
  {$ENDIF}
{$ENDIF}

{$IFDEF FPC}
type
  TLibHandle = dynlibs.TLibHandle;
  
function LoadLibrary(ModuleName: PChar): TLibHandle;
function FreeLibrary(Module: TLibHandle): LongBool;
function GetProcAddress(Module: TLibHandle; Proc: PChar): Pointer;
function GetModuleFileName(Module: TLibHandle; Buffer: PChar; BufLen: Integer): Integer;
{$ELSE}
type
  {$IFDEF CIL}
  TLibHandle = Integer;
  {$ELSE}
  TLibHandle = HModule;
  {$ENDIF}
  {$IFDEF VER100}
  LongWord = DWord;
  {$ENDIF}
{$ENDIF}

procedure Sleep(milliseconds: Cardinal);


implementation

{==============================================================================}
{$IFDEF FPC}
function LoadLibrary(ModuleName: PChar): TLibHandle;
begin
  Result := dynlibs.LoadLibrary(Modulename);
end;

function FreeLibrary(Module: TLibHandle): LongBool;
begin
  Result := dynlibs.UnloadLibrary(Module);
end;

function GetProcAddress(Module: TLibHandle; Proc: PChar): Pointer;
begin
  Result := dynlibs.GetProcedureAddress(Module, Proc);
end;

function GetModuleFileName(Module: TLibHandle; Buffer: PChar; BufLen: Integer): Integer;
begin
  Result := 0;
end;

{$ELSE}
{$ENDIF}

procedure Sleep(milliseconds: Cardinal);
begin
{$IFDEF MSWINDOWS}
  {$IFDEF FPC}
  sysutils.sleep(milliseconds);
  {$ELSE}
  windows.sleep(milliseconds);
  {$ENDIF}
{$ELSE}
  sysutils.sleep(milliseconds);
{$ENDIF}

end;

end.
