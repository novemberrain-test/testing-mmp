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
def Major                   = params.Major ?: '1'
def AddPatch                = params.AddPatch ?: ''
def AddRelease              = params.AddRelease ?: ''
def WeekOfSprint            = params.WeekOfSprint ?: '2'
def Branch                  = params.Branch ?: 'master,develop,release'
def credentialsID           = 'github'
def dayOfWeekToStartSprint  = ''    // value to check so we can get the active_sprint value
def Revert                  = false
def RemovePatch             = false
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
        string(defaultValue: '1.1.1,26', description: 'fill full patch version', name: 'AddPatch', trim: true),
        string(defaultValue: '1.1.1,26', description: 'fill full release version', name: 'AddRelease', trim: true),
        string(defaultValue: '', description: 'Week Of Sprint', name: 'WeekOfSprint', trim: true),
        string(defaultValue: 'master,develop,release', description: 'branch', name: 'Branch', trim: true),
        booleanParam(defaultValue: false, description: 'revert version', name: 'Revert'),
        booleanParam(defaultValue: false, description: 'remove path', name: 'RemovePatch'),
    ]),
    pipelineTriggers([
        // cron('0 H/24 * * *'),
        // pollSCM('H H/6 * * *')
    ])
])
//  
// Enable color console
env.TERM = "xterm"
@NonCPS
def GetJsonfile(){
    Calendar now = Calendar.getInstance()
    def year = now.get(Calendar.YEAR)
    def getSprintAndMPPHotfix = params.AddPatch.tokenize(",")
    def getSprintAndMPPRelease = params.AddRelease.tokenize(",")
    def response = ["curl", "Accept: application/vnd.github.v3.raw", "https://raw.githubusercontent.com/duydoxuan/test-ray/master/ver.json"]
    def json = response.execute().text
    def jsonfile = new JsonSlurper().parseText(json)
    def jsonbuilder = new JsonBuilder(jsonfile)
    def hotfix = "hotfix/${getSprintAndMPPHotfix[0]}"
    def release = "release/${getSprintAndMPPRelease[0]}"
    def elementbuilder = new JsonBuilder()
    if (params.AddPatch){         
        def jsonhotfix = elementbuilder."${hotfix}" {
            "sprint" "sprint.${year}.${getSprintAndMPPHotfix[1]}"
            "mmp"    "${getSprintAndMPPHotfix[0]}"
        }
        jsonbuilder.content.projects."${hotfix}" = jsonhotfix["${hotfix}"]
    }else if (params.AddRelease){
        def jsonrelease = elementbuilder."${release}" {
            "sprint" "sprint.${year}.${getSprintAndMPPRelease[1]}"
            "mmp"    "${getSprintAndMPPRelease[0]}"
        }
        jsonbuilder.content.projects."${release}" = jsonhotfix["${release}"]
    } else if (params.RemovePatch){
        //remove hotfix
        ;
    }
        println jsonfile
        return jsonfile
}
GetJsonfile()

def parserJsonfile(jsonfile, revert=false){
    def mapOfElement = [:]
    def listOfMMP = []
    JsonBuilder builder = new JsonBuilder(jsonfile)
    def listBranch = branch.tokenize(",")
    builder.content.each { k,v -> 
        v.each { key,value -> 
                if (revert && value.mmp[0] == params.Major) {    
                    listOfMMP = builder.content.projects."${key}".mmp.tokenize(".")
                    mapOfElement.put(key, listOfMMP)
                    // update sprintnumber and version
                    for (i in listBranch){
                        if(key.contains(i)){
                            value.mmp[1] += 1
                    }
                }
            }
        } 
    }
    println builder.content
}

def updateSprintAndVersion (jsonfile, mapofelement, branch, patch){
    def temp = ''
    if (!patch){
    for (i in branch){
            ;
        }
    }
}

def revert(mapofelement , patch){
    ;
}
def main(){
    stage("testing"){
        parserJsonfile(GetJsonfile(), Revert)
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