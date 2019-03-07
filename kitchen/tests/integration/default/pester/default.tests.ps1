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

    Context "Default Automatic Approval Rule" {
        BeforeAll {
            $WSUServer = Get-WsusServer
        }
        it "should exist" {
            ($WSUServer.GetInstallApprovalRules() | Where {$_.Name -eq "Default Automatic Approval Rule"}) | Should -BeTrue
        }
        it "should be enabled" {
            ($WSUServer.GetInstallApprovalRules() | Where {$_.Name -eq "Default Automatic Approval Rule"}).Enabled | Should -BeTrue
        }
    }
}
