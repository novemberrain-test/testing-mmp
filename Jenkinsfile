#!/usr/bin/env groovy
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper

def Minor                   = params.Minor ?: '1'
def Major                   = params.Major ?: '1'
def AddPatch                = params.AddPatch ?: ''     // will be a string like "mmp,sprint" ~ "1.9.0,5"
def AddRelease              = params.AddRelease ?: ''   // will be a string like "mmp,sprint" ~ "1.9.0,5"
def Branch                  = params.Branch ?: 'master,develop,release'
def Revert                  = false
def RemovePatch             = false
def AddItem                 = false
def CredentialsId           = ''
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
        string(defaultValue: '', description: 'fulfill patch version', name: 'AddPatch', trim: true),     // will be a string like "mmp,sprint" ~ "1.9.0,5"
        string(defaultValue: '', description: 'fulfill release version', name: 'AddRelease', trim: true), // will be a string like "mmp,sprint" ~ "1.9.0,5"
        string(defaultValue: 'master,develop,release', description: 'branch need to be updated', name: 'Branch', trim: true),
        booleanParam(defaultValue: false, description: 'revert version', name: 'Revert'),
        booleanParam(defaultValue: false, description: 'remove path', name: 'RemovePatch'),
        booleanParam(defaultValue: false, description: 'add item', name: 'AddItem'),
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
        jsonbuilder.content.projects."${release}" = jsonrelease["${release}"]
    }else if (params.RemovePatch){
        //remove hotfix
        ;
    }
        return  jsonfile
}
def parserJsonfile(jsonfile, revert=false){
    def mapOfMMPSprint = [:]
    def listOfMMPSprint = []
    JsonBuilder builder = new JsonBuilder(jsonfile)
    builder.content.projects.each { key,value -> 
            if (revert && value.mmp[0] == params.Major) {    
                listOfMMPSprint = builder.content.projects."${key}".mmp.tokenize(".") ; listOfMMPSprint.addAll(builder.content.projects."${key}".sprint.tokenize("."))
                mapOfMMPSprint.put(key, listOfMMPSprint)
        }
    }
    return mapOfMMPSprint   
}

def updateSprintAndVersion (data){
    def updated = [:]
    def key = ''
    data.each { k,v -> 
        def listOfbranch = []
        number = v[5].toInteger()
        v[1] = v[1].toInteger() + 1
        // number = v[5].toInteger()
        if (number < 10){
            v[5] ='0' + (v[5].toInteger() + 1).toString()
        }else {
            v[5] = v[5].toInteger() + 1
        }
        stringSprint = v[3..5].join(".")
        stringMMP = v[0..2].join(".")
        if (k.contains('release')){
            k = k.split("/")[0] + '/' + stringMMP 
        }
    listOfbranch.addAll(stringMMP,stringSprint)
    updated.put(k, listOfbranch)
    }
    return updated
}

// def revert(mapofelement , patch){
//     ;
// }

def main(){
def jsonResult = ''
if (params.AddItem == true){
    if(!params.AddPatch && !params.AddRelease){
        println "Please help to set either the params addrelase or the params addpath"
        currentBuild.result = 'FAILURE'
        return
    }
}

    stage ("checkout"){
        node('master'){
            checkout scm
        }
    }
     if (params.AddItem == false) { 
        stage("Update version && sprint"){
            Calendar now = Calendar.getInstance()
            def year = now.get(Calendar.YEAR)
            def updated = updateSprintAndVersion(parserJsonfile(GetJsonfile(), Revert))   
            JsonBuilder builder = new JsonBuilder(GetJsonfile())    
                builder.content.projects.each { key,value -> 
                    if(key.contains('release') && value.mmp[0] == Major ) {
                    builder.content.projects.remove(key)
        }
    }
            updated.each { k,v ->
                if (k == "master" || k == "develop"){
                    builder.content.projects."${k}".mmp = updated."${k}"[0]
                    builder.content.projects."${k}".sprint = updated."${k}"[1]
                } else if (k.contains('release')) { 
                        def data= ['sprint':'', 'mmp':'']           
                        data.sprint = "${v[1]}"
                        data.mmp    = "${v[0]}"
                        builder.content.projects.put(k,data)
            }               
        }
        jsonResult = builder.toPrettyString()
        println jsonResult
    }
 }
    stage('Created PR'){
        node('master'){
            dir('test-xray'){         
            //update file version.json                  
            sh "cp ${WORKSPACE}/PullRequest.sh ."
            if(params.AddItem == true){
                JsonBuilder builder = new JsonBuilder(GetJsonfile())
                jsonResult = builder.toPrettyString()
            }
            println jsonResult
            writeJSON file: 'ver.json.pre', json: jsonResult, pretty: 5
            // git 
            checkout changelog: false, poll: false, scm: [
                $class: 'GitSCM', branches: [[name: 'jenkins']],
                doGenerateSubmoduleConfigurations: false,
                extensions: [[
                    $class: 'CloneOption',
                    noTags: true,
                    reference: '',
                    shallow: true
                ]],
                submoduleCfg: [],
                userRemoteConfigs: [[
                    credentialsId: params.CredentialsId,
                    url: 'https://github.com/novemberrain-test/test-ray.git'
                ]]
            ]
            }//dir block 
        }
    }
}
main()
return this