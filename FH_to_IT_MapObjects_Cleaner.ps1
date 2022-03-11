<#-----------------------------------------------
Filename: FH to IT MapObjects Cleaner
Autor: Lamina#1516 (Discord)
Version: 1.0
Date: 15.01.2021
-------------------------------------------------
Short Desciption:
 o	Readies a CFG file with object coordinates generated with FeralHeart 
	for Impressive Title using FeralHeart coordinates for map objects

Requirements
 o	Basic setup of an Impressive Title server
	o	Link: https://kito.forumotion.t532-download-and-instructions-compile-your-own-it
	
 o	Your game needs to be able to read FeralHeart coordinates for map objects
	o	Link to guide: https://drive.google.1x5HAmo51SI5Qnf7iy27i11NBu5-view?usp=sharing
-----------------------------------------------#>

<#
This software is made available under the MIT License.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
#>

#Must be the first statement in a script (not counting comments)
param ($param1, [Bool]$NoPrompt=$false, [String]$Path='')

# Allow the script to run for current session
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

#############################################
################# Settings ##################
#############################################
$processMultipleFiles = $true                      # enable/disable recursive file processing (recommend value: $true)
$defaultNoPrompt = $true                           # default to no prompt
$default_source_path = Get-ChildItem $PWD          # default path to process files in
#############################################
#############################################



############### PROGRAM START ###############
# User typed a param, which does not exist or seeks help
if($param1) { 
Write-Host '---------------------' -ForegroundColor Yellow
Write-Host 'FH to IT MapObjects Cleaner

Short Desciption:
 o	Readies a CFG file with object coordinates generated with FeralHeart
	for Impressive Title using FeralHeart coordinates for map objects

Requirements
 o	Basic setup of an Impressive Title server
	o	Link: https://kito.forumotion.t532-download-and-instructions-compile-your-own-it
	
 o	Your game needs to be able to read FeralHeart coordinates for map objects
	o	Link to guide: https://drive.google.1x5HAmo51SI5Qnf7iy27i11NBu5-view?usp=sharing

Arguments:
-NoPrompt           [Bool]   Toggle prompt for entering the file path on or off (useful for automation)
-Path               [String] This will recursively search a whole directory for files to clean. Paths including white-spaces need to be enclosed in single quotes (''). Parameter -NoPrompt true must be set in order to use -Path
-Help               [String] Show help and info

Tip:
Ctrl + C                     Cancel script execution

'; Write-Host '---------------------' -ForegroundColor Yellow }

# Recursive is on, continue
if ($processMultipleFiles) {
    $test = @{}
    # Param $defaultNoPrompt true is given or Param -NoPrompt was given, continue with given default path in script
    if (($defaultNoPrompt -eq $true) -or ($NoPrompt -eq $true)) { $files = $default_source_path }

    #  Param -Path path was given
    if ($Path -ne '') { $files = $Path }

    # process files
    foreach ($file in Get-ChildItem $files -Include '*.cfg') {
        ForEach-Object { (Get-Content $file.FullName) -replace "(\w+\/)", "" | Set-Content $file.FullName }
        Write-Host 'Processing file: '$file -ForegroundColor Green
    }

    # Warn user about collisions if there are any (separate loop so it looks cleaner on screen)
    Write-Host 'Collisions found in the following file(s):' -ForegroundColor Yellow
    foreach ($file in Get-ChildItem $files) {
        Select-String -Path $file.FullName -Pattern 'CollBox', 'CollSphere' -CaseSensitive -List -Include '*.cfg'
    }
    pause
}

# No Param was given and/or defaultNoPrompt is off OR recursive is off: continue with classic mode
else {
    do {
        $src_input = Read-Host 'Enter the path to the file to clean (Default: '$default_source_path ')'

        # User pressed enter (string is $null) so take our defined default paths defined above
        if (!$src_input) { $src_input = $default_source_path }

        # Test if path exists using the Test-Path funtion
        $src_path_exists = Test-Path -Path $src_input -PathType Leaf

        # The Test-Path function returns either $true or $false. if its $true, the path exists, otherwise it doesn't
        # Lets check if the path exists
        if ($src_path_exists -eq $true) {
			
            # The path was valid so set a flag for our do-while loop
            $src_path_is_valid = $true
        }
        else {
            if ($src_path_exists -eq $false) {
                Write-Host 'Error: Could not resolve path '$src_input -ForegroundColor Red

                # Path was not valid, lets set it to false so the loop repeats
                $src_path_is_valid = $false
            }
        }

        # Show the user their entered paths and let them confirm the input
        if ($src_path_is_valid -eq $true) {
            Write-Host 'The current file to process is: '$src_input

            # Prompt user and start again if input isn't "y"
            $confirm_input = Read-Host 'Continue? [n]'
            if ($confirm_input -ne 'y') { $src_path_is_valid = $false }
        }
    # Notice the brackets around each validation, this is because otherwise the while loop would allow either $$false or $$false
    }while($src_path_is_valid -eq $false) # Do-While Loop END

    #process files
    Write-Host 'Processing file: '$src_input -ForegroundColor Red
    ForEach-Object { (Get-Content $src_input) -replace "(\w+\/)", "" | Set-Content $src_input }
    $colFound = Select-String -Path $src_input -Pattern 'Coll'
    Write-Host 'Successfully cleaned files' -ForegroundColor Green
    if ($colFound -ne '') { Write-Host 'WARNING: Collisions found in the following file(s): '$colFound -ForegroundColor Yellow }
}