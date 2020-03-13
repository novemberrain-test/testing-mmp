#!/usr/bin/env groovy
// latestRelease  = branch.develop
// branch.develop = 
// def Node = "node_template" 

def StartDay        = params.StartDay ?: '01-01-2020'
def EndDay          = params.EndDay ?: 'end-day'
def CurrentSprint   = params.CurrentSprint ?: ''
def Minor           = params.Minor ?: ''
def Major           = params.Major ?: '1'
def Patch           = params.Patch ?: '0'
def WeekOfSprint    = params.WeekOfSprint ?: '2'
def Branch          = params.Branch ?: 'develop'

// Pipeline properties
properties([
    // disableConcurrentBuilds(),
    buildDiscarder(logRotator(
        artifactDaysToKeepStr: '30',
        artifactNumToKeepStr: '30',
        daysToKeepStr: '60',
        numToKeepStr: '100'
    )),
    [$class: 'CopyArtifactPermissionProperty', projectNames: ''],
    gitLabConnection('wrgitlab.int.net.nokia.com'),
    [$class: 'RebuildSettings',
        autoRebuild: false,
        rebuildDisabled: false
    ],
    parameters([
        string(defaultValue: '01-01-2020', description: 'start of the day sprint', name: 'StartDay', trim: true),
        string(defaultValue: '01-15-2020', description: 'end of the day sprint', name: 'EndDay', trim: true),
        string(defaultValue: '', description: 'current sprint', name: 'CurrentSprint', trim: true),
        string(defaultValue: '1', description: 'minor', name: 'Minor', trim: true),
        string(defaultValue: '1', description: 'major', name: 'Major', trim: true),
        string(defaultValue: '0', description: 'Patch ', name: 'Patch', trim: true),
        string(defaultValue: '', description: 'Week Of Sprint', name: 'WeekOfSprint', trim: true),
        string(defaultValue: 'develop', description: 'branch', name: 'Branch', trim: true),

        // string(defaultValue: 'cdn-dly', description: 'UTF test executors Jenkins slave node label', name: 'NODE_LABEL'),
        // string(defaultValue: 'sit-slave', description: 'Bootstrap node label, use to hold main thread of pipeline', name: 'BOOTSTRAP_NODE_LABEL'),

        // string(defaultValue: 'nmap-automation', description: 'Testsuites exist in git repo, separate by comma', name: 'SUITES', trim: true),
        // string(defaultValue: 'it-48.0-LATEST', description: 'Centos bundle', name: 'El7Bundle', trim: true),
        // string(defaultValue: 'it-48.0-LATEST', description: 'CL1 bundle', name: 'Cl1Bundle', trim: true),
        // string(defaultValue: 'ch-dc-os-dhn-90_Nightly', description: 'OpenStack credentials profile', name: 'CloudName', trim: true),
        // string(defaultValue: '2', description: 'Number DataBase appaliances (1-2)', name: 'DB_NUM', trim: true),
        // string(defaultValue: '2', description: 'Number Utility appaliances (1-2)', name: 'US_NUM', trim: true),
        // string(defaultValue: '2', description: 'Number Delivery appaliances (1-2)', name: 'DA_NUM', trim: true),
        // string(defaultValue: '120', description: 'Maximum CDN deploy time (minutes)', name: 'DEPLOY_TIMEOUT', trim: true),
        // string(defaultValue: '30', description: 'Maximum CDN destroy time (minutes)', name: 'DESTROY_TIMEOUT', trim: true),
        // string(defaultValue: '480', description: 'Maximum UTF test suite execution time (minutes)', name: 'UTF_TIMEOUT', trim: true),
        // booleanParam(defaultValue: true, description: 'Include reporting appliances', name: 'Reporting'),
        // booleanParam(defaultValue: true, description: 'Is IPv6 enabled on the CDN', name: 'IPV6'),
    ]),
    [$class: 'ThrottleJobProperty',
        categories: [],
        limitOneJobWithMatchingParams: false,
        maxConcurrentPerNode: 0,
        maxConcurrentTotal: 0,
        paramsToUseForLimit: '',
        throttleEnabled: false,
        throttleOption: 'project'
    ],
    pipelineTriggers([
        // cron('0 H/24 * * *'),
        // pollSCM('H H/6 * * *')
    ])
])
//  
// Enable color console
env.TERM = "xterm"
def URL = ''
def GetJsonfile(){
    def url   = "http://github.com"
    def token = "dL3JY3Mhqxfse9tU7pFy"
    def respone =  httpRequest "${url} + raw/duydoxuan/test-ray/ver.json"
    return jsonfile
}

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
//     pass
// }

return this