Get-ChildItem -Directory | ForEach-Object {
    Write-Output "Running tests for $_"
    Set-Location $_
    # setup
    Copy-Item -Path ..\TeacherTest.java, ..\build.xml -Destination .
    ant compile -silent
    Write-Output ""
    # run tests
    java -cp bin TeacherTest
    # clean up
    git clean -f -d
    # reset for next item
    Set-Location ..
}