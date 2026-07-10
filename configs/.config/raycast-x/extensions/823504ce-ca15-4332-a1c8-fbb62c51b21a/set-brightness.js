"use strict";var $=Object.defineProperty;var T=Object.getOwnPropertyDescriptor;var V=Object.getOwnPropertyNames;var j=Object.prototype.hasOwnProperty;var k=(t,e)=>{for(var n in e)$(t,n,{get:e[n],enumerable:!0})},H=(t,e,n,r)=>{if(e&&typeof e=="object"||typeof e=="function")for(let s of V(e))!j.call(t,s)&&s!==n&&$(t,s,{get:()=>e[s],enumerable:!(r=T(e,s))||r.enumerable});return t};var W=t=>H($({},"__esModule",{value:!0}),t);var X={};k(X,{default:()=>O});module.exports=W(X);var m=require("@raycast/api");var v=require("os"),p=require("@raycast/api");var M=require("child_process"),I=require("util"),P=require("os"),f=require("fs"),a=require("@raycast/api"),d=(0,I.promisify)(M.execFile);async function y(t,e=3,n=500,r){let s;for(let i=0;i<e;i++)try{let o=await t();if(r&&!r(o))throw new Error("Validation failed");return o}catch(o){if(s=o,console.error(`Attempt ${i+1}/${e} failed:`,o),i<e-1){let u=n*Math.pow(2,i);console.log(`Retrying in ${u}ms...`),await new Promise(l=>setTimeout(l,u))}}throw s}function g(){return`${(0,P.homedir)()}/.local/bin/lunar`}function w(){let t=(0,f.existsSync)("/Applications/Lunar.app"),e=(0,f.existsSync)(g());return{app:t,cli:e}}function G(){return["/opt/homebrew/bin/brew","/usr/local/bin/brew"].find(e=>(0,f.existsSync)(e))||null}async function q(){let t=G();if(!t)return!1;try{return await d(t,["install","--cask","lunar"],{timeout:12e4}),(0,f.existsSync)("/Applications/Lunar.app")}catch{return!1}}async function J(){try{return await d("/Applications/Lunar.app/Contents/MacOS/Lunar",["install-cli"]),!0}catch{return!1}}async function C(){let t=w(),e=!1;if(!t.app){if(await(0,a.showToast)({style:a.Toast.Style.Animated,title:"Installing Lunar",message:"Running brew install --cask lunar..."}),!await q())return await(0,a.showToast)({style:a.Toast.Style.Failure,title:"Lunar Installation Failed",message:"Install Lunar to use this command",primaryAction:{title:"Open Lunar Website",onAction:()=>(0,a.open)("https://lunar.fyi/")},secondaryAction:{title:"Copy Brew Command",onAction:()=>a.Clipboard.copy("brew install --cask lunar")}}),!1;e=!0,t=w()}if(!t.cli){if(await(0,a.showToast)({style:a.Toast.Style.Animated,title:"Installing Lunar CLI",message:"One moment..."}),!await J())return await(0,a.showToast)({style:a.Toast.Style.Failure,title:"CLI Installation Failed",message:"Hover for actions",primaryAction:{title:"Copy Install Command",onAction:()=>a.Clipboard.copy("/Applications/Lunar.app/Contents/MacOS/Lunar install-cli")}}),!1;e=!0}return e&&await(0,a.showToast)({style:a.Toast.Style.Success,title:"Lunar Ready",message:"All set!"}),!0}async function x(){return y(async()=>{let t=g(),{stdout:e}=await d(t,["displays","--json"],{timeout:5e3});if(!e||e.trim()==="")throw new Error("Empty response from Lunar displays command");let n=e.trim(),r=n.indexOf("{");if(r===-1)throw new Error("No JSON found in Lunar output");let s=0,i=-1;for(let l=r;l<n.length;l++)if(n[l]==="{"&&s++,n[l]==="}"&&s--,s===0){i=l;break}if(i===-1)throw new Error("Could not find end of JSON in Lunar output");n=n.substring(r,i+1);let o=JSON.parse(n),u=[];for(let[l,h]of Object.entries(o)){let c=h;c.active&&u.push({id:c.id.toString(),name:c.name,serial:l,brightness:c.brightness,main:c.main,active:c.active,adaptive:c.adaptive||!1})}return u.sort((l,h)=>l.main&&!h.main?-1:!l.main&&h.main?1:0),u},3,500,t=>t.length>0)}async function S(){try{return await y(async()=>{let t=g(),{stdout:e}=await d(t,["displays","cursor","serial"],{timeout:3e3});if(!e||e.trim()==="")throw new Error("Empty response from Lunar cursor command");let n=e.match(/[Ss]erial:\s*(.+)/);if(n)return n[1].trim();let r=e.match(/([0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12})/i);if(r)return r[1];let s=e.trim();if(s&&!/\s/.test(s))return s;throw new Error("Could not parse serial from output")},3,300,t=>t!==null&&t.length>0)}catch(t){return console.error("Failed to get cursor display after retries:",t),null}}async function b(t){try{return await y(async()=>{let e=g(),{stdout:n}=await d(e,["displays",t,"brightness"],{timeout:3e3}),r=n.match(/brightness:\s*(\d+)/i);if(!r)throw new Error("Could not parse brightness from output");return parseInt(r[1],10)},3,300,e=>e!==null&&e>=0&&e<=100)}catch(e){return console.error(`Failed to get brightness for display ${t} after retries:`,e),null}}async function _(t,e){await y(async()=>{let n=g(),r=e?"on":"off";console.log(`Setting adaptive mode for ${t} to ${r}`),await d(n,["displays",t,"adaptive",r],{timeout:3e3}),await new Promise(s=>setTimeout(s,200))},3,300)}async function B(t,e,n){if(n){console.log(`Display ${t} has adaptive mode enabled, disabling it first...`);try{await _(t,!1),console.log(`Adaptive mode disabled for ${t}`)}catch(r){console.error(`Failed to disable adaptive mode for ${t}:`,r)}}await y(async()=>{let r=g();console.log(`Setting brightness for ${t} to ${e}%`),await d(r,["displays",t,"brightness",String(e)],{timeout:5e3}),await new Promise(o=>setTimeout(o,300));let s=await b(t);if(s===null)throw new Error("Could not verify brightness change");if(Math.abs(s-e)>2)throw new Error(`Brightness mismatch: expected ${e}%, got ${s}%`);console.log(`Verified brightness for ${t} is now ${s}%`)},5,500)}var D=require("child_process"),F=require("util"),A=require("fs"),R=require("path"),N=require("os"),U=(0,F.promisify)(D.exec),Y=`param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('get', 'set', 'offset')]
    [string]$Action,

    [Parameter(Mandatory=$false)]
    [int]$Value = 0
)

Add-Type @"
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

public class DdcControl {
    [DllImport("user32.dll")]
    public static extern bool EnumDisplayMonitors(IntPtr hdc, IntPtr lprcClip, MonitorEnumDelegate lpfnEnum, IntPtr dwData);

    [DllImport("dxva2.dll")]
    public static extern bool GetNumberOfPhysicalMonitorsFromHMONITOR(IntPtr hMonitor, out uint count);

    [DllImport("dxva2.dll")]
    public static extern bool GetPhysicalMonitorsFromHMONITOR(IntPtr hMonitor, uint count, [Out] PHYSICAL_MONITOR[] monitors);

    [DllImport("dxva2.dll")]
    public static extern bool DestroyPhysicalMonitors(uint count, [In] PHYSICAL_MONITOR[] monitors);

    [DllImport("dxva2.dll")]
    public static extern bool SetVCPFeature(IntPtr hMonitor, byte vcpCode, uint newValue);

    [DllImport("dxva2.dll")]
    public static extern bool GetVCPFeatureAndVCPFeatureReply(IntPtr hMonitor, byte vcpCode, IntPtr pvct, out uint currentValue, out uint maxValue);

    public delegate bool MonitorEnumDelegate(IntPtr hMonitor, IntPtr hdcMonitor, ref RECT lprcMonitor, IntPtr dwData);

    [StructLayout(LayoutKind.Sequential)]
    public struct RECT { public int Left, Top, Right, Bottom; }

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    public struct PHYSICAL_MONITOR {
        public IntPtr hPhysicalMonitor;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
        public string szPhysicalMonitorDescription;
    }

    public static List<IntPtr> MonitorHandles = new List<IntPtr>();

    public static bool MonitorEnumCallback(IntPtr hMonitor, IntPtr hdcMonitor, ref RECT lprcMonitor, IntPtr dwData) {
        MonitorHandles.Add(hMonitor);
        return true;
    }

    public static void EnumerateMonitors() {
        MonitorHandles.Clear();
        EnumDisplayMonitors(IntPtr.Zero, IntPtr.Zero, MonitorEnumCallback, IntPtr.Zero);
    }
}
"@

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$brightnessCode = [byte]0x10
$results = @()
$idx = 0

try {
    # --- WMI: internal / laptop displays ---
    try {
        $wmiMonitors = Get-CimInstance -Namespace root/WMI -ClassName WmiMonitorBrightness -ErrorAction Stop
        foreach ($mon in $wmiMonitors) {
            $entry = @{
                type = 'wmi'
                index = $idx
                description = $mon.InstanceName
                brightness = [int]$mon.CurrentBrightness
                maxBrightness = 100
                success = $true
            }

            if ($Action -in 'set', 'offset') {
                $newVal = if ($Action -eq 'set') {
                    [Math]::Max(0, [Math]::Min($Value, 100))
                } else {
                    [Math]::Max(0, [Math]::Min([int]$mon.CurrentBrightness + $Value, 100))
                }
                $methods = Get-CimInstance -Namespace root/WMI -ClassName WmiMonitorBrightnessMethods |
                    Where-Object { $_.InstanceName -eq $mon.InstanceName }
                if ($methods) {
                    $setSucceeded = $false
                    foreach ($method in $methods) {
                        $invokeResult = Invoke-CimMethod -InputObject $method -MethodName WmiSetBrightness -Arguments @{
                            Timeout = [uint32]1
                            Brightness = [byte]$newVal
                        } -ErrorAction Stop

                        if ($null -eq $invokeResult.ReturnValue -or [int]$invokeResult.ReturnValue -eq 0) {
                            $setSucceeded = $true
                        }
                    }

                    $entry['newBrightness'] = $newVal
                    $entry['setResult'] = $setSucceeded
                } else {
                    $entry['setResult'] = $false
                }
            }

            $results += $entry
            $idx++
        }
    } catch {
        # No WMI brightness support (desktop PC) - continue to DDC/CI
    }

    # --- DDC/CI: external displays ---
    try {
        [DdcControl]::EnumerateMonitors()

        foreach ($hMonitor in [DdcControl]::MonitorHandles) {
            $count = [uint32]0
            if (-not [DdcControl]::GetNumberOfPhysicalMonitorsFromHMONITOR($hMonitor, [ref]$count)) { continue }
            if ($count -eq 0) { continue }

            $physicalMonitors = New-Object DdcControl+PHYSICAL_MONITOR[] $count
            if (-not [DdcControl]::GetPhysicalMonitorsFromHMONITOR($hMonitor, $count, $physicalMonitors)) {
                continue
            }

            for ($i = 0; $i -lt $count; $i++) {
                $handle = $physicalMonitors[$i].hPhysicalMonitor
                $desc = $physicalMonitors[$i].szPhysicalMonitorDescription

                $current = [uint32]0
                $max = [uint32]0
                $getResult = [DdcControl]::GetVCPFeatureAndVCPFeatureReply($handle, $brightnessCode, [IntPtr]::Zero, [ref]$current, [ref]$max)

                if (-not $getResult) { continue }

                $entry = @{
                    type = 'ddc'
                    index = $idx
                    description = $desc
                    brightness = [int]$current
                    maxBrightness = [int]$max
                    success = $getResult
                }

                if ($Action -in 'set', 'offset') {
                    $newVal = if ($Action -eq 'set') {
                        [Math]::Max(0, [Math]::Min($Value, [int]$max))
                    } else {
                        [Math]::Max(0, [Math]::Min([int]$current + $Value, [int]$max))
                    }
                    $setResult = [DdcControl]::SetVCPFeature($handle, $brightnessCode, [uint32]$newVal)
                    $entry['newBrightness'] = $newVal
                    $entry['setResult'] = $setResult
                }

                $results += $entry
                $idx++
            }

            [DdcControl]::DestroyPhysicalMonitors($count, $physicalMonitors) | Out-Null
        }
    } catch {
        # DDC/CI not available - continue silently
    }

    $output = @{ monitors = $results; error = $null }
    Write-Output ($output | ConvertTo-Json -Depth 3 -Compress)
}
catch {
    $output = @{ monitors = @(); error = $_.Exception.Message }
    Write-Output ($output | ConvertTo-Json -Depth 3 -Compress)
    exit 1
}
`;function Z(){return(0,R.join)((0,N.tmpdir)(),"brightness-control-ddc.ps1")}function z(){let t=Z();return(0,A.writeFileSync)(t,Y,"utf-8"),t}async function K(t,e=0){let n=z(),r;try{r=(await U(`powershell -ExecutionPolicy Bypass -NoProfile -NonInteractive -File "${n}" -Action ${t} -Value ${e}`,{timeout:15e3,encoding:"utf8"})).stdout}catch(o){let u=o,l=(u.stdout||"").trim().replace(/^\uFEFF/,"");if(l)try{let c=JSON.parse(l);if(c.error)throw new Error(c.error);return c}catch{}let h=u.stderr||u.message||String(o);throw new Error(`Brightness script failed: ${h}`)}let s=r.trim().replace(/^\uFEFF/,""),i=JSON.parse(s);if(i.error)throw new Error(i.error);return i}async function E(t){return(await K("set",t)).monitors}var Q=(0,v.platform)()==="win32";async function L(t){if(Q)try{let i=await E(t);if(i.length===0)return await(0,p.showToast)({style:p.Toast.Style.Failure,title:"No Brightness-Capable Monitors Found",message:"No WMI or DDC/CI monitors detected"}),null;let o=i.find(u=>u.setResult===!0)||i[0];return{displayName:o.description||void 0,previousBrightness:o.brightness,brightness:o.newBrightness}}catch(i){return await(0,p.showToast)({style:p.Toast.Style.Failure,title:"Failed to Set Brightness",message:i instanceof Error?i.message:"An error occurred"}),null}if(!await C())return null;let e=await x();if(e.length===0)return await(0,p.showToast)({style:p.Toast.Style.Failure,title:"No Displays Found",message:"Make sure Lunar is running and displays are connected"}),null;let n=await S(),r=e.find(i=>i.serial===n);r||(r=e.find(i=>i.main)||e[0]);let s=await b(r.serial);return await B(r.serial,t,r.adaptive),{displayName:r.name,previousBrightness:s??void 0,brightness:t}}async function O(t){let{level:e}=t.arguments,n=parseInt(e,10);if(isNaN(n)){await(0,m.showToast)({style:m.Toast.Style.Failure,title:"Invalid Input",message:"Please enter a number between 1 and 100"});return}if(n<1||n>100){await(0,m.showToast)({style:m.Toast.Style.Failure,title:"Out of Range",message:"Brightness must be between 1 and 100"});return}try{let r=await L(n);if(!r)return;let s=r.brightness??n;r.displayName&&r.previousBrightness!=null?await(0,m.showHUD)(`${r.displayName}: ${r.previousBrightness}% \u2192 ${s}%`):await(0,m.showHUD)(`Brightness set to ${s}%`)}catch(r){console.error("Failed to set brightness:",r),await(0,m.showToast)({style:m.Toast.Style.Failure,title:"Failed to Set Brightness",message:r instanceof Error?r.message:"An error occurred"})}}
