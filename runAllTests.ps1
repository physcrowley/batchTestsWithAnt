Get-ChildItem -Directory | ForEach-Object {
    Write-Output "Running tests for $_"
    Set-Location $_
    # setup
    Try { 
        Copy-Item -Path ..\TeacherTest.java, ..\build.xml -Destination .
        ant compile -silent
        Write-Output ""
    }
    Catch {
        Write-Output ">>> $_ FAILED during setup"
    }
    # run tests
    Try { 
        java -cp bin TeacherTest
    }
    Catch {
        Write-Output ">>> $_ FAILED during execution"
    }
    # clean up
    Try { 
        Read-Host -Prompt "Press Enter to continue"
        git clean -f -d
    }
    Catch {
        Write-Output ">>> $_ FAILED during cleanup"
    }
    # reset for next item
    Set-Location ..
    Write-Output ""
}
