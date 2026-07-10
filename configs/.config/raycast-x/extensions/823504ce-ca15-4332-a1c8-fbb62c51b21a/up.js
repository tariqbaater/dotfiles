"use strict";var f=Object.defineProperty;var O=Object.getOwnPropertyDescriptor;var v=Object.getOwnPropertyNames;var T=Object.prototype.hasOwnProperty;var V=(t,e)=>{for(var r in e)f(t,r,{get:e[r],enumerable:!0})},j=(t,e,r,n)=>{if(e&&typeof e=="object"||typeof e=="function")for(let s of v(e))!T.call(t,s)&&s!==r&&f(t,s,{get:()=>e[s],enumerable:!(n=O(e,s))||n.enumerable});return t};var H=t=>j(f({},"__esModule",{value:!0}),t);var Q={};V(Q,{default:()=>z});module.exports=H(Q);var L=require("@raycast/api");var N=require("os"),m=require("@raycast/api");var $=require("child_process"),b=require("util"),w=require("os"),d=require("fs"),i=require("@raycast/api"),h=(0,b.promisify)($.execFile);async function M(t,e=3,r=500,n){let s;for(let o=0;o<e;o++)try{let u=await t();if(n&&!n(u))throw new Error("Validation failed");return u}catch(u){if(s=u,console.error(`Attempt ${o+1}/${e} failed:`,u),o<e-1){let l=r*Math.pow(2,o);console.log(`Retrying in ${l}ms...`),await new Promise(a=>setTimeout(a,l))}}throw s}function g(){return`${(0,w.homedir)()}/.local/bin/lunar`}function y(){let t=(0,d.existsSync)("/Applications/Lunar.app"),e=(0,d.existsSync)(g());return{app:t,cli:e}}function k(){return["/opt/homebrew/bin/brew","/usr/local/bin/brew"].find(e=>(0,d.existsSync)(e))||null}async function W(){let t=k();if(!t)return!1;try{return await h(t,["install","--cask","lunar"],{timeout:12e4}),(0,d.existsSync)("/Applications/Lunar.app")}catch{return!1}}async function G(){try{return await h("/Applications/Lunar.app/Contents/MacOS/Lunar",["install-cli"]),!0}catch{return!1}}async function I(){let t=y(),e=!1;if(!t.app){if(await(0,i.showToast)({style:i.Toast.Style.Animated,title:"Installing Lunar",message:"Running brew install --cask lunar..."}),!await W())return await(0,i.showToast)({style:i.Toast.Style.Failure,title:"Lunar Installation Failed",message:"Install Lunar to use this command",primaryAction:{title:"Open Lunar Website",onAction:()=>(0,i.open)("https://lunar.fyi/")},secondaryAction:{title:"Copy Brew Command",onAction:()=>i.Clipboard.copy("brew install --cask lunar")}}),!1;e=!0,t=y()}if(!t.cli){if(await(0,i.showToast)({style:i.Toast.Style.Animated,title:"Installing Lunar CLI",message:"One moment..."}),!await G())return await(0,i.showToast)({style:i.Toast.Style.Failure,title:"CLI Installation Failed",message:"Hover for actions",primaryAction:{title:"Copy Install Command",onAction:()=>i.Clipboard.copy("/Applications/Lunar.app/Contents/MacOS/Lunar install-cli")}}),!1;e=!0}return e&&await(0,i.showToast)({style:i.Toast.Style.Success,title:"Lunar Ready",message:"All set!"}),!0}async function C(){return M(async()=>{let t=g(),{stdout:e}=await h(t,["displays","--json"],{timeout:5e3});if(!e||e.trim()==="")throw new Error("Empty response from Lunar displays command");let r=e.trim(),n=r.indexOf("{");if(n===-1)throw new Error("No JSON found in Lunar output");let s=0,o=-1;for(let a=n;a<r.length;a++)if(r[a]==="{"&&s++,r[a]==="}"&&s--,s===0){o=a;break}if(o===-1)throw new Error("Could not find end of JSON in Lunar output");r=r.substring(n,o+1);let u=JSON.parse(r),l=[];for(let[a,p]of Object.entries(u)){let c=p;c.active&&l.push({id:c.id.toString(),name:c.name,serial:a,brightness:c.brightness,main:c.main,active:c.active,adaptive:c.adaptive||!1})}return l.sort((a,p)=>a.main&&!p.main?-1:!a.main&&p.main?1:0),l},3,500,t=>t.length>0)}async function P(){try{return await M(async()=>{let t=g(),{stdout:e}=await h(t,["displays","cursor","serial"],{timeout:3e3});if(!e||e.trim()==="")throw new Error("Empty response from Lunar cursor command");let r=e.match(/[Ss]erial:\s*(.+)/);if(r)return r[1].trim();let n=e.match(/([0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12})/i);if(n)return n[1];let s=e.trim();if(s&&!/\s/.test(s))return s;throw new Error("Could not parse serial from output")},3,300,t=>t!==null&&t.length>0)}catch(t){return console.error("Failed to get cursor display after retries:",t),null}}async function x(t){if(!Number.isInteger(t))throw new Error("Brightness delta must be an integer");let[e,r]=await Promise.all([C(),P()]),n=e.find(l=>l.serial===r)??e.find(l=>l.main)??e[0];if(!n)throw new Error("No active display found");let s=g(),o=t>=0?`+${t}`:`${t}`;await h(s,["displays",n.serial,"brightness","--",o],{timeout:5e3});let u=Math.max(0,Math.min(100,n.brightness+t));return{name:n.name,brightness:u}}var S=require("child_process"),D=require("util"),B=require("fs"),A=require("path"),F=require("os"),q=(0,D.promisify)(S.exec),J=`param(
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
`;function _(){return(0,A.join)((0,F.tmpdir)(),"brightness-control-ddc.ps1")}function U(){let t=_();return(0,B.writeFileSync)(t,J,"utf-8"),t}async function Y(t,e=0){let r=U(),n;try{n=(await q(`powershell -ExecutionPolicy Bypass -NoProfile -NonInteractive -File "${r}" -Action ${t} -Value ${e}`,{timeout:15e3,encoding:"utf8"})).stdout}catch(u){let l=u,a=(l.stdout||"").trim().replace(/^\uFEFF/,"");if(a)try{let c=JSON.parse(a);if(c.error)throw new Error(c.error);return c}catch{}let p=l.stderr||l.message||String(u);throw new Error(`Brightness script failed: ${p}`)}let s=n.trim().replace(/^\uFEFF/,""),o=JSON.parse(s);if(o.error)throw new Error(o.error);return o}async function R(t){return(await Y("offset",t)).monitors}var Z=(0,N.platform)()==="win32";async function E(t){if(Z)try{let e=await R(t);if(e.length===0)return await(0,m.showToast)({style:m.Toast.Style.Failure,title:"No Brightness-Capable Monitors Found",message:"No WMI or DDC/CI monitors detected"}),null;let r=e.find(n=>n.setResult===!0)||e[0];return r.setResult?{displayName:r.description||void 0,brightness:r.newBrightness}:null}catch(e){return await(0,m.showToast)({style:m.Toast.Style.Failure,title:"Failed to Adjust Brightness",message:e instanceof Error?e.message:"An error occurred"}),null}if(!await I())return null;try{let e=await x(t);return{displayName:e.name,brightness:e.brightness}}catch(e){return await(0,m.showToast)({style:m.Toast.Style.Failure,title:"Failed to Adjust Brightness",message:e instanceof Error?e.message:"An error occurred"}),null}}var z=async()=>{let t=await E(10);t&&await(0,L.showHUD)(K(t,"Brightness increased"))};function K(t,e){return t.displayName&&t.brightness!=null?`${t.displayName}: ${t.brightness}%`:e}
