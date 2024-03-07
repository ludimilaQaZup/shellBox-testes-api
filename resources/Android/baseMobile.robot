*** Settings ***
Library            AppiumLibrary 
Library            Process

*** Variables ***
${CONFIG_PORT}  4723
${CONFIG_UDID}
${APPIUM_PATH}

*** Keywords ***
Abrir App
    Recuperar device ID
    Iniciar Servidor
    Set Appium Timeout    60
    Open Application	http://localhost:4723/wd/hub	
    ...                 automationName=UIAutomator2
    ...                 platformName=Android
    ...                	platformVersion=12.0	
    ...                 autoGrantPermissions=true 
    ...                 deviceName=${CONFIG_UDID}
    ...                	appPackage=br.com.portoseguro.experienciacliente.mundoporto.hml
    ...                 appActivity=br.com.portoseguro.superapp.ui.splash.SplashActivity

Fechar App
    Mobile Screenshot
    Sleep     10
    Close Application


Iniciar Servidor
    Recuperar path Appium

    Fechar instância na porta

    ${appium_start}=    Start Process    
    #...      /opt/homebrew/bin/appium  -p  ${CONFIG_PORT}
    ...      ${APPIUM_PATH}  -p  ${CONFIG_PORT}
    ...      shell=True  
    ...      alias=appiumserver  
    ...      stdout=${EXECDIR}/results/process/appium_stdout.txt  
    ...      stderr=${EXECDIR}/results/process/appium_stderr.txt
    Sleep    10s

Fechar instância na porta

    ${kill_port}=    Start Process    
    ...      lsof  -t  -i:4723  |  xargs  -r  kill
#   ...      npx  kill-port  ${CONFIG_PORT}
    ...      stdout=${EXECDIR}/results/process/kill_app_stdout.txt  
    ...      stderr=${EXECDIR}/results/process/kill_app_stderr.txt
    Sleep    10s

Recuperar device ID

    ${device_udid}=      Run Process    adb  shell  getprop  ro.serialno
    ${CONFIG_UDID}=      Get Variable Value    ${device_udid.stdout}
    Set Test Variable    ${CONFIG_UDID}

Recuperar path Appium

    ${appium_path}=      Run Process    which  appium
    ${APPIUM_PATH}=      Get Variable Value    ${appium_path.stdout}
    Set Test Variable    ${APPIUM_PATH}

Mobile Screenshot
    AppiumLibrary.Capture Page Screenshot

Click Mobile Element    
    [Arguments]     ${element}
    AppiumLibrary.Wait Until Element Is Visible    ${element}
    AppiumLibrary.Click Element    ${element}

Input Text Mobile Element  
    [Arguments]     ${element}    ${text}
    AppiumLibrary.Wait Until Element Is Visible    ${element}
    AppiumLibrary.Input Text    ${element}    ${text}

Wait Until Mobile Element Is Visible
    [Arguments]     ${element}
    AppiumLibrary.Wait Until Element Is Visible    ${element}

Wait Until Mobile Element Is Visible With Timeout
    [Arguments]     ${element}    ${timeout}
    AppiumLibrary.Wait Until Element Is Visible    ${element}    ${timeout}

Mobile Element Text Should Be
    [Arguments]     ${element}    ${text}
    AppiumLibrary.Wait Until Element Is Visible    ${element}
    AppiumLibrary.Element Text Should Be    ${element}    ${text}



