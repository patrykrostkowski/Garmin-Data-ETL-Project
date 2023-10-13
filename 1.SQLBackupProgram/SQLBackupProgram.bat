@ECHO off
ECHO Hello, welcome to my awsome OneClickMakingLifeEasierSQLObjectsBackupProgram.
ECHO.

SETLOCAL  enabledelayedexpansion
:: counting lines in BackupConfigFile
	SET _File=BackupConfigFile.txt
	SET /a _Lines=0
	FOR /f %%j in ('Find "" /v /c ^< %_File%') DO ( SET /a _Lines=%%j-6)
	
:: main loop, through no of lines
	@SET err=0
	FOR /l %%x in (1 , 7, %_Lines%) do (		
		SET skip=%%x
		( call )
		CALL :myInnerLoop !skip! 
	)
	ECHO.
	ECHO.
	ECHO.
	ECHO.
		
	ECHO SUCCESS -------- Backup completed successfully -------- SUCCESS
	ECHO.
	ECHO.
	PAUSE
	EXIT
	
:myInnerLoop

	SETLOCAL  enabledelayedexpansion
	SET line=1
	SET "foption=skip=!skip! tokens=2* delims=;"

	FOR /f "%foption%" %%L IN (BackupConfigFile.txt) DO (
		IF "!line!"=="1" SET Server=%%L
		IF "!line!"=="2" SET Database=%%L
		IF "!line!"=="3" SET UserID=%%L
		IF "!line!"=="4" SET Password=%%L
		IF "!line!"=="5" SET RepoBackupFolderPath=%%L
		IF "!line!"=="6" SET MainRepoFolderPath=%%L
		SET /a line+=1
	)
		:: setting helpful variables
		SET p_date=%date%
		SET CurrentDate=%p_date:.=%
		SET RepoDBFolderName=!Database!_%CurrentDate%
		SET RepoDBFolderPath=!RepoBackupFolderPath!\%RepoDBFolderName%
		ECHO This will be the destination folder path:
		ECHO %RepoDBFolderPath%
		ECHO.
		
		:: deleting previous backup versions locally
		ECHO Removing old backups locally...
		SET "sourcedir=!RepoBackupFolderPath!"
		SET "keepdir=!RepoDBFolderPath!"
		FOR /d %%a IN ("%sourcedir%\!Database!*") DO (
			::IF /i NOT "%%a"=="%keepdir%"
			RMDIR /S /Q "%%a"
			)
		ECHO.	
		
		:: deleting previous backup versions in GIT
		ECHO Removing old backups from GitHub...
		CD %MainRepoFolderPath%
		CALL git rm "%sourcedir%\!Database!*"
		ECHO.
		
		:: main part
		ECHO Hold on darling, !Database! backup is in progress...
		
		:: calling mssql-scripter with given parameteres to backup sql objects		
		CALL mssql-scripter --connection-string "Server=%server%;Database=!Database!;User Id=%userid%;Password=%password%" -f "%RepoDBFolderPath%" --script-create --exclude-headers --display-progress --file-per-object
		ECHO.
		ECHO.
		
		:: counting objects in destination backup folder.  
		FOR /f %%A IN ('DIR /a-d-s-h /b "%RepoDBFolderPath%\" ^| find /v /c ""') DO SET cnt=%%A
			ECHO Number of files created = %cnt%
			ECHO.
			
			:: if 0 it probably means some errors during scripting. Stoping whole program
			IF %cnt% EQU 0 (
				ECHO.
				ECHO.
				ECHO.
				ECHO.
				ECHO.
				ECHO ERROR -------- !Database! was not backed up properly. An error was found. Check the command output and try again. -------- ERROR
				PAUSE
				EXIT )
				
			:: if objects in folder exists, assume no error occurs	
			IF %cnt% NEQ 0 (
				CD %MainRepoFolderPath%
				CALL git add %RepoDBFolderPath%
				CALL git pull
				CALL git commit -m %date%_!Database!" backup"
				CALL git push 
				ECHO.
				ECHO.
				ECHO.
				ECHO.
				ECHO.
				ECHO.########################################################################################################
				ECHO.
				ECHO.
				ECHO.
				ECHO.
				ECHO.)
		
	:EXITmyInnerLoop
	