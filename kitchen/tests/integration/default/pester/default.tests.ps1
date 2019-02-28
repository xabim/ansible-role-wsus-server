describe "win_wsus_demo ansible role" {

    Context "windows features" {
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
}
