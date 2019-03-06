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
            $polkey = 'HKLM:\Software\Microsoft\Update Services\Server\Setup'
            $WUServerContentDir = 'C:\WSUSTestFolder'
        }
        it "exists" {
            $WUServerContentDir | Should -Exist
        }
        it "is configurated in WSUS" {
            (Get-ItemProperty -Path $polkey -Name ContentDir).ContentDir | Should Be $WUServerContentDir
        }
    }
}
