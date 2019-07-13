# The brief intro cloud migration and deployment service to cloud

If you just starting involve, this good start to read. if you already inside, this were you can find what the expectation of you.
First of all, I am apologies you need to read this among of lot of documents you might be read or understand.
Overall it will try to cover in here, please pardon me if any typos or bad grammars.


### The Kick off
It will start when service squad wanna or choosen to migrate their service to the cloud, basically that just formality.
During kickoff, TPM, squad producteng, migration engineer,EM, and coach will sitting together for introduction. But let skip that explaination, in here
there will default assestment what is the service that will be migrate to the cloud like :
- What the service purpose
- What the service load traffics
- What the service dependencies (database, cache, queue, etc)
- What the service depend on (aleppo, mothership,3rd party, etc)
- What the other service depend on this service 
- How big the current data size (database, queue, cache, any)
- What language the service base on

We expect the engineer able provide these information and undefined information during this
(Do worries much, it not a test. We can always answer it later but not that 'later')


Above information might not all releavnt for new service that wanna deploy to production instead,
please mention be caution to mention in first place to lead effective conversation.

Next migration engineer, coach and TPM will help prepare what need to setup like GCP project and namesapce and create it right a way.


### Access of projects
This very important, you will need access to your new environment. But you wont automaticly get it, TPM will help you got these access by default :
- Service GCP project if have later
- Kubernetes service namespace access
- VPN preproduction
- VPN production
- OSlogin
- gitlabs cloud if not yet (minerva, management, vault and alert repo is must have)
- Datadog
- Kibana preproduction
- kibana production
- Vault service preproduction
- vault service production

Important to you and your squad to have it because in the end it will handle back to your squad.


### The process

To give bit clue what you need expect is...

```
Nothing is fixed or perfect, there always changes and improvement, you always can suggest improvement.
Don't be get upset if you suggestion not implemented straight away, we deal case by case not because we not listen.
No one have answer for everything, we work as team which everyone have they own role and knowledge.


PS: You need fill quite lot documents
```


It will start by pra setup the service to cloud like pipeline, service config value and secret, pods and dependencies sizing.
to help you a bit, here amount of information link can help you understand what will 'word language we talk about in here'

Datadog and alerting : https://bukalapak.atlassian.net/wiki/spaces/CLOUD/pages/802195505/Datadog+Monitoring+Alerting

Pipeline : https://docs.google.com/document/d/1WWIKp2oaubmMa2YlEiY_KgFsMe2PBpOEEPCPTQhF4XM/edit#

Vault : https://bukalapak.atlassian.net/wiki/spaces/CLOUD/pages/837224132/Vault

Of course link above might wont give you what actually you need to do clearly (case by case different approach).
We always can try look another service that already in cloud and have same issue concern with service we wanna bring to cloud.

It's lot of to do before you able deploy to production and send traffic to the service. These at least what need to be done :
- Deployment pipeline with secret vault store and get from vault
- Deployment using config and template store and get from minerva
- Service metrics are send to datadog
- Service have good enough metrics that can tell condition of service that might affect perfomance service it self
- Useful log and send to kibana
- Dashboard for metrics
- Dashboard for logs
- Alerts setup base on important metrics
- Functional test (end to end test)
- Load test and relay production traffic
- Cutover plan

The review progress detail internally do by coach daily and publicly by managements weekly 



### Roles

#### The NPC

Consultant

```
This role are variant, one is Google another is vendor (Cloudcover)
They will work with coach and Lead to help bring the service to cloud.
The expectation is they able help us in mostly in all aspects from technology stack
Ensure give best practice or what people do outside and helping us to bring service to cloud directly
```

TPM

```
Person that responsible for project overview
The expectation is give help and resolve blocker and challange of non technical matter
Ensure the project are progressing and meet the sprint timeline
```

Coach 

```
Engineer that responsible for technical overview
The expectation is give help and suggestion technical solution or redirect to correct person to ask help
Ensure technical decision and task are correct, also a line with sprint timeline
```


#### The main character party

Since we wanna scale the knowledge of engineer about cloud environment and raise the Bukalapak engineer skill bar.
We came with approach of 3 step stone to teach and guide engineer to understand better what need to do (by doing at least minimum 3 services to cloud)


Appreantience

```
You are new to this project are simple answer to telling you in this role but not closing point after 1 round you might still appreantince
Engineer that need to learn, look and help how we bring the service to cloud
Usually it's product engineer of the service or infra person, we might ask to do help make code changes or any implementation to service other than only ask you learn and watch.
The expectation is able to help for changes to service and learn how service goes to live 
We not telling you are not good, that why you need learn even you are senior engineer. We need you understand the process.
```


Lead

```
You are already learning and now we entrust you to lead bring the service goes to cloud
Engineer that resposible for delivery progress and tasks with right way including working closely with squad engineer for bringing the service live
The expectation is able to bring services to cloud in correct manner (Metrics there and relevants, Logs is helpful, alerting, the sizing, issues and etc)
In this role, we directly pointing to you responsible for service to cloud. You need work with TPM and Coach to solve any challenge
While the description more to became main executor, the load of work can be split to team member (since the lead might not able or know anything)
By default you might need teach and help Appreantience to understand the progress or works
```


Sage

```
You might think you not this one or you might be think you are because you lead or already long enough
By default all engineer that pass Appreantience role (since it mostly 1 round) need to teach new joiner engineer regardless you lead team or not
This role more to special case where the Appreantience is unlikely stay in service cloud migration after it going live but closing where we have case we need someone able to teach and someone need to focus to the work to get thing done.
The expectation for this role is more to able to teaching and helping the work done without actually the one done it personally. The Appreantience should the one do the action and done it, not Sage.
Where the team have Sage and Lead, Both of them need work together to deliver service to cloud and teaching the Appreantience
```


Support

```
You are person purposely assign to help to bring service to cloud
The work is lot and barely can manage on time, you get assign because the team resources is not enough to handle the load.
The role more to help, not close point where the Support can also learn how the service bring to cloud.
The expectation is able to help any task given (have you heard most of support actually critical role on team?)
The role can also given to someone was Lead service migration before (this is they cool down period)
```
