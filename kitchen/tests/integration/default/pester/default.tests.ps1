describe "win_wsus_demo ansible role" {

    Context "Windows features" {
        $featuresToGet = @(
            'UpdateServices'
        )

        $x = Get-WindowsFeature
        ForEach ($f in $featuresToGet)
        {
            it "$($f) feature is installed" {
                ($x | Where-Object { $_.Name -eq $f }).Installed | Should Be $true
            }
        }
    }

    Context "Folder WSUS configuration" {
        BeforeAll {
            $WUServerContentDir = 'C:\WSUSTestFolder'
            $WSUServer = Get-WsusServer
        }
        it "exists" {
            $WUServerContentDir | Should -Exist
        }
        it "is configurated in WSUS" {
            $WSUServer.GetConfiguration().LocalContentCachePath | Should Be "$WUServerContentDir\WsusContent"
        }
    }
}
