import jenkins.model.*
import hudson.model.*
import org.jenkinsci.plugins.workflow.job.WorkflowJob
import org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition
import hudson.plugins.git.*
import java.util.Collections

println("Starting ec2_instance_deploy.groovy script...")

// Get Jenkins instance
def instance = Jenkins.getInstance()
def jobName = "EC2-Deployment"

// Check if the job already exists
if (instance.getItem(jobName) == null) {
    println("Creating new pipeline job: $jobName")

    // Create the new job
    def job = instance.createProject(WorkflowJob, jobName)

    // Set Job Description
    job.setDescription("AWS EC2 Instance Deployment")

    // Set GitHub Project URL
    job.addProperty(new jenkins.branch.BranchJobProperty("https://github.com/rahulswargam/awsdevops.git"))

    // Define Git Repository and Credentials
    def gitRepoUrl = "git@github.com:rahulswargam/awsdevops.git"
    def credentialsId = "ssh-key"  // Ensure this matches the credential ID set in credentials.groovy

    // Configure Git SCM for the pipeline
    def scm = new GitSCM(
            Collections.singletonList(new UserRemoteConfig(gitRepoUrl, "origin", "", credentialsId)),
            Collections.singletonList(new BranchSpec("*/master")),  // Branch Specifier
            false,  // Do not use shallow clone
            [],  // No additional behaviors
            null,  // No browser
            null,  // No git tool
            []  // No extensions
    )

    // Define the pipeline script path inside the repo
    def jenkinsfilePath = "jenkins/Jenkinsfile"

    // Define the pipeline script using SCM
    def pipelineDefinition = new CpsScmFlowDefinition(scm, jenkinsfilePath)

    // Assign pipeline definition to the job
    job.setDefinition(pipelineDefinition)

    // Save the Job
    job.save()
    println("Pipeline Job '$jobName' created successfully.")
} else {
    println("Pipeline Job '$jobName' already exists.")
}

// Save Jenkins Configuration
instance.save()