if (!(IsLoaded(".\Include.ps1"))) {. .\Include.ps1;RegisterLoaded(".\Include.ps1")}

$Path = ".\Bin\NVIDIA-ccminerenemy1.03s\ccminer.exe"
$Uri = "http://nemos.dx.am/opt/nemos/x16s.7z"

$Commands = [PSCustomObject]@{
    #"phi" = " -d $($Config.SelGPUCC)" #Phi
    #"bitcore" = " -d $($Config.SelGPUCC)" #Bitcore
    #"jha" = " -d $($Config.SelGPUCC)" #Jha
    #"blake2s" = " -d $($Config.SelGPUCC)" #Blake2s
    #"blakecoin" = " -d $($Config.SelGPUCC)" #Blakecoin
    #"vanilla" = "" #BlakeVanilla
    #"cryptonight" = " -i 10.5 -l 8x120 --bfactor=8 -d $($Config.SelGPUCC) --api-remote" #Cryptonight
    #"decred" = "" #Decred
    #"equihash" = "" #Equihash
    #"ethash" = "" #Ethash
    #"groestl" = " -d $($Config.SelGPUCC)" #Groestl
    #"hmq1725" = " -d $($Config.SelGPUCC)" #hmq1725
    #"keccak" = "" #Keccak
    #"lbry" = " -d $($Config.SelGPUCC)" #Lbry
    #"lyra2v2" = "" #Lyra2RE2
    #"lyra2z" = " -d $($Config.SelGPUCC) --api-remote --api-allow=0/0 --submit-stale" #Lyra2z
    #"myr-gr" = "" #MyriadGroestl
    #"neoscrypt" = " -d $($Config.SelGPUCC)" #NeoScrypt
    #"nist5" = "" #Nist5
    #"pascal" = "" #Pascal
    #"qubit" = "" #Qubit
    #"scrypt" = "" #Scrypt
    #"sia" = "" #Sia
    #"sib" = "" #Sib
    #"skein" = "" #Skein
    #"skunk" = " -d $($Config.SelGPUCC)" #Skunk
    #"timetravel" = " -d $($Config.SelGPUCC)" #Timetravel
    #"tribus" = " -d $($Config.SelGPUCC)" #Tribus
    #"x11" = "" #X11
    #"veltor" = "" #Veltor
    #"x11evo" = " -d $($Config.SelGPUCC)" #X11evo
    #"x17" = " -d $($Config.SelGPUCC) -N 1" #X17
    "x16s" = " -d $($Config.SelGPUCC)" #X16s(no dev fee, slighty slower than suprminer)
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "-b $($Variables.NVIDIAMinerAPITCPPort) -a $_ -o stratum+tcp://$($Pools.(Get-Algorithm($_)).Host):$($Pools.(Get-Algorithm($_)).Port) -u $($Pools.(Get-Algorithm($_)).User) -p $($Pools.(Get-Algorithm($_)).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Day}
        API = "Ccminer"
        Port = $Variables.NVIDIAMinerAPITCPPort
        Wrap = $false
        URI = $Uri
        User = $Pools.(Get-Algorithm($_)).User
    }
}
