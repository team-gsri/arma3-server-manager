[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $Hostname,

    [Parameter()]
    [string]
    $Password,

    [Parameter()]
    [int]
    $Players,

    [Parameter()]
    [long[]]
    $Admins,

    [Parameter()]
    [string]
    $Mission,

    [Parameter()]
    [string]
    $File
)

$PasswordAdmin = (1..32 | ForEach-Object { '{0:x2}' -f (Get-Random -Maximum 256) }) -join ''

@"
// GENERAL SETTINGS
hostname                          = "${Hostname}";
password                          = "${Password}";
maxPlayers                        = ${Players};

// ADMINISTRATION
passwordAdmin                     = "${PasswordAdmin}";
timeStampFormat                   = "full";
logFile                           = "server_console.log";
admins[]                          = { $($Admins -Join ',') };

// MISSIONS CYCLE
missionWhitelist[]                = { };
class Missions {
    class OrionProd {
        template                      = "${Mission}";
        difficulty                    = "Custom";
        };
};

// GAMEPLAY
disableVoN                        = 1;
drawingInMap                      = true;
forcedDifficulty                  = "Custom";
forceRotorLibSimulation           = 0;
motd[]                            = { "" };
motdInterval                      = 15;
persistent                        = 1;
vonCodecQuality                   = 1;
voteMissionPlayers                = 100;
voteThreshold                     = 1.00;

// SECURITY
allowedFilePatching               = 0;
allowedLoadFileExtensions[]       = {"hpp","sqs","sqf","fsm","cpp","paa","txt","xml","inc","ext","sqm","ods","fxy","lip","csv","kb","bik","bikb","html","htm","biedi","b64"};
allowedPreprocessFileExtensions[] = {"hpp","sqs","sqf","fsm","cpp","paa","txt","xml","inc","ext","sqm","ods","fxy","lip","csv","kb","bik","bikb","html","htm","biedi","b64"};
allowedHTMLLoadExtensions[]       = {"htm","html","php","xml","txt"};
BattlEye                          = 0;
doubleIdDetected                  = "";
headlessClients[]                 = {"127.0.0.1"};
kickDuplicate                     = 1;
localClient[]                     = {"127.0.0.1", "192.168.0.202"};
onUserConnected                   = "";
onUserDisconnected                = "";
onUnsignedData                    = "kick (_this select 0)";
onHackedData                      = "kick (_this select 0)";
verifySignatures                  = 0;

// TIMEOUT
votingTimeOut                     = 604800;
roleTimeOut                       = 604800;
briefingTimeOut                   = 604800;
debriefingTimeOut                 = 604800;
lobbyIdleTimeout                  = 604800;
kickTimeout[]                     = { {0, -1}, {1, 1}, {2, 1}, {3, 1} };
"@ | Set-Content $File