#!/usr/bin/env groovy
import groovy.json.*
// latestRelease  = branch.develop
// branch.develop = 
// def Node = "node_template" //ffff
//54687fcf4b9c4f9da4847682b87fc1ff
def StartDay                = params.StartDay ?: '01-01-2020'
def EndDay                  = params.EndDay ?: 'end-day'
def CurrentSprint           = params.CurrentSprint ?: ''
def Minor                   = params.Minor ?: '1'
def Major                   = params.Major ?: ''
def Patch                   = params.Patch ?: ''
def WeekOfSprint            = params.WeekOfSprint ?: '2'
def Branch                  = params.Branch ?: 'master,develop,release'
def credentialsID           = 'github'
def dayOfWeekToStartSprint  = ''    // value to check so we can get the active_sprint value
def Revert                  = false
// Pipeline properties
properties([
    // disableConcurrentBuilds(),
    buildDiscarder(logRotator(
        artifactDaysToKeepStr: '30',
        artifactNumToKeepStr: '30',
        daysToKeepStr: '60',
        numToKeepStr: '100'
    )),
    parameters([
        string(defaultValue: '01-01-2020', description: 'start of the day sprint', name: 'StartDay', trim: true),
        string(defaultValue: '01-15-2020', description: 'end of the day sprint', name: 'EndDay', trim: true),
        string(defaultValue: '', description: 'current sprint', name: 'CurrentSprint', trim: true),
        string(defaultValue: '1', description: 'minor', name: 'Minor', trim: true),
        string(defaultValue: '1', description: 'major', name: 'Major', trim: true),
        string(defaultValue: '2.2.2,5', description: 'fill full patch version', name: 'Patch', trim: true),
        string(defaultValue: '', description: 'Week Of Sprint', name: 'WeekOfSprint', trim: true),
        string(defaultValue: 'master,develop,release', description: 'branch', name: 'Branch', trim: true),
        booleanParam(defaultValue: false, description: 'revert version', name: 'Revert'),
    ]),
    pipelineTriggers([
        // cron('0 H/24 * * *'),
        // pollSCM('H H/6 * * *')
    ])
])
//  
// Enable color console
env.TERM = "xterm"

def GetJsonfile(patch){
    def getSprintAndMPP = patch.tokenize(",")
    // def respone =  httpRequest "${url} + raw/duydoxuan/test-ray/ver.json"
    // def response = httpRequest url: "https://raw.githubusercontent.com/duydoxuan/test-ray/master/ver.json"
    // def jsonfile = readJSON text : response.content
    def response = ["curl", "Accept: application/vnd.github.v3.raw", "https://raw.githubusercontent.com/duydoxuan/test-ray/master/ver.json"]
    def json = response.execute().text
    def jsonfile = new JsonSlurper().parseText(json) 
    if (patch){      
        jsonfile << ["hotfix/${getSprintAndMPP[0]}": "sprint: ${getSprintAndMPP[1]}, mmp: ${getSprintAndMPP[0]}}"]
        return JsonOutput.toJson(jsonfile)
    }
        return JsonOutput.toJson(jsonfile)
}

println GetJsonfile(Patch)
// println builder.content.projects.master = 'fdskfjhdsjhf'
def calendar(){
    Calendar now = Calendar.getInstance()
    int year = now.get(Calendar.YEAR);
    int month = now.get(Calendar.MONTH) + 1; // Note: zero based!
    return [month, year]
}
//add hotfix to version file
@NonCPS
def hotfix (jsonHotfix, patch){  
    def hotFix = new JsonBuilder()
    def getSprintAndMPP = patch.tokenize(",")
    def root = hotFix."hotfix/${getSprintAndMPP[0]}" {  
        sprint  "sprint.year.sprint"
        mmp     "${getSprintAndMPP[0]}"                      
    }
    println root
    jsonHotfix.content.getSprintAndMPP[0] = root.getSprintAndMPP[0]
    println jsonHotfix.content
}

def updateSprintAndVersion (mapofelement, branch, patch){
    def temp = ''
    if (!patch){
    for (i in branch){
            ;
        }
    }
}
def revert(mapofelement , patch){  //add paramsf later
    ;
}
@NonCPS
def parserJsonfile(branch, patch, jsonfile, major, revert=false){
    def mapOfElement = [:]
    def listOfMMP = []
    JsonBuilder builder = new JsonBuilder(jsonfile)
    def TEST = new JsonBuilder()
    def listBranch = branch.split(",") 
    builder.content.each { k,v -> 
        v.each { key,value -> 
                if (revert && value.mmp[0] == major) {       
                    listOfMMP = builder.content.projects."${key}".mmp.tokenize(".") 
                    mapOfElement.put(key, listOfMMP)
                }
    }   
        hotfix (builder, Patch)
        try {
        def root = TEST.event {  
            type  "model_output_load_init"
            status "success"                      
        }  
        builder.event = root.event
        } catch(Exception e){
            println ""
        }
    println builder.content
}
}
def main(){
    stage("testing"){
        node("master"){
    // def File = new File ("${env.WORKSPACE}/version.json}")
    parserJsonfile(Branch, Patch, GetJsonfile(), Major, Revert)
    // writeJSON file: File, json:  GetJsonfile()
    // sh 'cat version.json'  
        }
    }
}
main()
// def ParsedDayOfStart(){
//     return {
//         day: '',
//         month: '',
//         year: ''
//     }
// }

// def IsActive(){
//     return 
//     pass
// }

// def IncrementedSprintAndVersion(){
//     return {
//         mmp: '',
//         sprint: ''
//     }
// }

// def SuggestReviewer (){
//     pass
// }

// def CommitToOriginalFile() {

// }

// def parseJsonFile(){

    
// }

// def main(){
//     println GetJsonfile
// }

return this